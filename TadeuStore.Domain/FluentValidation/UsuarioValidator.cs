using FluentValidation;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.Domain.FluentValidation
{
    public class UsuarioValidator : AbstractValidator<CadastrarUsuarioRequisicaoViewModel>
    {
        public UsuarioValidator()
        {
            RuleFor(x => x.Nome)
                .NotNull().WithMessage("O campo {PropertyName} não pode ser nulo.")
                .NotEmpty().WithMessage("O campo {PropertyName} não pode estar vazio.")
                .MaximumLength(100).WithMessage("O tamanho máximo do campo {PropertyName} é de {MaxLength} caracteres.");

            RuleFor(x => x.Email)
                .EmailAddress().WithMessage("O campo {PropertyName} está inválido.");

            RuleFor(x => x.Sexo)
                .IsInEnum().WithMessage("O campo {PropertyName} está inválido.");

            RuleFor(x => x.Cpf)
                .NotNull().WithMessage("O campo {PropertyName} não pode ser nulo.")
                .NotEmpty().WithMessage("O campo {PropertyName} não pode estar vazio.")
                .MaximumLength(11).WithMessage("O tamanho máximo do campo {PropertyName} é de {MaxLength} caracteres.")
                .MinimumLength(11).WithMessage("O tamanho mínimo do campo {PropertyName} é de {MinLength} caracteres.");

            RuleFor(x => x.Senha)
                .NotEmpty().WithMessage("O campo {PropertyName} não pode estar vazio.")
                .MinimumLength(8).WithMessage("O tamanho mínimo do campo {PropertyName} é de {MinLength} caracteres.")
                .MaximumLength(16).WithMessage("O tamanho máximo do campo {PropertyName} é de {MaxLength} caracteres.")
                .Matches(@"[A-Z]+").WithMessage("O campo {PropertyName} deve conter caracteres maiúsculos.")
                .Matches(@"[a-z]+").WithMessage("O campo {PropertyName} deve conter caracteres minúsculos.")
                .Matches(@"[0-9]+").WithMessage("O campo {PropertyName} deve conter números.")
                .Matches(@"[\!\?\*\.]+").WithMessage("O campo {PropertyName} deve conter ao menos um carecter especial (!? *.).");

            RuleFor(x => x.DataNascimento)
                .Must(DataValida).WithMessage("O campo {PropertyName} está inválido.");

            RuleFor(x => x.Cpf)
                .Must(CpfValido).WithMessage("O campo {PropertyName} está inválido."); ;

        }

        private bool CpfValido(string cpf)
        {
            return String.Join("", cpf.Where(c => Char.IsDigit(c))).Length == 11;
        }

        private bool DataValida(DateTime date)
        {
            return !date.Equals(default(DateTime));
        }
    }
}
