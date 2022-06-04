using System.ComponentModel.DataAnnotations;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Domain.ViewModels.Requisicao
{
    public class CadastrarUsuarioRequisicaoViewModel
    {
        [Required]
        public string Nome { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Senha { get; set; }
        [Required]
        public string Cpf { get; set; }
        [Required]
        public DateTime DataNascimento { get; set; }
        [Required]
        public TipoSexo Sexo { get; set; }
        [Required]
        public string Endereco { get; set; }
        public string Complemento { get; set; }

    }
}
