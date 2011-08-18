using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class LakeConfiguration : EntityTypeConfiguration<Lake>
    {
        public LakeConfiguration()
        {
            HasKey(k => k.Id);

            Property(p => p.Id).IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).HasColumnName("LakeID");

            Property(p => p.Name).IsRequired().HasColumnName("LakeName");

            HasMany(p => p.GenusTypes).WithRequired(x => x.Lake).Map(m => m.MapKey("GenusTypeLakeID"));

            ToTable("Lakes");
        }
    }
}