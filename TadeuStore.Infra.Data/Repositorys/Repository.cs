using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Infra.Data.Context;

namespace TadeuStore.Infra.Data.Repositorys
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : Entity, new()
    {
        protected readonly MainContext Db;
        protected readonly DbSet<TEntity> DbSet;

        public Repository(MainContext context)
        {
            Db = context;
            DbSet = Db.Set<TEntity>();
        }

        public virtual async Task<TEntity> Adicionar(TEntity entity)
        {
            DbSet.Add(entity);
            await SaveChanges();
            await Db.Entry(entity).GetDatabaseValuesAsync();
            return entity;
        }
        public virtual async Task Atualizar(TEntity entity)
        {
            DbSet.Update(entity);
            await SaveChanges();
        }

        public virtual async Task Remover(Guid id)
        {
            DbSet.Remove(new TEntity { Id = id });
            await SaveChanges();
        }
        public async Task<List<TEntity>> ObterTodos()
        {
            return await DbSet.ToListAsync();
        }

        public async Task<IEnumerable<TEntity>> Obter(Expression<Func<TEntity, bool>> expressao)
        {
            return await DbSet.AsNoTracking().Where(expressao).ToListAsync();
        }
        public virtual async Task<TEntity> ObterPorId(Guid id)
        {
            return await DbSet.FindAsync(id);
        }
        public async Task<int> SaveChanges()
        {
            return await Db.SaveChangesAsync();
        }

        public void Dispose()
        {
            Db?.Dispose();
        }
    }
}
