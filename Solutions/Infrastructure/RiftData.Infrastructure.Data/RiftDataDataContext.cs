using RiftData.Domain.Logs;

namespace RiftData.Infrastructure.Data
{
    using System.Data.Entity;

    using RiftData.Domain.Entities;
    using RiftData.Infrastructure.Data.Configurations;

    public class RiftDataDataContext : DbContext
    {
        public RiftDataDataContext()
        {
            Database.SetInitializer<RiftDataDataContext>(null);
        }

        public DbSet<Fish> Fish { get; set; }

        public DbSet<Genus> Genus { get; set; }

        public DbSet<GenusType> GenusTypes { get; set; }

        public DbSet<Lake> Lakes { get; set; }

        public DbSet<Locale> Locales { get; set; }

        public DbSet<Photo> Photos { get; set; }

        public DbSet<Species> Species { get; set; }

        public DbSet<Temperament> Temperaments { get; set; }

        public DbSet<UserLog> UserLogs { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            AddConfigurations(modelBuilder);

            base.OnModelCreating(modelBuilder);
        }

        private static void AddConfigurations(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new TemperamentConfiguration());
            modelBuilder.Configurations.Add(new PhotoConfiguration());
            modelBuilder.Configurations.Add(new SpeciesConfiguration());
            modelBuilder.Configurations.Add(new FishConfiguration());
            modelBuilder.Configurations.Add(new LocaleConfiguration());
            modelBuilder.Configurations.Add(new GenusTypeConfiguration());
            modelBuilder.Configurations.Add(new GenusConfiguration());
            modelBuilder.Configurations.Add(new LakeConfiguration());
            modelBuilder.Configurations.Add(new UserLogConfiguration());
        }
    }
}