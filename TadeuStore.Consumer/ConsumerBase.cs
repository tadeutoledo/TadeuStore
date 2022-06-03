using FluentValidation.Results;
using Microsoft.Extensions.Hosting;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Consumer
{
    public abstract class ConsumerBase : BackgroundService
    {
        private readonly ITransacaoRepository _transacaoRepository;

        protected delegate Task<ResponseMessage> EventHandler (IIntegrationEventHandler handler);

        private readonly Dictionary<string, EventHandler> _subscriptions;

        public ConsumerBase(ITransacaoRepository transacaoRepository)
        {
            _subscriptions = new Dictionary<string, EventHandler>();
            _transacaoRepository = transacaoRepository;
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

        public Task<ResponseMessage> ExecuteEvent(string eventName, IIntegrationEventHandler @event) => _subscriptions[eventName].Invoke(@event);

        public async Task<ResponseMessage> AutorizarPagamento(IIntegrationEventHandler @event)
        {
            ValidationResult validationResult = new ValidationResult();

            try
            {
                var eventAutorizar = @event as AutorizarPagamentoIntegrationEvent;

                TipoAutorizacaoTransacao tipoAutorizacao = TipoAutorizacaoTransacao.Aprovado;

                Console.WriteLine($"Transação {eventAutorizar?.IdTransacao} -> {tipoAutorizacao}");

                var transacao = await _transacaoRepository.ObterPorId(eventAutorizar.IdTransacao);

                if (transacao != null)
                {
                    transacao.StatusAutorizacao = (int)tipoAutorizacao;
                    await _transacaoRepository.Atualizar(transacao);
                }
            }
            catch(Exception ex)
            {
                validationResult.Errors.Add(new ValidationFailure(ex.Message, ex.StackTrace));
                Console.WriteLine($"Ocorreu um exceção ao executar o método {nameof(AutorizarPagamento)}: {ex.Message}");
            }

            return await Task.Run(() => new ResponseMessage(validationResult));
        }
    }
}
