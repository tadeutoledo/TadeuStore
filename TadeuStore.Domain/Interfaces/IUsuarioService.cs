using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.Domain.Interfaces
{
    public interface IUsuarioService
    {
        Task<CadastrarUsuarioRespostaViewModel> Adicionar(Usuario modelView);
        Task<LoginRespostaViewModel> Login(Usuario usuario);
    }
}
