namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class SpeciesConfiguration : EntityTypeConfiguration<Species>
    {
        public SpeciesConfiguration()
        {
            this.HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("SpeciesID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).
                IsRequired();

            Property(p => p.Name).IsRequired().HasColumnName("SpeciesName");

            Property(p => p.Described).HasColumnName("SpeciesDescribed").IsRequired();

            this.HasRequired(g => g.Genus).WithMany(x => x.Species);

            this.HasRequired(t => t.Temperament).WithMany().Map(m => m.MapKey("SpeciesTemperamentID"));

            Property(p => p.HasPhotos).HasColumnName("SpeciesHasPhotos").IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Computed);

            Property(p => p.HasFish).HasColumnName("SpeciesHasFish").IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Computed);

            Property(p => p.Description).HasColumnName("SpeciesDescription");

            Property(p => p.MinSize).HasColumnName("SpeciesMinSize");

            Property(p => p.MaxSize).HasColumnName("SpeciesMaxSize");

            this.Ignore(p => p.UrlName);

            this.ToTable("Species");
        }
    }
}