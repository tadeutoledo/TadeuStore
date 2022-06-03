using System.Linq.Expressions;
using TadeuStore.Domain.Models;

namespace TadeuStore.Domain.Interfaces.Repositorys
{
    public interface IRepository<TEntity> : IDisposable where TEntity : Entity
    {
        Task<TEntity> Adicionar(TEntity entity);
        Task<TEntity> ObterPorId(Guid id);
        Task<List<TEntity>> ObterTodos();
        Task Atualizar(TEntity entity);
        Task Remover(Guid id);
        Task<IEnumerable<TEntity>> Obter(Expression<Func<TEntity, bool>> expressao);
    }
}
