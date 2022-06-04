using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Polly;
using Polly.Retry;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQ.Client.Exceptions;
using System.Net.Sockets;
using System.Text;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;

namespace TadeuStore.Consumer
{
    public class RabbitMQ_Consumer : ConsumerBase

    {
        const int _retryCount = 3;
        private readonly string _connectionString;
        private IConnection _connection;
        private IModel _channel;

        public RabbitMQ_Consumer(
            ITransacaoRepository transacaoRepository,
            IConfiguration configuration) 
            : base(
                  transacaoRepository, 
                  configuration)
        {
            _connectionString = configuration.GetSection("MessageBrokerConnection")?["Default"] ?? "";
        }

        protected async override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            Console.WriteLine($"Iniciando {nameof(RabbitMQ_Consumer)}...");

            CarregarSubscriptions();

            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay((int)TimeSpan.FromSeconds(3).TotalMilliseconds, stoppingToken);
            }
        }


        protected override void TryConnect()
        {
            try
            {
                if (_connection?.IsOpen ?? false)
                    return;

                var factory = new ConnectionFactory()
                {
                    HostName = _connectionString
                };

                var policy = Policy
                    .Handle<SocketException>()
                    .Or<BrokerUnreachableException>()
                    .WaitAndRetry(_retryCount, retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)), (ex, time) =>
                    {
                        Console.WriteLine("RabbitMQ Client não pode ser conectar após {TimeOut}s ({ExceptionMessage})", $"{time.TotalSeconds:n1}", ex.Message);
                    }
                );

                policy.Execute(() =>
                {
                    _connection = factory.CreateConnection();
                });

                policy.Execute(() =>
                {
                    _channel = _connection?.CreateModel();
                });

            }
            catch (Exception ex)
            {
                Console.WriteLine($"Falha ao iniciar a consumer RabbitMQ:{ex.Message}");
            }

        }

        protected override void AddSubscription(string eventName, EventHandler eventHandler)
        {
            TryConnect();

            base.AddSubscription(eventName, eventHandler);

            _channel.QueueDeclare(queue: eventName,
                                durable: false,
                                exclusive: false,
                                autoDelete: false,
                                arguments: null);

            var consumer = new EventingBasicConsumer(_channel);

            consumer.Received += Consumer_Received;

            _channel.BasicConsume(
                queue: eventName,
                autoAck: false,
                consumer: consumer);

        }

        private async void Consumer_Received(object sender, BasicDeliverEventArgs eventArgs)
        {
            var eventName = eventArgs.RoutingKey;
            var message = Encoding.UTF8.GetString(eventArgs.Body.Span);

            try
            {
                // Direcionar para o Handle do evento

                await ProcessEvent(eventName, message);

                _channel.BasicAck(eventArgs.DeliveryTag, multiple: false);
            }
            catch (Exception ex)
            {
                _channel.BasicNack(eventArgs.DeliveryTag, multiple: false, true);
                Console.WriteLine("Erro ao processo evento: " + ex.Message);
            }
        }

        private async Task<ResponseMessage> ProcessEvent(string eventName, string message)
        {
            Type type = AppDomain.CurrentDomain.GetAssemblies().SelectMany(x => x.GetTypes()).First(x => x.Name == eventName);

            var eventData = JsonConvert.DeserializeObject(message, type);

            if (HasSubscription(eventName))
            {
                var result = await ExecuteEvent(eventName, (IIntegrationEventHandler)eventData);

                if (!result.ValidationResult.IsValid)
                {
                    var errorMessage = "";
                    result.ValidationResult.Errors.ForEach(x => errorMessage += $"{x.ErrorCode} - {x.ErrorMessage} |");
                    throw new Exception(errorMessage);
                }
            }

            return await Task.Run(() => new ResponseMessage(new FluentValidation.Results.ValidationResult()));
        }

        public override void Dispose()
        {
            _channel?.Close();
            _connection?.Close();
            _channel?.Dispose();
            _connection?.Dispose();

            base.Dispose();
        }
    }
}
