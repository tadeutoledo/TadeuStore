using FluentValidation;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.Domain.FluentValidation
{
    public class CartaoCreditoValidator : AbstractValidator<CartaoCreditoRequisicaoViewModel>
    {
        public CartaoCreditoValidator()
        {
            RuleFor(x => x.NomeImpresso)
            .NotNull().WithMessage("O campo {PropertyName} não pode ser nulo.")
            .NotEmpty().WithMessage("O campo {PropertyName} não pode estar vazio.")
            .MaximumLength(100).WithMessage("O tamanho máximo do campo {PropertyName} é de {MaxLength} caracteres.");

            RuleFor(x => x.Bandeira)
                .IsInEnum().WithMessage("O campo {PropertyName} está inválido.");

            RuleFor(x => x.DataExpiracao)
                .MinimumLength(7).WithMessage("O campo {PropertyName} deve estar no formado [MM/yyyy].")
                .MaximumLength(7).WithMessage("O campo {PropertyName} deve estar no formado [MM/yyyy].")
                .Must(ValidarDataExpiracao).WithMessage("O campo {PropertyName} deve estar no formado [MM/yyyy].");

            RuleFor(x => x.Numero)
                .CreditCard().WithMessage("O campo {PropertyName} está inválido.");

            RuleFor(x => x.CodigoSeguranca)
                .NotNull().WithMessage("O campo {PropertyName} não pode ser nulo.")
                .GreaterThan(0).WithMessage("O campo {PropertyName} deve ser maior que 0.");
        }

        private bool ValidarDataExpiracao(string dataExp)
        {
            string data = string.Concat("01/", dataExp);

            return DateTime.TryParse(data, out _);
        }

    }
}
