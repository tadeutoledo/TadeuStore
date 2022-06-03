using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using TadeuStore.Consumer;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Infra.Data.Context;
using TadeuStore.Infra.Data.Repositorys;

Console.WriteLine("Iniciando Consumer...");

CreateHostBuilder(args).Build().Run();

static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureServices((hostContext, services) =>
        {
            services.AddDbContext<MainContext>(o =>
            {
                o.UseSqlServer(hostContext.Configuration.GetConnectionString("DefaultConnection"));
            });

            services.AddTransient<MainContext>();
            services.AddTransient<ITransacaoRepository, TransacaoRepository>();
            services.AddHostedService<RabbitMQ_Consumer>();
        });





