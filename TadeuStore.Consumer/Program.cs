using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using TadeuStore.Consumer;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Infra.Data.Context;
using TadeuStore.Infra.Data.Repositorys;

IHost host = Host.CreateDefaultBuilder(args)
        .ConfigureServices((ctx, services) =>
        {
            services.AddDbContext<MainContext>(o =>
            {
                o.UseSqlServer(ctx.Configuration.GetConnectionString("DefaultConnection"));
            });

            services.AddTransient<MainContext>();
            services.AddTransient<ITransacaoRepository, TransacaoRepository>();
            services.AddHostedService<RabbitMQ_Consumer>();
        })
        .UseEnvironment(Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "")
        .Build();


await host.RunAsync();



