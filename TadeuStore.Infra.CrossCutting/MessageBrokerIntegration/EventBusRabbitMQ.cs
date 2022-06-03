using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Polly;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQ.Client.Exceptions;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Models;

namespace TadeuStore.Infra.CrossCutting.ServiceBrokerIntegration
{
    public class EventBusRabbitMQ : IEventBus
    {
        const int _retryCount = 3;

        private readonly IConfiguration _configuration;
        private readonly string _connectionString;
        ILogger<EventBusRabbitMQ> _logger;

        private IConnection connection;
        private IModel channel;

        private string QueueName => "queue.autorizarpagamento";

        public EventBusRabbitMQ(
            IConfiguration configuration,
            ILogger<EventBusRabbitMQ> logger)
        {
            _logger = logger;
            _configuration = configuration;
            _connectionString = _configuration?.GetSection("MessageBrokerConnection")?["Default"] ?? "";
        }

        public bool IsConnected => connection?.IsOpen ?? false;

        private void TryConnect()
        {
            if (IsConnected)
                return;

            try
            {
                var factory = new ConnectionFactory()
                {
                    HostName = _connectionString,
                };

                var connection = factory.CreateConnection();
                channel = connection.CreateModel();

            }
            catch (Exception ex)
            {
                _logger.LogError(-1, ex, "Falha ao iniciar a integração RabbitMQ.");
            }
        }

        public void Publish(IntegrationEvent @event)
        {
            TryConnect();

            var policy = Policy.Handle<BrokerUnreachableException>()
                .Or<SocketException>()
                .WaitAndRetry(_retryCount, retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)), (ex, time) =>
                {
                    _logger.LogWarning(ex, "O Publish não foi realizado: {EventId} após {Timeout}s ({ExceptionMessage})", @event.Id, $"{time.TotalSeconds:n1}", ex.Message);
                });

            var eventName = @event.GetType().Name;

            var body = JsonSerializer.SerializeToUtf8Bytes(@event, @event.GetType(), new JsonSerializerOptions
            {
                WriteIndented = true
            });

            policy.Execute(() =>
            {
                _logger.LogTrace("Publish event do RabbitMQ: {EventId}", @event.Id);

                channel.BasicPublish(
                    exchange: "",
                    routingKey: eventName,
                    basicProperties: null,
                    body: body);
            });
        }

        public void Subscribe<TRequest, TResponse>()
            where TRequest : IntegrationEvent
            where TResponse : ResponseMessage
        {
            channel.QueueDeclare(queue: QueueName,
                                durable: false,
                                exclusive: false,
                                autoDelete: false,
                                arguments: null);


            var consumer = new EventingBasicConsumer(channel);
            consumer.Received += (model, ea) =>
            {
                var body = ea.Body;
                var message = Encoding.UTF8.GetString(body.ToArray());
                var result = new ResponseMessage(new FluentValidation.Results.ValidationResult());
                if (result.ValidationResult.IsValid)
                {
                    channel.BasicAck(ea.DeliveryTag, false);
                }
            };

            channel.BasicConsume(queue: QueueName, consumer: consumer);
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            connection?.Dispose();
            channel?.Dispose();
        }
    }
}
