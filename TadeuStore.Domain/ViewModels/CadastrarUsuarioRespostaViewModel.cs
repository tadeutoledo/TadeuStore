using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Domain.ViewModels
{
    public class CadastrarUsuarioRespostaViewModel
    {
        public string Nome { get; set; }
        public string Email { get; set; }
        public string Cpf { get; set; }
        public DateTime DataNascimento { get; set; }
        public TipoSexo Sexo { get; set; }
        public string Endereco { get; set; }
        public string Complemento { get; set; }

    }
}
