namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class FishConfiguration : EntityTypeConfiguration<Fish>
    {
        public FishConfiguration()
        {
            this.HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("FishID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            this.HasRequired(x => x.Genus).WithMany().Map(m => m.MapKey("FishGenusID"));

            this.HasRequired(x => x.Species).WithMany().Map(m => m.MapKey("FishSpeciesID"));

            this.HasRequired(x => x.Locale).WithMany().Map(m => m.MapKey("FishLocaleID"));

            this.HasMany(x => x.Photos).WithMany().Map(m =>
                {
                    m.MapRightKey("PhotoID");
                    m.MapLeftKey("FishID");
                    m.ToTable("FishPhotos");
                });
            Property(p => p.Description).HasColumnName("FishDescription");

            this.Ignore(x => x.HasPhotos);

            this.Ignore(x => x.UrlName);

            this.Ignore(x => x.Name);

            this.ToTable("Fish");
        }
    }
}