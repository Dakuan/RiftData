namespace RiftData.Infrastructure.Data
{
    using System.Data.Entity;
    using Configurations;
    using Domain.Entities;

    public class RiftDataDataContext : DbContext
    {
        public RiftDataDataContext()
        {
            Database.SetInitializer<RiftDataDataContext>(null);
        }

        public DbSet<Genus> Genus { get; set; }

        public DbSet<Species> Species { get; set; }

        public DbSet<Locale> Locales { get; set; }

        public DbSet<Fish> Fish { get; set; }

        public DbSet<GenusType> GenusTypes { get; set; }

        public DbSet<Photo> Photos { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            AddConfigurations(modelBuilder);

            base.OnModelCreating(modelBuilder);
        }

        private static void AddConfigurations(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new PhotoConfiguration());
            modelBuilder.Configurations.Add(new SpeciesConfiguration());
            modelBuilder.Configurations.Add(new FishConfiguration());
            modelBuilder.Configurations.Add(new LocaleConfiguration());
            modelBuilder.Configurations.Add(new GenusTypeConfiguration());
            modelBuilder.Configurations.Add(new GenusConfiguration());
        }
    }
}