using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TadeuStore.Infra.Data.Migrations
{
    public partial class Inicial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Aplicativos",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Nome = table.Column<string>(type: "nvarchar(200)", nullable: false),
                    Empresa = table.Column<string>(type: "nvarchar(200)", nullable: false),
                    Categoria = table.Column<string>(type: "nvarchar(200)", nullable: false),
                    DataPublicacao = table.Column<DateTime>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Aplicativos", x => x.Id);
                });

            // Mock dados
            //InsertAplicativos(migrationBuilder);
        }

        private void InsertAplicativos(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                "Aplicativos", 
                new string[] { "Id", "Nome" , "Empresa" , "Categoria", "DataPublicacao" }, 
                new object[] { Guid.NewGuid(), "WhatsApp", "Meta", "Social", DateTime.Now });

            migrationBuilder.InsertData(
                "Aplicativos",
                new string[] { "Id", "Nome", "Empresa", "Categoria", "DataPublicacao" },
                new object[] { Guid.NewGuid(), "Fortnite", "Epic Games", "Jogos", DateTime.Now.AddSeconds(-80000) });

            migrationBuilder.InsertData(
                "Aplicativos",
                new string[] { "Id", "Nome", "Empresa", "Categoria", "DataPublicacao" },
                new object[] { Guid.NewGuid(), "Google Maps", "Alphabet", "Utilidades", DateTime.Now.AddSeconds(-200000) });

            migrationBuilder.InsertData(
                "Aplicativos",
                new string[] { "Id", "Nome", "Empresa", "Categoria", "DataPublicacao" },
                new object[] { Guid.NewGuid(), "TradeMap", "TradeMap Ink", "Finanças", DateTime.Now.AddSeconds(-2000000) });

            migrationBuilder.InsertData(
                "Aplicativos",
                new string[] { "Id", "Nome", "Empresa", "Categoria", "DataPublicacao" },
                new object[] { Guid.NewGuid(), "Candy Crush", "King Games", "Jogos", DateTime.Now.AddSeconds(-900000) });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Aplicativos");
        }
    }
}
