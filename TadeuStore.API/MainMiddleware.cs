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
            //var originBody = context.Response.Body;

            try
            {
                //var memStream = new MemoryStream();
                //context.Response.Body = memStream;

                await _next(context);

                //memStream.Position = 0;
                //var responseBody = new StreamReader(memStream).ReadToEnd();

                //string path = context?.Request?.Path.ToString();

                //if (!path.ToLower().Contains("swagger"))
                //{
                //    responseBody = JsonSerializer.Serialize(new
                //    {
                //        sucesso = true,
                //        data = responseBody
                //    });
                //}

                //var memoryStreamModified = new MemoryStream();
                //var sw = new StreamWriter(memoryStreamModified);
                //sw.Write(responseBody);
                //sw.Flush();
                //memoryStreamModified.Position = 0;

                //await memoryStreamModified.CopyToAsync(originBody).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                //_logger.LogError($"Uma exceção ocorreu: {ex}");
                await HandleExceptionAsync(context, ex);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            if (ex is ArgumentException || ex is ArgumentNullException || ex is NotImplementedException)
                context.Response.StatusCode = StatusCodes.Status400BadRequest; 
            else
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;

            context.Response.ContentType = "application/json";

            var json = new
                {
                    codigo = context.Response.StatusCode,
                    erros = new string[] { ex.Message?.ToString() ?? "" }
                };
            
            await context.Response.WriteAsync(JsonSerializer.Serialize(json));
        }
    }
}
