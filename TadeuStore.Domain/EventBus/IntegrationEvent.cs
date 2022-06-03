using Newtonsoft.Json;
using System.Text.Json.Serialization;

namespace TadeuStore.Domain.EventBus
{
    public class IntegrationEvent : IIntegrationEventHandler
    {
        public IntegrationEvent()
        {
            Id = Guid.NewGuid();
            CreationDate = DateTime.UtcNow;
        }

        public IntegrationEvent(Guid id, DateTime createDate)
        {
            Id = id;
            CreationDate = createDate;
        }

        [JsonProperty]
        public Guid Id { get; private init; }

        [JsonProperty]
        public DateTime CreationDate { get; private init; }
    }
}
