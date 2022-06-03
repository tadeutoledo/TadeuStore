using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TadeuStore.Infra.Data.Migrations
{
    public partial class NullableIdCartaoTransacao : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CartoesCredito_Usuarios_UsuarioId",
                table: "CartoesCredito");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_Aplicativos_AplicativoId",
                table: "Transacoes");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_CartoesCredito_CartaoCreditoId",
                table: "Transacoes");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_Usuarios_UsuarioId",
                table: "Transacoes");

            migrationBuilder.AlterColumn<Guid>(
                name: "CartaoCreditoId",
                table: "Transacoes",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AddForeignKey(
                name: "FK_CartoesCredito_Usuarios_UsuarioId",
                table: "CartoesCredito",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_Aplicativos_AplicativoId",
                table: "Transacoes",
                column: "AplicativoId",
                principalTable: "Aplicativos",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_CartoesCredito_CartaoCreditoId",
                table: "Transacoes",
                column: "CartaoCreditoId",
                principalTable: "CartoesCredito",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_Usuarios_UsuarioId",
                table: "Transacoes",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CartoesCredito_Usuarios_UsuarioId",
                table: "CartoesCredito");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_Aplicativos_AplicativoId",
                table: "Transacoes");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_CartoesCredito_CartaoCreditoId",
                table: "Transacoes");

            migrationBuilder.DropForeignKey(
                name: "FK_Transacoes_Usuarios_UsuarioId",
                table: "Transacoes");

            migrationBuilder.AlterColumn<Guid>(
                name: "CartaoCreditoId",
                table: "Transacoes",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_CartoesCredito_Usuarios_UsuarioId",
                table: "CartoesCredito",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_Aplicativos_AplicativoId",
                table: "Transacoes",
                column: "AplicativoId",
                principalTable: "Aplicativos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_CartoesCredito_CartaoCreditoId",
                table: "Transacoes",
                column: "CartaoCreditoId",
                principalTable: "CartoesCredito",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Transacoes_Usuarios_UsuarioId",
                table: "Transacoes",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
