using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Domain.Models
{
    public class CartaoCredito : FormaPagamento
    {
        public Guid UsuarioId { get; set; }
        public string Numero { get; set; }
        public string NomeImpresso { get; set; }
        public TipoBandeiraCartao Bandeira { get; set; }
        public string DataExpiracao { get; set; }
        public int CodigoSeguranca { get; set; }
        public Usuario Usuario { get; set; }

        public override bool Validar()
        {
            if (Numero == null)
            {
                return false;
            }
            Numero = Numero.Replace("-", "").Replace(" ", "");

            int checksum = 0;
            bool evenDigit = false;

            foreach (char digit in Numero.Reverse())
            {
                if (digit < '0' || digit > '9')
                {
                    return false;
                }

                int digitValue = (digit - '0') * (evenDigit ? 2 : 1);
                evenDigit = !evenDigit;

                while (digitValue > 0)
                {
                    checksum += digitValue % 10;
                    digitValue /= 10;
                }
            }

            return (checksum % 10) == 0;
        }
    }
    
}
