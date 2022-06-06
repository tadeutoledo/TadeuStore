using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Domain.ViewModels.Resposta
{
    public class ComprarAplicativoRespostaViewModel
    {
        public Guid Id { get; set; }
        public TipoAutorizacaoTransacao StatusAutorizacao { get; set; }
    }
}
