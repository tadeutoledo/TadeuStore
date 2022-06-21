# TadeuStore

API para gerencimaneto de uma loja de aplicativos.

Desenvolvida em .Net Core 6, onde foi aplicado a modelagem de software DDD e suas boas práticas, princípios SOLID, Event Notification para baixa acoplamento na comunicação com serviços externos (API de Pagamentos, envio de email...), SPOF (Single Point of Failure -- Ponto único de falha) com seus respectivos níveis de logs, autenticação e autorização JWT e Fluent Validator para validação dos modelos de entrada.

Tecnologias:
* EF 6 (Code First) para integração com o banco de dados;
* RabbitMQ e EasyNetQ para gerenciamento de filas;
* Swagger para documentação das rotas;
* Redis e SqlServerCache para gerencimaneto de Cache;
* SonarQube para inspeção contínua da qualidade do software, "code smells" e potenciais bugs;
* Docker para gerenciar e conteinerizar as aplicações como um todo.

-> Executar Docker compose: 
docker-compose -f compose-production.yml up 

<i>*Aguardar 2 minutos para a execução automática dos scripts iniciais no DB.</i>
