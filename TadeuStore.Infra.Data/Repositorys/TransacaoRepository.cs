using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Infra.Data.Context;

namespace TadeuStore.Infra.Data.Repositorys
{
    public class TransacaoRepository : Repository<Transacao>, ITransacaoRepository
    {
        public TransacaoRepository(MainContext context) : base(context)
        {
        }
    }
}
