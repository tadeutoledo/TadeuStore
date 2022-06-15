using Bogus;
using Bogus.DataSets;
using Moq.AutoMock;
using TadeuStore.Domain.Models;
using TadeuStore.Services;
using Bogus.Extensions.Brazil;
using TadeuStore.Domain.Models.Enums;
using Xunit;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.Tests.Domain
{
    [CollectionDefinition(nameof(MockDomains))]
    public class MockDomains : ICollectionFixture<MockDomains>, IDisposable
    {
        public readonly AutoMocker Mocker;

        public MockDomains()
        {
            Mocker = new AutoMocker();
        }

        public IEnumerable<CadastrarUsuarioRequisicaoViewModel> GerarCadastrarUsuarioValido(int quantidade, bool senhaEncriptada = false)
        {
            var genero = new Faker().PickRandom<Name.Gender>();

            var senhaSegura = "Abc!@1";

            var usuario = new Faker<CadastrarUsuarioRequisicaoViewModel>("pt_BR")
                .StrictMode(true)
                .RuleFor(c => c.Nome, (f, c) => f.Name.FirstName(genero))
                .RuleFor(c => c.Email, (f, c) => f.Internet.Email(c.Nome.ToLower()))
                .RuleFor(c => c.Senha, (f, c) => senhaEncriptada ? BCrypt.Net.BCrypt.HashPassword(f.Internet.Password(10, prefix: senhaSegura)) : f.Internet.Password(10, prefix: senhaSegura))
                .RuleFor(c => c.Cpf, (f, c) => f.Person.Cpf(false))
                .RuleFor(c => c.DataNascimento, (f, c) => f.Date.Past(80, DateTime.Now.AddYears(-20)))
                .RuleFor(c => c.Sexo, (f, c) => (TipoSexo)genero)
                .RuleFor(c => c.Endereco, (f, c) => f.Address.StreetAddress())
                .RuleFor(c => c.Complemento, (f, c) => f.Address.FullAddress());

            return usuario.Generate(quantidade);
        }

        public void Dispose()
        {
            
        }
    }


}
