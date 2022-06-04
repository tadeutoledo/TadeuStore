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

namespace TadeuStore.Infra.CrossCutting.EventsBus
{
    public class EventBusRabbitMQ : IEventBus
    {
        const int _retryCount = 3;

        private readonly IConfiguration _configuration;
        private readonly string _connectionString;
        ILogger<EventBusRabbitMQ> _logger;

        private IConnection _connection;
        private IModel _channel;

        public EventBusRabbitMQ(
            IConfiguration configuration,
            ILogger<EventBusRabbitMQ> logger)
        {
            _logger = logger;
            _configuration = configuration;
            _connectionString = _configuration?.GetSection("MessageBrokerConnection")?["Default"] ?? "";
        }

        private void TryConnect()
        {
            if (_connection?.IsOpen ?? false)
                return;

            try
            {
                var factory = new ConnectionFactory()
                {
                    HostName = _connectionString,
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
                _logger.LogTrace("Publish event RabbitMQ: {EventId}", @event.Id);

                _channel.BasicPublish(
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
            //_channel.QueueDeclare(queue: QueueName,
            //                    durable: false,
            //                    exclusive: false,
            //                    autoDelete: false,
            //                    arguments: null);


            //var consumer = new EventingBasicConsumer(_channel);
            //consumer.Received += (model, ea) =>
            //{
            //    var body = ea.Body;
            //    var message = Encoding.UTF8.GetString(body.ToArray());
            //    var result = new ResponseMessage(new FluentValidation.Results.ValidationResult());
            //    if (result.ValidationResult.IsValid)
            //    {
            //        _channel.BasicAck(ea.DeliveryTag, false);
            //    }
            //};

            //_channel.BasicConsume(queue: QueueName, consumer: consumer);
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            _channel?.Close();
            _connection?.Close();
            _channel?.Dispose();
            _connection?.Dispose();
        }
    }
}
