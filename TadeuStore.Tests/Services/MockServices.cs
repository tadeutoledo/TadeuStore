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

            var cliente = new Faker<Usuario>("pt_BR")
                .CustomInstantiator(f => new Usuario())
                .RuleFor(c => c.Nome, (f, c) => f.Name.FirstName(genero));

            cliente.RuleFor(c => c.Email, (f, c) => f.Internet.Email(c.Nome.ToLower()))
                .RuleFor(c => c.Senha, (f, c) => senhaEncriptada ? BCrypt.Net.BCrypt.HashPassword(f.Internet.Password(15)) : f.Internet.Password(15))
                .RuleFor(c => c.Cpf, (f, c) => f.Person.Cpf(false))
                .RuleFor(c => c.DataNascimento, (f, c) => f.Date.Past(80, DateTime.Now.AddYears(-20)))
                .RuleFor(c => c.Sexo, (f, c) => (TipoSexo)genero)
                .RuleFor(c => c.Endereco, (f, c) => f.Address.StreetAddress())
                .RuleFor(c => c.Complemento, (f, c) => f.Address.FullAddress());

            return cliente.Generate(quantidade);
        }

        public void Dispose()
        {
            
        }
    }


}
