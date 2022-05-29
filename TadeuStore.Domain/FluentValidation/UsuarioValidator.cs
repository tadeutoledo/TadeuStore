using FluentValidation;
using TadeuStore.Domain.Models.Enums;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.Domain.FluentValidation
{
    public class UsuarioValidator : AbstractValidator<UsuarioRequisicaoViewModel>
    {
        public UsuarioValidator()
        {
            RuleFor(x => x.Nome)
                .NotNull().WithMessage("O campo {PropertyName} não pode ser nulo.")
                .NotEmpty().WithMessage("O campo {PropertyName} não pode estar vazio.")
                .MaximumLength(100).WithMessage("O tamanho máximo do campo {PropertyName} são de {MaxLength} caracteres.");

            RuleFor(x => x.Email)
                .EmailAddress().WithMessage("Campo {PropertyName} inválido.");

            RuleFor(x => x.Sexo)
                .IsInEnum().WithMessage("Campo {PropertyName} inválido.");

        }
    }
}
