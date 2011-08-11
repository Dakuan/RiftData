using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class FishConfiguration : EntityTypeConfiguration<Fish>
    {
        public FishConfiguration()
        {
            HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("FishID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            HasRequired(x => x.Genus).WithMany().Map(m => m.MapKey("Genus"));

            HasRequired(x => x.Species).WithMany().Map(m => m.MapKey("Species"));

            HasRequired(x => x.Locale).WithMany().Map(m => m.MapKey("Locale"));

            Ignore(x => x.HasPhotos);

            Ignore(x => x.UrlName);

            Ignore(x => x.Name);

            ToTable("Fish");
        }
    }
}
