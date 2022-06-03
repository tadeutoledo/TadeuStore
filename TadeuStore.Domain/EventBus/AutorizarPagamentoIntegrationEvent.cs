using Newtonsoft.Json;

namespace TadeuStore.Domain.EventBus
{
    public class AutorizarPagamentoIntegrationEvent : IntegrationEvent
    {
        public AutorizarPagamentoIntegrationEvent(Guid idAutorizacao)
        {
            IdTransacao = idAutorizacao;
        }

        [JsonProperty]
        public Guid IdTransacao { get; private init; }
    }
}
