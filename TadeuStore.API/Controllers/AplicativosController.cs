using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AplicativosController : ControllerBase
    {
        private readonly IMapper _mapper;
        private readonly IAplicativoService _aplicativoService;

        public AplicativosController(
            IMapper mapper,
            IAplicativoService aplicativoService)
        {
            _mapper = mapper;
            _aplicativoService = aplicativoService;
        }

        [HttpGet]
        public async Task<ActionResult> ObterTodos()
        {
            return Ok(await _aplicativoService.ObterTodos());
        }

        [HttpPost]
        [Route("{id:Guid}/Comprar")]
        [Authorize]
        public async Task<ActionResult> Comprar(CartaoCreditoRequisicaoViewModel viewModel, Guid id)
        {            
            await _aplicativoService.Comprar(id, _mapper.Map<CartaoCredito>(viewModel), viewModel.Salvar);
            return Ok();
        }
    }
}
