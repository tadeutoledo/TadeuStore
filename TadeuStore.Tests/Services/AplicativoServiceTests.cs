using Microsoft.AspNetCore.Http;
using Moq;
using System.Security.Claims;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using TadeuStore.Services;
using Xunit;

namespace TadeuStore.Tests.Services
{
    [Collection(nameof(MockServices))]
    public class AplicativoServiceTests
    {
        readonly MockServices _mockServices;

        public AplicativoServiceTests(
            MockServices mockServices)
        {
            _mockServices = mockServices;
        }

        [Fact(DisplayName = "Obter Todos - Sucesso consulta cache")]
        [Trait("Categoria", "Aplicativo Service Tests")]
        public async Task AplicativoService_ObterTodos_DeveExecutarComSucessoCache()
        {
            // Arrange
            var key = "Aplicativos";
            var aplicativos = _mockServices.GerarAplicativos(10);

            _mockServices.Mocker.GetMock<ICacheConnection>()
                .Setup(c => c.GetAsync<IEnumerable<Aplicativo>>(key))
                .Returns(Task.FromResult(aplicativos));

            // Act
            var result = await _mockServices.AplicativoService.ObterTodos();

            // Assert
            Assert.Equal(10, result.Count());
        }

        [Fact(DisplayName = "Obter Todos -  Sucesso consulta Sql")]
        [Trait("Categoria", "Aplicativo Service Tests")]
        public async Task AplicativoService_ObterTodos_DeveExecutarComSucessoSql()
        {
            // Arrange
            var key = "Aplicativos";
            var aplicativos = _mockServices.GerarAplicativos(10);
            var aplicativosVazio = new List<Aplicativo>();

            _mockServices.Mocker.GetMock<ICacheConnection>()
                .Setup(c => c.GetAsync<IEnumerable<Aplicativo>>(key))
                .Returns(Task.FromResult((IEnumerable<Aplicativo>)aplicativosVazio));

            _mockServices.Mocker.GetMock<IAplicativoRepository>()
                .Setup(r => r.ObterTodos())
                .Returns(Task.FromResult(aplicativos.ToList()));

            _mockServices.Mocker.GetMock<ICacheConnection>()
                .Setup(c => c.SetAsync(key, aplicativos, TimeSpan.FromMinutes(3)))
                .Returns(Task.FromResult(aplicativos));

            // Act
            var result = await _mockServices.AplicativoService.ObterTodos();

            // Assert
            Assert.Equal(10, result.Count());
        }

        [Fact(DisplayName = "Comprar -  Falha usuario não logado")]
        [Trait("Categoria", "Aplicativo Service Tests")]
        public async Task AplicativoService_Comprar_FalhaUsuarioNaoLogado()
        {
            // Arrange            
            var cartaoCredito = _mockServices.GerarCartaoCreditoValido(1).First();
            
            var usuario = _mockServices.GerarUsuariosValidos(1).First();
            cartaoCredito.Usuario = (Usuario)usuario.Clone();

            var httpContext = _mockServices.Mocker.CreateInstance<DefaultHttpContext>();

            _mockServices.Mocker.GetMock<IHttpContextAccessor>()
                .Setup(x => x.HttpContext)
                .Returns(httpContext);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(() => _mockServices.AplicativoService.Comprar(Guid.NewGuid(), 200.50M, cartaoCredito));
        }
    }
}
