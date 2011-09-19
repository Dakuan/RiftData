namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class LocaleConfiguration : EntityTypeConfiguration<Locale>
    {
        public LocaleConfiguration()
        {
            this.HasKey(p => p.Id);

            Property(p => p.Id).HasColumnName("LocaleID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).
                IsRequired();

            Property(p => p.Latitude).HasColumnName("LocaleLatitude").IsRequired();

            Property(p => p.Longitude).HasColumnName("LocaleLongitude").IsRequired();

            Property(p => p.Name).HasColumnName("LocaleName").IsRequired();

            Property(p => p.ZoomLevel).HasColumnName("LocaleZoomLevel").IsRequired();

            this.HasRequired(x => x.Lake).WithMany().Map(m => m.MapKey("LocaleLakeID"));

            Property(p => p.Description).HasColumnName("LocaleDescription");

            this.Ignore(p => p.HasPhotos);

            this.Ignore(p => p.Photos);

            this.ToTable("Locales");
        }
    }
}