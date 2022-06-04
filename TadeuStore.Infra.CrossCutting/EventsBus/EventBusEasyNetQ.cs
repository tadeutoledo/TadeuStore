using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Polly;
using RabbitMQ.Client.Exceptions;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.EventBus;
using EasyNetQ;
using IEventBus = TadeuStore.Domain.EventBus.IEventBus;

namespace TadeuStore.Infra.CrossCutting.EventsBus
{
    public class EventBusEasyNetQ : IEventBus
    {
        private readonly string _connectionString;
        private readonly IConfiguration _configuration;
        ILogger<EventBusEasyNetQ> _logger;
        private IBus _bus;

        public EventBusEasyNetQ(
            IConfiguration configuration,
            ILogger<EventBusEasyNetQ> logger)
        {
            _configuration = configuration;
            _logger = logger;
            _connectionString = _configuration?.GetSection("MessageBrokerConnection")?["EasyNetQ"] ?? "";
        }

        private void TryConnect()
        {
            if (_bus?.Advanced?.IsConnected ?? false)
                return;

            var policy = Policy
                .Handle<EasyNetQException>()
                .Or<BrokerUnreachableException>()
                .WaitAndRetry(3, retry => TimeSpan.FromSeconds(retry * 3), (ex, time) =>
                {
                    _logger.LogWarning(ex, "O EasyNetQ não pode ser conectar após {TimeOut}s ({ExceptionMessage})", $"{time.TotalSeconds:n1}", ex.Message);
                });

            policy.Execute(() => { _bus = RabbitHutch.CreateBus(_connectionString); });
        }

        public async void Publish(IntegrationEvent @event)
        {
            TryConnect();

            var policy = Policy
            .Handle<EasyNetQException>()
            .Or<BrokerUnreachableException>()
            .WaitAndRetry(3, retry => TimeSpan.FromSeconds(retry * 3), (ex, time) =>
            {
                _logger.LogWarning(ex, "O Publish não foi realizado: {EventId} após {Timeout}s ({ExceptionMessage})", @event.Id, $"{time.TotalSeconds:n1}", ex.Message);
            });

            await _bus.PubSub.PublishAsync<IIntegrationEventHandler>(@event);
        }

        public void Subscribe<TRequest, TResponse>()
            where TRequest : IntegrationEvent
            where TResponse : ResponseMessage
        {
            throw new NotImplementedException();
        }
        public void Dispose()
        {
            _bus?.Dispose();
        }
    }
}
