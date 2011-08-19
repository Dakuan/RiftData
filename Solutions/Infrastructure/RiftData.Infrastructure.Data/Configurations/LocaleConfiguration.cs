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

            Property(p => p.Latitude).HasColumnName("LocaleLatitude").IsRequired();

            Property(p => p.Longitude).HasColumnName("LocaleLongitude").IsRequired();

            Property(p => p.Name).HasColumnName("LocaleName").IsRequired();

            Property(p => p.ZoomLevel).HasColumnName("LocaleZoomLevel").IsRequired();

            HasRequired(x => x.Lake).WithMany().Map(m => m.MapKey("LocaleLakeID"));

            Property(p => p.Description).HasColumnName("LocaleDescription");

            Ignore(p => p.HasPhotos);

            Ignore(p => p.Photos);

            ToTable("Locales");
        }
    }
}
