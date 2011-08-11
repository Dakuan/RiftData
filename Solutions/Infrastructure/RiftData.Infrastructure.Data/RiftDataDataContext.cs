using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data.Configurations;

namespace RiftData.Infrastructure.Data
{
    public class RiftDataDataContext : DbContext
    {
        public DbSet<Genus> Genus { get; set; }

        public DbSet<Species> Species { get; set; }

        public DbSet<Locale> Locales { get; set; }

        public DbSet<Fish> Fish { get; set; }

        public DbSet<GenusType> GenusTypes { get; set; }

        public DbSet<Photo> Photos { get; set; }

        //public RiftDataDataContext(string connectionStringName): base(connectionStringName)
        public RiftDataDataContext()
        {
            Database.SetInitializer<RiftDataDataContext>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();


            modelBuilder.Configurations.Add(new FishConfiguration());
            modelBuilder.Configurations.Add(new LocaleConfiguration());
            modelBuilder.Configurations.Add(new GenusTypeConfiguration());
            modelBuilder.Configurations.Add(new GenusConfiguration());

            base.OnModelCreating(modelBuilder);
        }
    }
}