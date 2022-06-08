using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Polly;
using Polly.Retry;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQ.Client.Exceptions;
using System.Net.Sockets;
using System.Text;
using System.Web;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;

namespace TadeuStore.Consumer
{
    public class RabbitMQ_Consumer : ConsumerBase

    {
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
        }


        protected override void TryConnect()
        {
            try
            {
                if (_connection?.IsOpen ?? false)
                    return;

                var factory = new ConnectionFactory()
                {
                    Uri = new Uri(_connectionString),
                    RequestedConnectionTimeout = TimeSpan.FromSeconds(30),
                    ContinuationTimeout = TimeSpan.FromSeconds(30),
                    RequestedHeartbeat = TimeSpan.FromSeconds(30),
                };

                var policy = Policy
                    .Handle<SocketException>()
                    .Or<BrokerUnreachableException>()
                    .WaitAndRetry(3, retryAttempt => TimeSpan.FromSeconds(Math.Pow(5, retryAttempt)));

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
