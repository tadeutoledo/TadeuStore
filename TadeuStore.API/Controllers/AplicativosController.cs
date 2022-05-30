using Microsoft.AspNetCore.Mvc;
using TadeuStore.Domain.Interfaces;

namespace TadeuStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AplicativosController : ControllerBase
    {
        private readonly IAplicativoRepository _aplicativoRepository;

        public AplicativosController(IAplicativoRepository aplicativoRepository)
        {
            _aplicativoRepository = aplicativoRepository;
        }

        [HttpGet]
        public async Task<IActionResult> ObterTodos()
        {
            return Ok(await _aplicativoRepository.ObterTodos());
        }
    }
}
