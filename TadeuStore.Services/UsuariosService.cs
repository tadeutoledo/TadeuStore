using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Models;

namespace TadeuStore.Services
{
    public class UsuariosService : IUsuariosService
    {
        private readonly IUsuarioRepository _usuarioRepository;

        public UsuariosService(IUsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }

        public async Task Adicionar(Usuario usuario)
        {
            var usuarioCadastrado = await _usuarioRepository.Obter(x => x.Nome == usuario.Nome || x.Email == usuario.Email);

            if (usuarioCadastrado?.Count() > 0)
                throw new ArgumentException("Usuário já cadastrado.");

            await _usuarioRepository.Adicionar(usuario); 
        }
    }
}
