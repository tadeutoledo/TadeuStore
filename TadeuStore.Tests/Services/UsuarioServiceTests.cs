using Moq;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;
using Xunit;

namespace TadeuStore.Tests.Services
{ 
    [Collection(nameof(MockServices))]
    public class UsuarioServiceTests 
    {
        readonly MockServices _mockServices;

        public UsuarioServiceTests(
            MockServices mockServices)
        {
            _mockServices = mockServices;
        }

        [Fact(DisplayName = "Cadastrar Usuario - Sucesso")]
        [Trait("Categoria", "Usuario Service Tests")]
        public async Task UsuarioService_Cadastrar_DeveExecutarComSucesso()
        {
            // Arrange
            var usuario = _mockServices.GerarUsuariosValidos(1).First();

            // Act
            await _mockServices.UsuarioService.Cadastrar(usuario);

            // Assert
            _mockServices.Mocker.GetMock<IUsuarioRepository>().Verify(r => r.Adicionar(usuario), Times.Once);
        }

        [Fact(DisplayName = "Cadastrar Usuario - Falha de email já cadastrado")]
        [Trait("Categoria", "Usuario Service Tests")]
        public async Task UsuarioService_Cadastrar_DeveFalharDevidoEmailJaCadastrado()
        {
            // Arrange
            var usuarios = _mockServices.GerarUsuariosValidos(1);
            var usuario = usuarios.First();

            _mockServices.Mocker.GetMock<IUsuarioRepository>()
                .Setup(u => u.Obter(x => x.Email == usuario.Email))
                .Returns(Task.FromResult(usuarios));         

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(() => _mockServices.UsuarioService.Cadastrar(usuario));
        }

        [Fact(DisplayName = "Logar Usuario - Sucesso")]
        [Trait("Categoria", "Usuario Service Tests")]
        public async Task UsuarioService_Logar_DeveExecutarComSucesso()
        {
            //// Arrange
            var usuario = _mockServices.GerarUsuariosValidos(1).First();

            var usuarioComSenhaEncriptada = (Usuario)usuario.Clone();
            usuarioComSenhaEncriptada.Senha = BCrypt.Net.BCrypt.HashPassword(usuarioComSenhaEncriptada.Senha);

            _mockServices.Mocker.GetMock<IUsuarioRepository>()
                .Setup(u => u.Obter(x => x.Email == usuario.Email))
                .Returns(Task.FromResult((IEnumerable<Usuario>)new[] { usuarioComSenhaEncriptada }));

            // Act
            var usuarioLogado = await _mockServices.UsuarioService.Login(usuario);

            // Assert
            Assert.NotNull(usuario);
        }

        [Fact(DisplayName = "Logar Usuario - Falha de email ou senha incorretos")]
        [Trait("Categoria", "Usuario Service Tests")]
        public async Task UsuarioService_Logar_DeveFalharDevidoEmailOuSenhaIncorretos()
        {
            //// Arrange
            var usuario = _mockServices.GerarUsuariosValidos(1).First();

            var usuarioComSenhaEncriptada = (Usuario)usuario.Clone();
            usuarioComSenhaEncriptada.Senha = BCrypt.Net.BCrypt.HashPassword(usuarioComSenhaEncriptada.Senha);

            _mockServices.Mocker.GetMock<IUsuarioRepository>()
                .Setup(u => u.Obter(x => x.Email == usuario.Email))
                .Returns(Task.FromResult((IEnumerable<Usuario>)new List<Usuario>()));

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(() => _mockServices.UsuarioService.Login(usuario));
        }
    }
}
