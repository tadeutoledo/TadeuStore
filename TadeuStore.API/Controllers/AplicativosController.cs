using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Requisicao;

namespace TadeuStore.API.Controllers
{
    [ApiVersion("1.0")]
    [Route("api/v{version:apiVersion}/[controller]")]
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
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<Aplicativo>))]
        public async Task<ActionResult> ObterTodos()
        {
            return Ok(await _aplicativoService.ObterTodos());
        }

        [HttpPost]
        [Route("{id:Guid}/comprar")]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ErroDetalhes))]
        [Authorize]
        public async Task<ActionResult> Comprar(CartaoCreditoRequisicaoViewModel viewModel, Guid id)
        {            
            await _aplicativoService.Comprar(id, _mapper.Map<CartaoCredito>(viewModel), viewModel.Salvar);
            return Ok();
        }
    }
}
