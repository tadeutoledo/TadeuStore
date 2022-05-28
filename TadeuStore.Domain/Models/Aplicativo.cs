namespace TadeuStore.Domain.Models
{
    public class Aplicativo : Entity
    {
        public string Nome { get; set; }
        public string Empresa { get; set; }
        public string Categoria { get; set; }
        public DateTime DataPublicacao { get; set; }
    }
}
