using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Models;

namespace TadeuStore.Infra.Data.Context
{
    public class MainContext : DbContext
    {
        public MainContext(DbContextOptions options) : base(options)
        {
            ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
            ChangeTracker.AutoDetectChangesEnabled = false;
        }

        public DbSet<Aplicativo> Aplicativos { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
    }
}
