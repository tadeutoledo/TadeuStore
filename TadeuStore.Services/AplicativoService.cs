using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using System.Security.Claims;
using System.Text.Json;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Services
{
    public class AplicativoService : IAplicativoService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IUsuarioRepository _usuarioRepository;
        private readonly IAplicativoRepository _aplicativoRepository;
        private readonly ICartaoCreditoRepository _cartaoCreditoRepository;
        private readonly ITransacaoRepository _transacaoRepository;
        private readonly IEventBus _bus;
        private readonly IDistributedCache _cache;

        public AplicativoService(
            IHttpContextAccessor httpContextAccessor,
            IUsuarioRepository usuarioRepository,
            IAplicativoRepository aplicativoRepository,
            ICartaoCreditoRepository cartaoCreditoRepository,
            ITransacaoRepository transacaoRepository,
            IEventBus bus,
            IDistributedCache cache)
        {
            _httpContextAccessor = httpContextAccessor;
            _usuarioRepository = usuarioRepository;
            _aplicativoRepository = aplicativoRepository;
            _cartaoCreditoRepository = cartaoCreditoRepository;
            _transacaoRepository = transacaoRepository;
            _bus = bus;
            _cache = cache;
        }

        public async Task<IEnumerable<Aplicativo>> ObterTodos()
        {
            var chaveCache = "Aplicativos";
            var data = await _cache.GetStringAsync(chaveCache);

            if (!string.IsNullOrEmpty(data))
                return JsonConvert.DeserializeObject<List<Aplicativo>>(data);

            var aplicativos = await _aplicativoRepository.ObterTodos();

            await _cache.SetStringAsync(chaveCache, JsonConvert.SerializeObject(aplicativos));

            return aplicativos;
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

            if (usuario == null)
                throw new ArgumentException($"O aplicativo [{id}] não foi encontrado");

            cartao = usuario.CartoesCredito?.Where(x => x.Numero == cartao.Numero && x.UsuarioId == usuario.Id)?.FirstOrDefault() ?? cartao;

            if (salvarCartao && cartao?.Id == Guid.Empty)
            {
                cartao.UsuarioId = usuario.Id;
                cartao = await _cartaoCreditoRepository.Adicionar(cartao);     
            }

            var transacao = new Transacao()
            {
                AplicativoId = id,
                UsuarioId = usuario.Id,
                CartaoCreditoId = cartao?.Id == Guid.Empty ? null : cartao?.Id,
                ValorPago = (decimal)new Random().NextDouble(),
                DataHoraCompra = DateTime.Now,
                StatusAutorizacao = (int)TipoAutorizacaoTransacao.EmProcessamento
            };

            transacao = await _transacaoRepository.Adicionar(transacao);

            _bus.Publish(new AutorizarPagamentoIntegrationEvent(transacao.Id));
        }
    }
}
