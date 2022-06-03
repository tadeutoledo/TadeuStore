using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Infra.Data.Context;

namespace TadeuStore.Infra.Data.Repositorys
{
    public class UsuarioRepository : Repository<Usuario>, IUsuarioRepository
    {
        public UsuarioRepository(MainContext context) : base(context)
        {

        }

        public override async Task<Usuario> ObterPorId(Guid id)
        {
            return await DbSet
                .Include(x => x.CartoesCredito)
                .FirstOrDefaultAsync(x => x.Id == id);
        }
    }
}
