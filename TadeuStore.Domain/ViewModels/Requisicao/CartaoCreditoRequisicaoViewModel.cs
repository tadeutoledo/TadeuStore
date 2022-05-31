using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Domain.ViewModels.Requisicao
{
    public class CartaoCreditoRequisicaoViewModel
    {
        public string Numero { get; set; }
        public string NomeImpresso { get; set; }
        public TipoBandeiraCartao Bandeira { get; set; }
        public string DataExpiracao { get; set; }
        public int CodigoSeguranca { get; set; }
        public bool Salvar { get; set; }
    }
}
