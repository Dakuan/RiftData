namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class TemperamentConfiguration : EntityTypeConfiguration<Temperament>
    {
        public TemperamentConfiguration()
        {
            this.HasKey(k => k.Id);

            Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired().HasColumnName(
                "TemperamentID");

            Property(p => p.Name).HasColumnName("TemperamentName");

            this.ToTable("Temperaments");
        }
    }
}