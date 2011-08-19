using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class SpeciesConfiguration : EntityTypeConfiguration<Species>
    {
        public SpeciesConfiguration()
        {
            HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("SpeciesID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            Property(p => p.Name).IsRequired().HasColumnName("SpeciesName");

            Property(p => p.Described).HasColumnName("SpeciesDescribed").IsRequired();

            HasRequired(g => g.Genus).WithMany(x => x.Species);

            Property(p => p.HasPhotos).HasColumnName("SpeciesHasPhotos").IsRequired();

            Property(p => p.HasFish).HasColumnName("SpeciesHasFish").IsRequired();

            Property(p => p.Description).HasColumnName("SpeciesDescription");

            Ignore(p => p.UrlName);

            ToTable("Species");
        }
    }
}