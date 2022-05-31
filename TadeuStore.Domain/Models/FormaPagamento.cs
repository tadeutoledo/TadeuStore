namespace TadeuStore.Domain.Models
{
    public abstract class FormaPagamento : Entity
    {
        public abstract bool Validar();
    }
}
