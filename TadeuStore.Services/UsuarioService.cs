using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.Services
{
    public class UsuarioService : IUsuarioService
    {
        private readonly IUsuarioRepository _usuarioRepository;
        private readonly IMapper _mapper;

        public UsuarioService(
            IMapper mapper, 
            IUsuarioRepository usuarioRepository)
        {
            _mapper = mapper;
            _usuarioRepository = usuarioRepository;
        }

        private string GenerateToken(Usuario usuario)
        {
            var keySettings = "fedaf7d8863b48e197b9287d492b708e";

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(keySettings);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Email, usuario.Email.ToString()),
                    new Claim(ClaimTypes.Name, usuario.Nome.ToString())
                }),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public async Task<CadastrarUsuarioRespostaViewModel> Adicionar(Usuario usuario)
        {
            var usuarioCadastrado = await _usuarioRepository.Obter(x => x.Email == usuario.Email);

            if (usuarioCadastrado?.Count() > 0)
                throw new ArgumentException("Este email já está cadastrado."); // Redirecionar página de login

            await _usuarioRepository.Adicionar(usuario);

            return _mapper.Map<CadastrarUsuarioRespostaViewModel>(usuario);
        }

        public async Task<LoginRespostaViewModel> Login(Usuario usuario)
        {
            var usuarioCadastrado = await _usuarioRepository.Obter(x => x.Email == usuario.Email && x.Senha == usuario.Senha);

            if (usuarioCadastrado?.Count() == 0)
                throw new ArgumentException("Este usuário não está cadastrado.");
            
            var token = GenerateToken(usuarioCadastrado.FirstOrDefault());

            return new LoginRespostaViewModel()
            {
                Email = usuario.Email,
                Token = token
            };
        }
    }
}
