USE [master]
GO
/****** Object:  Database [TadeuStoreDB]    Script Date: 08/06/2022 19:15:40 ******/
CREATE DATABASE [TadeuStoreDB]

GO
USE [TadeuStoreDB]
GO
/****** Object:  User [teste]    Script Date: 08/06/2022 19:15:40 ******/
CREATE USER [teste] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 08/06/2022 19:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aplicativos]    Script Date: 08/06/2022 19:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aplicativos](
	[Id] [uniqueidentifier] NOT NULL,
	[Nome] [nvarchar](200) NOT NULL,
	[Empresa] [nvarchar](200) NOT NULL,
	[Categoria] [nvarchar](200) NOT NULL,
	[DataPublicacao] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Aplicativos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartoesCredito]    Script Date: 08/06/2022 19:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartoesCredito](
	[Id] [uniqueidentifier] NOT NULL,
	[Numero] [nvarchar](50) NOT NULL,
	[NomeImpresso] [nvarchar](16) NOT NULL,
	[Bandeira] [int] NOT NULL,
	[UsuarioId] [uniqueidentifier] NOT NULL,
	[CodigoSeguranca] [int] NOT NULL,
	[DataExpiracao] [nvarchar](7) NOT NULL,
 CONSTRAINT [PK_CartoesCredito] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacoes]    Script Date: 08/06/2022 19:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacoes](
	[Id] [uniqueidentifier] NOT NULL,
	[UsuarioId] [uniqueidentifier] NOT NULL,
	[AplicativoId] [uniqueidentifier] NOT NULL,
	[CartaoCreditoId] [uniqueidentifier] NULL,
	[ValorPago] [decimal](18, 2) NOT NULL,
	[DataHoraCompra] [datetime2](7) NOT NULL,
	[StatusAutorizacao] [int] NOT NULL,
 CONSTRAINT [PK_Transacoes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 08/06/2022 19:15:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [uniqueidentifier] NOT NULL,
	[Nome] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Senha] [nvarchar](100) NOT NULL,
	[Cpf] [nvarchar](11) NOT NULL,
	[DataNascimento] [datetime2](7) NOT NULL,
	[Sexo] [int] NOT NULL,
	[Endereco] [nvarchar](200) NOT NULL,
	[Complemento] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220528222251_Inicial', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220529012244_Create Usuario', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220531014830_AddCartaoCredito', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220531131116_AlterandoEntidadeCartaoCredito', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220603164803_Add Transacao', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220603165945_Nullable IdCartao Transacao', N'6.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220603232532_Add CodigoAutorizacao Transacao', N'6.0.5')
