using TadeuStore.Infra.Data.Context;
using Microsoft.EntityFrameworkCore;
using TadeuStore.Infra.Data.Repositorys;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.API.Filters;
using System.Net;
using Microsoft.AspNetCore.Diagnostics;
using TadeuStore.Services;
using TadeuStore.API;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Interfaces.Services;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Infra.CrossCutting.ServiceBrokerIntegration;
using Microsoft.Extensions.Logging;
using TadeuStore.Domain.EventBus;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<MainContext>(o =>
{
    o.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));   
});

builder.Services.AddLogging();

// Services

var key = Encoding.ASCII.GetBytes("DECC53D4-BF3D-41D7-A5B8-CF2F25F98E7F");

builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});


builder.Services
    .AddControllers(o => 
    { 
        o.Filters.Add(typeof(FluentValidationAttribute)); 
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

builder.Services.AddSwaggerGen(c =>
{    

    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    {
        Description = "Insira o token JWT desta maneira: Bearer {seu token}",
        Name = "Authorization",
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                          new OpenApiSecurityScheme
                          {
                              Reference = new OpenApiReference
                              {
                                  Type = ReferenceType.SecurityScheme,
                                  Id = "Bearer"
                              }
                          },
                         new string[] {}
                    }
                });
});

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


// Handle Errors

var app = builder.Build();

app.UseMiddleware<MainMiddleware>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
