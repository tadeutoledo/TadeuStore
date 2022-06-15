using Bogus;
using TadeuStore.Domain.ViewModels.Requisicao;
using Xunit;
using Bogus.Extensions.Brazil;
using TadeuStore.Domain.Models.Enums;
using TadeuStore.Domain.FluentValidation;
using Bogus.DataSets;

namespace TadeuStore.Tests.Domain
{
    [Collection(nameof(MockDomains))]
    public class DomainTests
    {
        readonly MockDomains _mockDomains;

        public DomainTests(
            MockDomains mockDomains)
        {
            _mockDomains = mockDomains;
        }

        #region ViewModels

        [Fact(DisplayName = "View Model Usuario - Sucesso")]
        [Trait("Categoria", "View Model Tests")]
        public void ViewModel_CadastrarUsuarioRequisicao_DeveValidarComSucesso()
        {
            // Arrange
            var usuario = _mockDomains.GerarCadastrarUsuarioValido(1).First();
            var validator = new UsuarioValidator();

            // Act & Assert
            Assert.True(validator.Validate(usuario).IsValid);
        }

        [Fact(DisplayName = "View Model Usuario - Falhar com senha fraca")]
        [Trait("Categoria", "View Model Tests")]
        public void ViewModel_CadastrarUsuarioRequisicao_DeveFalharDevidoASenhaFraca()
        {
            // Arrange
            var usuario = _mockDomains.GerarCadastrarUsuarioValido(1).First();
            usuario.Senha = "abc123!";
            var validator = new UsuarioValidator();

            // Act & Assert
            Assert.False(validator.Validate(usuario).IsValid);
        }

        #endregion ViewModels
    }
}
