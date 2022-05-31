using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.API.Controllers
{
    [Route("api/[controller]")]
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
        public async Task<ActionResult> Cadastrar(CadastrarUsuarioRequisicaoViewModel viewModel)
        {            
            return Ok(await _usuariosService.Adicionar(_mapper.Map<Usuario>(viewModel)));
        }


        [HttpPost]
        [Route("login")]
        public async Task<ActionResult> Logar(LoginRequisicaoViewModel viewModel)
        {
            return Ok(await _usuariosService.Login(_mapper.Map<Usuario>(viewModel)));
        }
    }
}

