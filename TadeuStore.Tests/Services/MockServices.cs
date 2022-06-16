using Bogus;
using Bogus.DataSets;
using Moq.AutoMock;
using TadeuStore.Domain.Models;
using TadeuStore.Services;
using Bogus.Extensions.Brazil;
using TadeuStore.Domain.Models.Enums;
using Xunit;

namespace TadeuStore.Tests.Services
{
    [CollectionDefinition(nameof(MockServices))]
    public class MockServices : ICollectionFixture<MockServices>, IDisposable
    {
        public readonly AutoMocker Mocker;
        public readonly UsuarioService UsuarioService;
        public readonly AplicativoService AplicativoService;

        public MockServices()
        {
            Mocker = new AutoMocker();
            UsuarioService = Mocker.CreateInstance<UsuarioService>();
            AplicativoService = Mocker.CreateInstance<AplicativoService>();
        }

        public IEnumerable<Usuario> GerarUsuariosValidos(int quantidade, bool senhaEncriptada = false)
        {
            var genero = new Faker().PickRandom<Name.Gender>();

            var usuario = new Faker<Usuario>("pt_BR")
                .StrictMode(true)
                .RuleFor(c => c.Nome, (f, c) => f.Name.FirstName(genero))
                .RuleFor(c => c.Email, (f, c) => f.Internet.Email(c.Nome.ToLower()))
                .RuleFor(c => c.Senha, (f, c) => senhaEncriptada ? BCrypt.Net.BCrypt.HashPassword(f.Internet.Password(15)) : f.Internet.Password(15))
                .RuleFor(c => c.Cpf, (f, c) => f.Person.Cpf(false))
                .RuleFor(c => c.DataNascimento, (f, c) => f.Date.Past(80, DateTime.Now.AddYears(-20)))
                .RuleFor(c => c.Sexo, (f, c) => (TipoSexo)genero)
                .RuleFor(c => c.Endereco, (f, c) => f.Address.StreetAddress())
                .RuleFor(c => c.Complemento, (f, c) => f.Address.FullAddress())
                .RuleFor(c => c.CartoesCredito, (f, c) => new List<CartaoCredito>())
                .RuleFor(c => c.Id, (f, c) => Guid.NewGuid());

            return usuario.Generate(quantidade);
        }

        public IEnumerable<Aplicativo> GerarAplicativos(int quantidade)
        {
            var aplicativo = new Faker<Aplicativo>("pt_BR")
                .StrictMode(true)
                .RuleFor(c => c.Empresa, (f, c) => f.Company.CompanyName())
                .RuleFor(c => c.Nome, (f, c) => f.Lorem.Sentence(2))
                .RuleFor(c => c.Categoria, (f, c) => f.Lorem.Sentence(1))
                .RuleFor(c => c.DataPublicacao, (f, c) => f.Date.Past(5))                
                .RuleFor(c => c.Id, (f, c) => Guid.NewGuid());

            return aplicativo.Generate(quantidade);
        }

        public IEnumerable<CartaoCredito> GerarCartaoCreditoValido(int quantidade)
        {
            var cartao = new Faker<CartaoCredito>("pt_BR")
                .RuleFor(c => c.Numero, (f, c) => f.Finance.CreditCardNumber())
                .RuleFor(c => c.NomeImpresso, (f, c) => f.Finance.AccountName())
                .RuleFor(c => c.Bandeira, (f, c) => f.PickRandom<TipoBandeiraCartao>())
                .RuleFor(c => c.DataExpiracao, (f, c) => f.Date.Future(10).ToString("MM/yyyy"))
                .RuleFor(c => c.CodigoSeguranca, (f, c) => int.Parse(f.Finance.CreditCardCvv()));

            return cartao.Generate(quantidade);
        }

        public void Dispose()
        {
            
        }
    }


}
