using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;

namespace TadeuStore.Services
{
    public class AplicativoService : IAplicativoService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IUsuarioRepository _usuarioRepository;
        private readonly IAplicativoRepository _aplicativoRepository;
        private readonly ICartaoCreditoRepository _cartaoCreditoRepository;
        private readonly IEventBus _bus;

        public AplicativoService(
            IHttpContextAccessor httpContextAccessor,
            IUsuarioRepository usuarioRepository,
            IAplicativoRepository aplicativoRepository,
            ICartaoCreditoRepository cartaoCreditoRepository,
            IEventBus bus)
        {
            _httpContextAccessor = httpContextAccessor;
            _usuarioRepository = usuarioRepository;
            _aplicativoRepository = aplicativoRepository;
            _cartaoCreditoRepository = cartaoCreditoRepository;
            _bus = bus;
        }

        public async Task<IEnumerable<Aplicativo>> ObterTodos()
        {
            return await _aplicativoRepository.ObterTodos();
        }

        public async Task Comprar(Guid id, CartaoCredito cartao, bool salvarCartao = false)
        {
            if (!cartao.Validar())
                throw new ArgumentException("Cartão de crédito inválido.");

            var idUsuario = _httpContextAccessor
                .HttpContext
                .User
                .Claims
                .Where(x => x.Type == ClaimTypes.NameIdentifier)
                .FirstOrDefault()?
                .Value;

            Guid idUsuarioTratado = Guid.Empty;

            if (!Guid.TryParse(idUsuario, out idUsuarioTratado))
                throw new ArgumentException($"Login inválido para a compra.");

            var usuario = await _usuarioRepository.ObterPorId(idUsuarioTratado);

            if (usuario == null)
                throw new ArgumentException($"O usuário [{idUsuario?.ToString()}] não foi encontrado");

            var aplicativo = _aplicativoRepository.ObterPorId(id);

            //Adicionar ao serviço de fila

            if (salvarCartao && !(await _cartaoCreditoRepository.Obter(x => x.Numero == cartao.Numero && x.UsuarioId == usuario.Id)).Any())
            {
                cartao.UsuarioId = usuario.Id;
                await _cartaoCreditoRepository.Adicionar(cartao);     
            }

            _bus.Publish(new AutorizarPagamentoIntegrationEvent(Guid.NewGuid()));
        }
    }
}