GO
INSERT [dbo].[Aplicativos] ([Id], [Nome], [Empresa], [Categoria], [DataPublicacao]) VALUES (N'1b1b890a-d527-439f-9478-34ac837b1d8e', N'Fortnite', N'Epic Games', N'Jogos', CAST(N'2022-06-07T00:53:36.9303140' AS DateTime2))
INSERT [dbo].[Aplicativos] ([Id], [Nome], [Empresa], [Categoria], [DataPublicacao]) VALUES (N'eef60ed5-534b-4b33-b0da-44a82e606de6', N'WhatsApp', N'Meta', N'Social', CAST(N'2022-06-07T23:06:56.9239952' AS DateTime2))
INSERT [dbo].[Aplicativos] ([Id], [Nome], [Empresa], [Categoria], [DataPublicacao]) VALUES (N'ab3fb3c8-2d1e-40ac-ac90-554123c783e0', N'TradeMap', N'TradeMap Ink', N'Finanças', CAST(N'2022-05-15T19:33:36.9305961' AS DateTime2))
INSERT [dbo].[Aplicativos] ([Id], [Nome], [Empresa], [Categoria], [DataPublicacao]) VALUES (N'4a945efb-4abe-4309-bfad-5ea60c2f9787', N'Candy Crush', N'King Games', N'Jogos', CAST(N'2022-05-28T13:06:56.9305975' AS DateTime2))
INSERT [dbo].[Aplicativos] ([Id], [Nome], [Empresa], [Categoria], [DataPublicacao]) VALUES (N'8c2abad0-8d04-492a-80e5-795253c5ab56', N'Google Maps', N'Alphabet', N'Utilidades', CAST(N'2022-06-05T15:33:36.9305945' AS DateTime2))
GO
INSERT [dbo].[CartoesCredito] ([Id], [Numero], [NomeImpresso], [Bandeira], [UsuarioId], [CodigoSeguranca], [DataExpiracao]) VALUES (N'6af3d0f4-de0a-452f-e41b-08da48f65956', N'5436624605131549', N'JOSE A', 0, N'690d76da-5692-44dd-136e-08da48f626cf', 735, N'11/2023')
GO
INSERT [dbo].[Transacoes] ([Id], [UsuarioId], [AplicativoId], [CartaoCreditoId], [ValorPago], [DataHoraCompra], [StatusAutorizacao]) VALUES (N'c248e697-7800-47dc-b3c0-08da48f6596b', N'690d76da-5692-44dd-136e-08da48f626cf', N'1b1b890a-d527-439f-9478-34ac837b1d8e', N'6af3d0f4-de0a-452f-e41b-08da48f65956', CAST(0.26 AS Decimal(18, 2)), CAST(N'2022-06-08T02:26:52.5705463' AS DateTime2), 0)
INSERT [dbo].[Transacoes] ([Id], [UsuarioId], [AplicativoId], [CartaoCreditoId], [ValorPago], [DataHoraCompra], [StatusAutorizacao]) VALUES (N'1e8c7c54-d927-46ac-b3c1-08da48f6596b', N'690d76da-5692-44dd-136e-08da48f626cf', N'1b1b890a-d527-439f-9478-34ac837b1d8e', N'6af3d0f4-de0a-452f-e41b-08da48f65956', CAST(0.97 AS Decimal(18, 2)), CAST(N'2022-06-08T02:27:19.1033791' AS DateTime2), 0)
GO
INSERT [dbo].[Usuarios] ([Id], [Nome], [Email], [Senha], [Cpf], [DataNascimento], [Sexo], [Endereco], [Complemento]) VALUES (N'690d76da-5692-44dd-136e-08da48f626cf', N'Jose Antonio', N'jose@gmail.com', N'$2b$10$qD20V8r9.tC064ZzQAqLYegxWAO4iFUp/qIiO39PM1zGCb9TF/6DK', N'65535215522', CAST(N'1980-06-08T00:00:00.0000000' AS DateTime2), 0, N'Rua XXX 780', N'')
GO
/****** Object:  Index [IX_CartoesCredito_UsuarioId]    Script Date: 08/06/2022 19:15:40 ******/
CREATE NONCLUSTERED INDEX [IX_CartoesCredito_UsuarioId] ON [dbo].[CartoesCredito]
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Transacoes_AplicativoId]    Script Date: 08/06/2022 19:15:40 ******/
CREATE NONCLUSTERED INDEX [IX_Transacoes_AplicativoId] ON [dbo].[Transacoes]
(
	[AplicativoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Transacoes_CartaoCreditoId]    Script Date: 08/06/2022 19:15:40 ******/
CREATE NONCLUSTERED INDEX [IX_Transacoes_CartaoCreditoId] ON [dbo].[Transacoes]
(
	[CartaoCreditoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Transacoes_UsuarioId]    Script Date: 08/06/2022 19:15:40 ******/
CREATE NONCLUSTERED INDEX [IX_Transacoes_UsuarioId] ON [dbo].[Transacoes]
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CartoesCredito] ADD  DEFAULT ((0)) FOR [CodigoSeguranca]
GO
ALTER TABLE [dbo].[CartoesCredito] ADD  DEFAULT (N'') FOR [DataExpiracao]
GO
ALTER TABLE [dbo].[Transacoes] ADD  DEFAULT ((0)) FOR [StatusAutorizacao]
GO
ALTER TABLE [dbo].[CartoesCredito]  WITH CHECK ADD  CONSTRAINT [FK_CartoesCredito_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[CartoesCredito] CHECK CONSTRAINT [FK_CartoesCredito_Usuarios_UsuarioId]
GO
ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [FK_Transacoes_Aplicativos_AplicativoId] FOREIGN KEY([AplicativoId])
REFERENCES [dbo].[Aplicativos] ([Id])
GO
ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [FK_Transacoes_Aplicativos_AplicativoId]
GO
ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [FK_Transacoes_CartoesCredito_CartaoCreditoId] FOREIGN KEY([CartaoCreditoId])
REFERENCES [dbo].[CartoesCredito] ([Id])
GO
ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [FK_Transacoes_CartoesCredito_CartaoCreditoId]
GO
ALTER TABLE [dbo].[Transacoes]  WITH CHECK ADD  CONSTRAINT [FK_Transacoes_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Transacoes] CHECK CONSTRAINT [FK_Transacoes_Usuarios_UsuarioId]
GO
USE [master]
GO
ALTER DATABASE [TadeuStoreDB] SET  READ_WRITE 
GO
