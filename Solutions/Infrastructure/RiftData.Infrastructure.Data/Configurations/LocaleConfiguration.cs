using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class LocaleConfiguration : EntityTypeConfiguration<Locale>
    {
        public LocaleConfiguration()
        {
            HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("LocaleID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            Property(p => p.Latitude).HasColumnName("Lat").IsRequired();

            Property(p => p.Longitude).HasColumnName("Long").IsRequired();

            Property(p => p.Name).HasColumnName("LocaleName").IsRequired();

            Ignore(p => p.HasPhotos);

            Ignore(p => p.Photos);

            ToTable("Locale");
        }
    }
}
