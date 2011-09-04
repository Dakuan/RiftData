using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class GenusTypeConfiguration : EntityTypeConfiguration<GenusType>
    {
        public GenusTypeConfiguration()
        {
            HasKey(p => p.Id);
            Property(p => p.Id).HasColumnName("GenusTypeID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
            Property(p => p.Name).HasColumnName("GenusTypeName").IsRequired();
            Ignore(p => p.GenusCount);
            HasMany(p => p.Genus).WithRequired(x => x.GenusType);
            HasRequired(p => p.Lake).WithMany(l => l.GenusTypes).Map(m => m.MapKey("GenusTypeLakeID"));
            Property(p => p.Description).HasColumnName("GenusTypeDescription");
            ToTable("GenusTypes");
        }
    }
}
