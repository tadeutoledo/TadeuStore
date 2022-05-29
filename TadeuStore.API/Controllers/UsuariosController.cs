using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly IUsuariosService _usuariosService;
        private readonly IMapper _mapper;

        public UsuariosController(
            IMapper mapper,
            IUsuariosService usuariosRepository)
        {
            _mapper = mapper;
            _usuariosService = usuariosRepository;
        }

        [HttpPost]
        public async Task<ActionResult> Cadastrar(UsuarioRequisicaoViewModel modelView)
        {
            await _usuariosService.Adicionar(_mapper.Map<Usuario>(modelView));
            return Ok();
        }


        [HttpPost]
        [Route("login")]
        public async Task<string> Logar(LoginUsuarioRequisicaoViewModel request)
        {
            return null;
        }
    }
}

