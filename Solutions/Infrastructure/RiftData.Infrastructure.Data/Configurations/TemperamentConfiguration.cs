using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class TemperamentConfiguration : EntityTypeConfiguration<Temperament>
    {
        public TemperamentConfiguration()
        {
            HasKey(k => k.Id);

            Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired().HasColumnName("TemperamentID");

            Property(p => p.Name).HasColumnName("TemperamentName");

            ToTable("Temperaments");
        }
    }
}
