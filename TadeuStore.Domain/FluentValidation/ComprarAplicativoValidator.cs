using FluentValidation;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.Domain.FluentValidation
{
    public class ComprarAplicativoValidator : AbstractValidator<ComprarAplicativoRequisicaoViewModel>
    {
        public ComprarAplicativoValidator()
        {
            RuleFor(x => x.ValorPago)
            .GreaterThan(0).WithMessage("O campo {PropertyName} deve ser maior que {PropertyValue}.");
        }
    }
}
