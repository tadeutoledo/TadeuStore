using TadeuStore.Infra.Data.Context;
using Microsoft.EntityFrameworkCore;
using TadeuStore.Infra.Data.Repositorys;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.API.Filters;
using TadeuStore.Services;
using TadeuStore.API;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.EventBus;
using TadeuStore.Infra.CrossCutting.EventsBus;
using TadeuStore.Domain.Models;
using TadeuStore.API.Configuration;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.Extensions.Options;
using Swashbuckle.AspNetCore.SwaggerGen;

[assembly: ApiConventionType(typeof(DefaultApiConventions))]

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<MainContext>(o =>
{
    o.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));   
});

builder.Services.AddLogging();

// Services

builder.Services.AddJwtConfig();


builder.Services
    .AddControllers(o => 
    { 
        o.Filters.Add(typeof(FluentValidationAttribute));
        o.Filters.Add(new ProducesResponseTypeAttribute(typeof(ErroDetalhes), 400));
        o.Filters.Add(new ProducesResponseTypeAttribute(typeof(ErroDetalhes), 500));
        o.Filters.Add(new ProducesAttribute("application/json"));
    });

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies().Where(p => !p.IsDynamic));

builder.Services
    .AddFluentValidation(options =>
    {
        options.ImplicitlyValidateChildProperties = true;
        options.ImplicitlyValidateRootCollectionElements = true;
        options.RegisterValidatorsFromAssemblies(AppDomain.CurrentDomain.GetAssemblies().Where(p => !p.IsDynamic));
    });

builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});

builder.Services.AddSwaggerConfig();

// Resolve Dependecys

builder.Services.AddHttpContextAccessor();

builder.Services.AddTransient<MainContext>();

builder.Services.AddTransient<IUsuarioService, UsuarioService>();
builder.Services.AddTransient<IAplicativoService, AplicativoService>();

builder.Services.AddTransient<IAplicativoRepository, AplicaticoRepository>();
builder.Services.AddTransient<IUsuarioRepository, UsuarioRepository>();
builder.Services.AddTransient<ICartaoCreditoRepository, CartaoCreditoRepository>();
builder.Services.AddTransient<ITransacaoRepository, TransacaoRepository>();

builder.Services.AddSingleton<IEventBus, EventBusRabbitMQ>();

builder.Services.AddTransient<IConfigureOptions<SwaggerGenOptions>, ConfigureSwaggerOptions>();


// Handle Errors

var app = builder.Build();
var apiVersionDescriptionProvider = app.Services.GetRequiredService<IApiVersionDescriptionProvider>();

app.UseMiddleware<MainMiddleware>();

// Configure the HTTP request pipeline.

app.UseSwagger();
app.UseSwaggerConfig(apiVersionDescriptionProvider);
app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
