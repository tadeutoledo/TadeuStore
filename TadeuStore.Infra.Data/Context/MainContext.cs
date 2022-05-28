using Microsoft.EntityFrameworkCore;
using TadeuStore.Domain.Models;

namespace TadeuStore.Infra.Data.Context
{
    public class MainContext : DbContext
    {
        public MainContext(DbContextOptions options) : base(options)
        {
            //
        }

        public DbSet<Aplicativo> Aplicativos { get; set; }
    }
}
