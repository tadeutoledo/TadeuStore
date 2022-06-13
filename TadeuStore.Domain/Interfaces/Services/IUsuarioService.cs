using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Resposta;

namespace TadeuStore.Domain.Interfaces.Services
{
    public interface IUsuarioService
    {
        Task<CadastrarUsuarioRespostaViewModel> Cadastrar(Usuario modelView);
        Task<LoginRespostaViewModel> Login(Usuario usuario);
    }
}
