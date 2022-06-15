using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Resposta;

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

        private string EncriptarSenha(string senha) => BCrypt.Net.BCrypt.HashPassword(senha);

        private string GerarToken(Usuario usuario)
        {
            var keySettings = "DECC53D4-BF3D-41D7-A5B8-CF2F25F98E7F";

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(keySettings);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Email, usuario.Email.ToString()),
                    new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString())
                }),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public async Task<CadastrarUsuarioRespostaViewModel> Cadastrar(Usuario usuario)
        {
            var usuarioCadastrado = await _usuarioRepository.Obter(x => x.Email == usuario.Email);

            if (usuarioCadastrado.Any())
                throw new ArgumentException("Este email já está cadastrado.");

            usuario.Senha = EncriptarSenha(usuario.Senha);

            await _usuarioRepository.Adicionar(usuario);

            return _mapper.Map<CadastrarUsuarioRespostaViewModel>(usuario);
        }

        public async Task<LoginRespostaViewModel> Login(Usuario usuario)
        {
            var usuarios = await _usuarioRepository.Obter(x => x.Email == usuario.Email);

            var usuarioCadastrado = usuarios?.FirstOrDefault(x => BCrypt.Net.BCrypt.Verify(usuario.Senha, x.Senha));

            if (usuarioCadastrado == null)
                throw new ArgumentException("Email ou senha incorretos.");
            
            var token = GerarToken(usuarioCadastrado);

            return new LoginRespostaViewModel()
            {
                Email = usuario.Email,
                Token = token
            };
        }
    }
}
