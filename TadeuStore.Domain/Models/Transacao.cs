namespace TadeuStore.Domain.Models
{
    public class Transacao : Entity
    {
        public Guid UsuarioId { get; set; }
        public Usuario? Usuario { get; set; }
        public Guid AplicativoId { get; set; }
        public Aplicativo? Aplicativo { get; set; }
        public Guid? CartaoCreditoId { get; set; }
        public CartaoCredito? CartaoCredito { get; set; }
        
        public decimal ValorPago { get; set; }
        public DateTime DataHoraCompra { get; set; }
    }
}
