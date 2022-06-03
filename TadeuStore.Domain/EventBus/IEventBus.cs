using TadeuStore.Domain.Models;

namespace TadeuStore.Domain.EventBus
{
    public interface IEventBus
    {
        void Publish(IntegrationEvent @event);

        void Subscribe<TRequest, TResponse>()
            where TRequest : IntegrationEvent
            where TResponse : ResponseMessage;
    }
}
