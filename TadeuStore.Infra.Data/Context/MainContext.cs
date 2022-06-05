using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Models;

namespace TadeuStore.Infra.Data.Context
{
    public class MainContext : DbContext
    {
        public MainContext(DbContextOptions options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            foreach (var relationship in modelBuilder.Model.GetEntityTypes().SelectMany(e => e.GetForeignKeys())) relationship.DeleteBehavior = DeleteBehavior.ClientSetNull;

            modelBuilder.Entity<Transacao>()
                .Property(p => p.ValorPago)
                .HasColumnType("decimal(18,4)");
        }

        public DbSet<Aplicativo> Aplicativos { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<CartaoCredito> CartoesCredito { get; set; }
        public DbSet<Transacao> Transacoes { get; set; }
    }
}
