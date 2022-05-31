using Microsoft.AspNetCore.Mvc;
using System.Net;
using System.Text;
using System.Text.Json;
using TadeuStore.Domain.Models;

namespace TadeuStore.API
{
    public class MainMiddleware
    {
        private readonly RequestDelegate _next;

        public MainMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                //_logger.LogError($"Uma exceção ocorreu: {ex}");
                await HandleExceptionAsync(context, ex);
            }
            finally
            {
                if (context.Response.StatusCode == StatusCodes.Status401Unauthorized)
                    await HandleAuthorizationAsync(context);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            if (ex is ArgumentException || ex is ArgumentNullException || ex is NotImplementedException)
                context.Response.StatusCode = StatusCodes.Status400BadRequest; 
            else
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;

            context.Response.ContentType = "application/json";

            var json = new ErroDetalhes()
                {
                    codigo = context.Response.StatusCode,
                    erros = new string[] { ex.Message?.ToString() ?? "" }
                };
            
            await context.Response.WriteAsync(JsonSerializer.Serialize(json));
        }

        private async Task HandleAuthorizationAsync(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            var json = new ErroDetalhes()
            {
                codigo = context.Response.StatusCode,
                erros = new string[] { "Usuário não logado." }
            };

            await context.Response.WriteAsync(JsonSerializer.Serialize(json));
        }
    }
}
