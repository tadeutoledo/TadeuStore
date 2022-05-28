using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Interfaces;
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
        }

        public async Task<IEnumerable<TEntity>> ObterTodos()
        {
            return await DbSet.ToListAsync();
        }

        public void Dispose()
        {
            Db?.Dispose();
        }
    }
}
