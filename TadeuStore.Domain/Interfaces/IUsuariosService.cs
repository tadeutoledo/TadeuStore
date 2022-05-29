using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.Domain.Interfaces
{
    public interface IUsuariosService
    {
        Task Adicionar(Usuario modelView);
    }
}
