using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class GenusConfiguration : EntityTypeConfiguration<Genus>
    {
        public GenusConfiguration()
        {
            HasKey(p => p.Id);
            Property(p => p.Id).HasColumnName("GenusID").IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(p => p.Name).HasColumnName("GenusName");
            Ignore(p => p.HasFish);
            HasMany(x => x.Species).WithRequired(x => x.Genus).Map(m => m.MapKey("SpeciesGenusID"));
            HasRequired(x => x.GenusType).WithMany(x => x.Genus).Map(m => m.MapKey("GenusTypeID"));
            ToTable("Genus");
        }
    }
}
