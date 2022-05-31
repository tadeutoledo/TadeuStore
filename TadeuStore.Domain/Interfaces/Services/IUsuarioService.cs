using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Resposta;

namespace TadeuStore.Domain.Interfaces.Services
{
    public interface IUsuarioService
    {
        Task<CadastrarUsuarioRespostaViewModel> Adicionar(Usuario modelView);
        Task<LoginRespostaViewModel> Login(Usuario usuario);
    }
}
