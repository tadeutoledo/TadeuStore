using FluentValidation.Results;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;
using System.Text.Json;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Models;
using TadeuStore.Domain.Models.Enums;

namespace TadeuStore.Consumer
{
    public class RabbitMQ_Consumer : ConsumerBase
    {
        protected async override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            Console.WriteLine($"Iniciando {nameof(RabbitMQ_Consumer)}...");

            CarregarSubscriptions();

            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay((int)TimeSpan.FromSeconds(3).TotalMilliseconds, stoppingToken);
            }
        }


        private IConnection connection;
        private IModel channel;

        private void Tryconnect()
        {
            try
            {
                if (connection?.IsOpen ?? false)
                    return;

                var factory = new ConnectionFactory()
                {
                    HostName = "localhost"
                };
             
                connection = factory.CreateConnection();
                channel = connection.CreateModel();

            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erro ao inicializar RabbiMQ Consumer error,ex:{ex.Message}");
            }

        }

        protected override void AddSubscription(string eventName, EventHandler eventHandler)
        {
            Tryconnect();

            base.AddSubscription(eventName, eventHandler);

            channel.QueueDeclare(queue: eventName,
                                durable: false,
                                exclusive: false,
                                autoDelete: false,
                                arguments: null);

            var consumer = new EventingBasicConsumer(channel);

            consumer.Received += Consumer_Received;

            channel.BasicConsume(
                queue: eventName,
                autoAck: false,
                consumer: consumer);

        }

        private void Consumer_Received(object sender, BasicDeliverEventArgs eventArgs)
        {
            var eventName = eventArgs.RoutingKey;
            var message = Encoding.UTF8.GetString(eventArgs.Body.Span);

            try
            {
                // Direncionar para o Handle do evento

                ProcessEvent(eventName, message);
                channel.BasicAck(eventArgs.DeliveryTag, multiple: false);
            }
            catch (Exception ex)
            {
                channel.BasicNack(eventArgs.DeliveryTag, multiple: false, true);
                Console.WriteLine("Erro ao processo evento: " + ex.Message);
            }
        }

        private async void ProcessEvent(string eventName, string message)
        {
            Type type = AppDomain.CurrentDomain.GetAssemblies().SelectMany(x => x.GetTypes()).First(x => x.Name == eventName);

            var eventData = JsonConvert.DeserializeObject(message, type);

            if (HasSubscription(eventName))
                ExecuteEvent(eventName, (IIntegrationEventHandler)eventData);
                
        }
    }
}
