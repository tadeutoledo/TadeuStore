using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using TadeuStore.Consumer;

Console.WriteLine("Iniciando Consumer...");

CreateHostBuilder(args).Build().Run();

static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureServices((hostContext, services) =>
        {
            services.AddHostedService<RabbitMQ_Consumer>();
        });





