﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using TadeuStore.Infra.Data.Context;

#nullable disable

namespace TadeuStore.Infra.Data.Migrations
{
    [DbContext(typeof(MainContext))]
    partial class MainContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("TadeuStore.Domain.Models.Aplicativo", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Categoria")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("DataPublicacao")
                        .HasColumnType("datetime2");

                    b.Property<string>("Empresa")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Aplicativos");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.CartaoCredito", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("Bandeira")
                        .HasColumnType("int");

                    b.Property<int>("CodigoSeguranca")
                        .HasColumnType("int");

                    b.Property<string>("DataExpiracao")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("NomeImpresso")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Numero")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("UsuarioId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("UsuarioId");

                    b.ToTable("CartoesCredito");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.Transacao", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("AplicativoId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("CartaoCreditoId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("DataHoraCompra")
                        .HasColumnType("datetime2");

                    b.Property<int>("StatusAutorizacao")
                        .HasColumnType("int");

                    b.Property<Guid>("UsuarioId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<decimal>("ValorPago")
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("Id");

                    b.HasIndex("AplicativoId");

                    b.HasIndex("CartaoCreditoId");

                    b.HasIndex("UsuarioId");

                    b.ToTable("Transacoes");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.Usuario", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Complemento")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Cpf")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("DataNascimento")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Endereco")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Senha")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("Sexo")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Usuarios");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.CartaoCredito", b =>
                {
                    b.HasOne("TadeuStore.Domain.Models.Usuario", "Usuario")
                        .WithMany("CartoesCredito")
                        .HasForeignKey("UsuarioId")
                        .IsRequired();

                    b.Navigation("Usuario");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.Transacao", b =>
                {
                    b.HasOne("TadeuStore.Domain.Models.Aplicativo", "Aplicativo")
                        .WithMany()
                        .HasForeignKey("AplicativoId")
                        .IsRequired();

                    b.HasOne("TadeuStore.Domain.Models.CartaoCredito", "CartaoCredito")
                        .WithMany()
                        .HasForeignKey("CartaoCreditoId");

                    b.HasOne("TadeuStore.Domain.Models.Usuario", "Usuario")
                        .WithMany()
                        .HasForeignKey("UsuarioId")
                        .IsRequired();

                    b.Navigation("Aplicativo");

                    b.Navigation("CartaoCredito");

                    b.Navigation("Usuario");
                });

            modelBuilder.Entity("TadeuStore.Domain.Models.Usuario", b =>
                {
                    b.Navigation("CartoesCredito");
                });
#pragma warning restore 612, 618
        }
    }
}
