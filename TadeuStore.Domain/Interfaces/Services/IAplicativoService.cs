using TadeuStore.Domain.Models;

namespace TadeuStore.Domain.Interfaces.Services
{
    public interface IAplicativoService
    {
        Task<IEnumerable<Aplicativo>> ObterTodos();
        Task Comprar(Guid id, CartaoCredito cartao, bool salvarCartao = false);
    }
}
