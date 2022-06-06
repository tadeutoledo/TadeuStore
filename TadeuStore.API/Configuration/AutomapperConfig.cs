using AutoMapper;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels.Requisicao;
using TadeuStore.Domain.ViewModels.Resposta;

namespace TadeuStore.API.Configuration
{
    public class AutomapperConfig : Profile
    {
        public AutomapperConfig()
        {
            CreateMap<CadastrarUsuarioRequisicaoViewModel, Usuario>().ReverseMap();

            CreateMap<LoginRequisicaoViewModel, Usuario>().ReverseMap();

            CreateMap<CadastrarUsuarioRespostaViewModel, Usuario>().ReverseMap();

            CreateMap<CartaoCreditoRequisicaoViewModel, CartaoCredito>()
                .ForMember(dst => dst.Numero, map => map.MapFrom(src => src.NumeroCartao))
                .ReverseMap();


            CreateMap<Transacao, ComprarAplicativoRespostaViewModel>()
                .ForMember(dst => dst.Id, map => map.MapFrom(src => src.Id))
                .ForMember(dst => dst.StatusAutorizacao, map => map.MapFrom(src => src.StatusAutorizacao))
                .ReverseMap();
        }
    }
}
