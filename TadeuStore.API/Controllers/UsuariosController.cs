using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Requisicao;
using TadeuStore.Domain.ViewModels.Resposta;

namespace TadeuStore.API.Controllers
{
    [ApiVersion("1.0")]
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly IUsuarioService _usuariosService;
        private readonly IMapper _mapper;

        public UsuariosController(
            IMapper mapper,
            IUsuarioService usuariosRepository)
        {
            _mapper = mapper;
            _usuariosService = usuariosRepository;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(CadastrarUsuarioRequisicaoViewModel))]
        public async Task<ActionResult> Cadastrar(CadastrarUsuarioRequisicaoViewModel viewModel)
        {            
            return Ok(await _usuariosService.Adicionar(_mapper.Map<Usuario>(viewModel)));
        }


        [HttpPost]
        [Route("login")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(LoginRespostaViewModel))]
        public async Task<ActionResult> Logar(LoginRequisicaoViewModel viewModel)
        {
            return Ok(await _usuariosService.Login(_mapper.Map<Usuario>(viewModel)));
        }
    }
}

