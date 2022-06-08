using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
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
        private readonly ILogger<RabbitMQ_Consumer> _logger;
        private IConnection _connection;
        private IModel _channel;

        public RabbitMQ_Consumer(
            ITransacaoRepository transacaoRepository,
            IConfiguration configuration,
            ILogger<RabbitMQ_Consumer> logger) 
            : base(
                  transacaoRepository, 
                  configuration)
        {
            _logger = logger;
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
                    .WaitAndRetry(3, retryAttempt => TimeSpan.FromSeconds(Math.Pow(5, retryAttempt)), (ex, time, retry) =>
                    {
                        _logger.LogWarning($"{retry} tentativa RabbitMq. Erro: {ex.Message}");
                    });

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
                _logger.LogError(-1, ex, "Falha ao iniciar o consumer RabbitMQ.");
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
                _logger.LogError(-1, ex, "Erro ao processar o evento.");
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
