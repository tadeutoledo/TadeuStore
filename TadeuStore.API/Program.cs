using TadeuStore.Infra.Data.Context;
using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Interfaces;
using TadeuStore.Infra.Data.Repositorys;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Mvc;
using TadeuStore.API.Filters;
using System.Net;
using Microsoft.AspNetCore.Diagnostics;
using TadeuStore.Services;
using TadeuStore.API;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<MainContext>(o =>
{
    o.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));   
});

// Services

builder.Services
    .AddControllers(o => 
    { 
        o.Filters.Add(typeof(FluentValidationAttribute)); 
    });

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services
    .AddFluentValidation(options =>
    {
        options.ImplicitlyValidateChildProperties = true;
        options.ImplicitlyValidateRootCollectionElements = true;
        options.RegisterValidatorsFromAssemblies(AppDomain.CurrentDomain.GetAssemblies());
    });

builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});

// Resolve Dependecys

builder.Services.AddTransient<MainContext>();
builder.Services.AddTransient<IUsuariosService, UsuariosService>();
builder.Services.AddTransient<IAplicativoRepository, AplicaticoRepository>();
builder.Services.AddTransient<IUsuarioRepository, UsuarioRepository>();

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

//app.UseAuthorization();

app.MapControllers();

app.Run();
