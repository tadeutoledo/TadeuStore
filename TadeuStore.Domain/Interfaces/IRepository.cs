using TadeuStore.Domain.Models;

namespace TadeuStore.Domain.Interfaces
{
    public interface IRepository<TEntity> : IDisposable where TEntity : Entity
    {
        Task<IEnumerable<TEntity>> ObterTodos();
    }
}
