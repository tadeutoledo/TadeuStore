# TadeuStore

API para gerencimaneto de uma loja de aplicativos.

Desenvolvida em .Net Core 6, onde foi aplicado a modelagem de software DDD e suas boas práticas, princípios SOLID, SPOF (Single Point of Failure -- Ponto único de falha) com seus respectivos níveis de logs.

Tecnologias:
* EF 6 (Code First) para integração com o banco de dados;
* RabbitMQ e EasyNetQ para gerenciamento de filas;
* Swagger para documentação das rotas;
* Redis e SqlServerCache para gerencimaneto de Cache.

-> Obsrevações:
* Necessário ter o complemento "Data storage and processing" do VS para inicialização do banco de dados localmente;
* Executar o Script da tabela de cache do SqlServerChace antes, caso for usar o mesmo.
