using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TadeuStore.Infra.Data.Migrations
{
    public partial class AddCodigoAutorizacaoTransacao : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "StatusAutorizacao",
                table: "Transacoes",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StatusAutorizacao",
                table: "Transacoes");
        }
    }
}
