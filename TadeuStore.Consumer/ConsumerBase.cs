using FluentValidation.Results;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Consumer
{
    public abstract class ConsumerBase : BackgroundService, IDisposable
    {
        
        private readonly ITransacaoRepository _transacaoRepository;
        private readonly IConfiguration _configuration;
        private readonly Dictionary<string, EventHandler> _subscriptions;

        protected delegate Task<ResponseMessage> EventHandler (IIntegrationEventHandler handler);

        public ConsumerBase(
            ITransacaoRepository transacaoRepository, 
            IConfiguration configuration)
        {
            _subscriptions = new Dictionary<string, EventHandler>();
            _transacaoRepository = transacaoRepository;
            _configuration = configuration;
        }

        protected abstract void TryConnect();

        protected void CarregarSubscriptions()
        {
            AddSubscription(nameof(AutorizarPagamentoIntegrationEvent), AutorizarPagamento);
        }

        protected virtual void AddSubscription(string eventName, EventHandler handle)
        {
            if (!HasSubscription(eventName))
                _subscriptions.Add(eventName, handle);
        }

        public bool HasSubscription(string eventName) => _subscriptions.ContainsKey(eventName);

        public Task<ResponseMessage> ExecuteEvent(string eventName, IIntegrationEventHandler @event) => _subscriptions[eventName].Invoke(@event);

        public async Task<ResponseMessage> AutorizarPagamento(IIntegrationEventHandler @event)
        {
            Console.WriteLine($"{nameof(AutorizarPagamento)} - Recebendo dados.");

            ValidationResult validationResult = new ValidationResult();

            try
            {
                var eventAutorizar = @event as AutorizarPagamentoIntegrationEvent;

                TipoAutorizacaoTransacao tipoAutorizacao = TipoAutorizacaoTransacao.Aprovado;

                Console.WriteLine($"Consumer: {this.GetType().Name} | Transação {eventAutorizar?.IdTransacao} -> {tipoAutorizacao}");

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
