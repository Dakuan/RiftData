using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class SpeciesConfiguration : EntityTypeConfiguration<Species>
    {
        public SpeciesConfiguration()
        {
            HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("SpeciesID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            Property(p => p.Described).HasColumnName("Described").IsRequired();

            HasRequired(g => g.Genus).WithMany().Map(m => m.MapKey("Genus"));

            Ignore(p => p.HasPhotos);

            Ignore(p => p.HaveFish);

            Ignore(p => p.UrlName);

            ToTable("Species");
        }
    }
}
