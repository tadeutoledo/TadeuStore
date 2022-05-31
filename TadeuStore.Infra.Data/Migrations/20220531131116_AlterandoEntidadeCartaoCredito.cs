using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TadeuStore.Infra.Data.Migrations
{
    public partial class AlterandoEntidadeCartaoCredito : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Vencimento",
                table: "CartoesCredito");

            migrationBuilder.RenameColumn(
                name: "NumeroNormalizado",
                table: "CartoesCredito",
                newName: "NomeImpresso");

            migrationBuilder.AddColumn<int>(
                name: "CodigoSeguranca",
                table: "CartoesCredito",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "DataExpiracao",
                table: "CartoesCredito",
                type: "nvarchar(7)",
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CodigoSeguranca",
                table: "CartoesCredito");

            migrationBuilder.DropColumn(
                name: "DataExpiracao",
                table: "CartoesCredito");

            migrationBuilder.RenameColumn(
                name: "NomeImpresso",
                table: "CartoesCredito",
                newName: "NumeroNormalizado");

            migrationBuilder.AddColumn<DateTime>(
                name: "Vencimento",
                table: "CartoesCredito",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
