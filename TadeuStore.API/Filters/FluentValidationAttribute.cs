using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using TadeuStore.Domain.Models;

namespace TadeuStore.API.Filters
{
    public class FluentValidationAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                var errors = context.ModelState.Values.Where(v => v.Errors.Count > 0)
                        .SelectMany(v => v.Errors)
                        .Select(v => v.ErrorMessage)
                        .ToList();

                var result = new ErroDetalhes()
                {
                    codigo = StatusCodes.Status400BadRequest,
                    erros = errors?.ToArray()
                };

                context.Result = new JsonResult(result)
                {
                    StatusCode = StatusCodes.Status400BadRequest
                };
            }
        }
    }
}
