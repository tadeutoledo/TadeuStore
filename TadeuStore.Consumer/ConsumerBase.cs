using FluentValidation.Results;
using Microsoft.Extensions.Hosting;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Consumer
{
    public abstract class ConsumerBase : BackgroundService
    {
        protected delegate Task<ResponseMessage> EventHandler (IIntegrationEventHandler handler);

        private readonly Dictionary<string, EventHandler> _subscriptions;

        public ConsumerBase()
        {
            _subscriptions = new Dictionary<string, EventHandler>();
        }

        protected void CarregarSubscriptions()
        {
            AddSubscription(nameof(AutorizarPagamentoIntegrationEvent), AutorizarPagamento);
        }

        protected virtual void AddSubscription(string eventName, EventHandler handle)
        {
            _subscriptions.Add(eventName, handle);
        }

        public bool HasSubscription(string eventName) => _subscriptions.ContainsKey(eventName);

        public void ExecuteEvent(string eventName, IIntegrationEventHandler @event) => _subscriptions[eventName].Invoke(@event);

        public async Task<ResponseMessage> AutorizarPagamento(IIntegrationEventHandler @event)
        {
            var eventAutorizar = @event as AutorizarPagamentoIntegrationEvent;

            TipoAutorizacaoTransacao tipoAutorizacao = TipoAutorizacaoTransacao.Aprovado;

            ValidationResult validationResult = new ValidationResult();

            switch (tipoAutorizacao)
            {
                case TipoAutorizacaoTransacao.EmProcessamento:
                    break;
                case TipoAutorizacaoTransacao.Aprovado:
                    break;
                case TipoAutorizacaoTransacao.Recusado:
                    validationResult.Errors.Add(new ValidationFailure("Recusado", "Pagamento recusado pela bandeira do cartão."));
                    break;
                default:
                    break;
            }

            Console.WriteLine($"Transação {eventAutorizar?.IdTransacao} -> {tipoAutorizacao}");

            return await Task.Run(() => new ResponseMessage(validationResult));
        }
    }
}
