using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;
using TadeuStore.Domain.EventBus;
using TadeuStore.Domain.Interfaces.Repositorys;
using TadeuStore.Domain.Models;

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


        private IConnection _connection;
        private IModel _channel;

        public RabbitMQ_Consumer(ITransacaoRepository transacaoRepository) : base(transacaoRepository)
        {
        }

        private void Tryconnect()
        {
            try
            {
                if (_connection?.IsOpen ?? false)
                    return;

                var factory = new ConnectionFactory()
                {
                    HostName = "localhost"
                };
             
                _connection = factory.CreateConnection();
                _channel = _connection.CreateModel();

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

            _channel.QueueDeclare(queue: eventName,
                                durable: false,
                                exclusive: false,
                                autoDelete: false,
                                arguments: null);

            var consumer = new EventingBasicConsumer(_channel);

            consumer.Received += Consumer_Received;

            _channel.BasicConsume(
                queue: eventName,
                autoAck: false,
                consumer: consumer);

        }

        private async void Consumer_Received(object sender, BasicDeliverEventArgs eventArgs)
        {
            var eventName = eventArgs.RoutingKey;
            var message = Encoding.UTF8.GetString(eventArgs.Body.Span);

            try
            {
                // Direncionar para o Handle do evento

                await ProcessEvent(eventName, message);

                _channel.BasicAck(eventArgs.DeliveryTag, multiple: false);
            }
            catch (Exception ex)
            {
                _channel.BasicNack(eventArgs.DeliveryTag, multiple: false, true);
                Console.WriteLine("Erro ao processo evento: " + ex.Message);
            }
        }

        private async Task<ResponseMessage> ProcessEvent(string eventName, string message)
        {
            Type type = AppDomain.CurrentDomain.GetAssemblies().SelectMany(x => x.GetTypes()).First(x => x.Name == eventName);

            var eventData = JsonConvert.DeserializeObject(message, type);

            if (HasSubscription(eventName))
            {
                var result = await ExecuteEvent(eventName, (IIntegrationEventHandler)eventData);

                if (!result.ValidationResult.IsValid)
                {
                    var errorMessage = "";
                    result.ValidationResult.Errors.ForEach(x => errorMessage += $"{x.ErrorCode} - {x.ErrorMessage} |");
                    throw new Exception(errorMessage);
                }
            }

            return await Task.Run(() => new ResponseMessage(new FluentValidation.Results.ValidationResult()));
        }
    }
}
