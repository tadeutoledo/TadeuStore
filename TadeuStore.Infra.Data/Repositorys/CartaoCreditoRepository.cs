using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Infra.Data.Context;

namespace TadeuStore.Infra.Data.Repositorys
{
    public class CartaoCreditoRepository : Repository<CartaoCredito>, ICartaoCreditoRepository
    {
        public CartaoCreditoRepository(MainContext context) : base(context)
        {
        }
    }
}
