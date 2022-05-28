using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Models;
using TadeuStore.Infra.Data.Context;

namespace TadeuStore.Infra.Data.Repositorys
{
    public class AplicaticoRepository : Repository<Aplicativo>, IAplicativoRepository
    {
        public AplicaticoRepository(MainContext context) : base(context)
        {

        }


    }
}
