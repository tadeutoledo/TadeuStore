using AutoMapper;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.ViewModels;

namespace TadeuStore.API.Configuration
{
    public class AutomapperConfig : Profile
    {
        public AutomapperConfig()
        {
            CreateMap<UsuarioRequisicaoViewModel, Usuario>().ReverseMap();
        }
    }
}
