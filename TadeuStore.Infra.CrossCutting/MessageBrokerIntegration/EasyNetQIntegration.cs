using EasyNetQ;
using Polly;
using RabbitMQ.Client.Exceptions;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Models;

namespace TadeuStore.Infra.CrossCutting.ServiceBrokerIntegration
{
    public class EasyNetQIntegration
    {
        private IBus _bus;
        private readonly string _connectionString;

        public EasyNetQIntegration(string connectionString)
        {
            _connectionString = connectionString;
        }

        public bool IsConnected => _bus?.Advanced?.IsConnected ?? false;
    
        private void TryConnect()
        {
            if (IsConnected)
                return;

            var policy = Policy
                .Handle<EasyNetQException>()
                .Or<BrokerUnreachableException>()
                .WaitAndRetry(3, retry => TimeSpan.FromSeconds(retry * 3));

            policy.Execute(() => { _bus = RabbitHutch.CreateBus(_connectionString); });
        }


        public async Task<TResponse> RequestAsync<TRequest, TResponse>(TRequest request) 
            where TResponse : ResponseMessage
        {
            return await _bus.Rpc.RequestAsync<TRequest, TResponse>(request);
        }

        public void Dispose()
        {
            _bus?.Dispose();
        }

        public Task PublishAsync<T>(T message)
        {
            throw new NotImplementedException();
        }
    }
}
