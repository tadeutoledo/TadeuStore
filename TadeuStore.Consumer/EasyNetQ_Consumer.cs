using EasyNetQ;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Polly;
using RabbitMQ.Client.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;

namespace TadeuStore.Consumer
{
    public class EasyNetQ_Consumer : ConsumerBase
    {
        private readonly string _connectionString;
        private IBus _bus;

        public EasyNetQ_Consumer(
            ITransacaoRepository transacaoRepository, 
            IConfiguration configuration ) 
            : base(
                  transacaoRepository,
                  configuration)
        {
            _connectionString = configuration.GetSection("MessageBrokerConnection")?["EasyNetQ"] ?? "";
        }

        protected async override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            Console.WriteLine($"Iniciando {nameof(EasyNetQ_Consumer)}...");

            CarregarSubscriptions();
        }

        protected override void TryConnect()
        {
            if (_bus?.Advanced?.IsConnected ?? false)
                return;

            var policy = Policy
                .Handle<EasyNetQException>()
                .Or<BrokerUnreachableException>()
                .WaitAndRetry(3, retryAttempt => TimeSpan.FromSeconds(Math.Pow(5, retryAttempt)));

            policy.Execute(() => { _bus = RabbitHutch.CreateBus(_connectionString); });
        }

        protected override async void AddSubscription(string eventName, EventHandler eventHandler)
        {
            TryConnect();

            base.AddSubscription(eventName, eventHandler);

            await _bus.PubSub.SubscribeAsync<IIntegrationEventHandler>(eventName, msg => ProcessEvent(eventName, msg));

        }
        private async Task<ResponseMessage> ProcessEvent(string eventName, IIntegrationEventHandler message)
        {
            if (HasSubscription(eventName))
            {
                var result = await ExecuteEvent(eventName, message);

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
            _bus?.Dispose();
            base.Dispose();
        }
    }
}
