using System.ComponentModel.DataAnnotations;

namespace TadeuStore.Domain.ViewModels
{
    public class LoginUsuarioRequisicaoViewModel
    {
        [Required(ErrorMessage = "O campo {0} é obrigatório")]
        public string Email { get; set; }

        [Required(ErrorMessage = "O campo {0} é obrigatório")]
        public string Senha { get; set; }
    }
}
