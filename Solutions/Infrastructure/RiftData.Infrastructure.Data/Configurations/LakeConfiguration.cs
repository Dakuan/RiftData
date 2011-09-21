namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class LakeConfiguration : EntityTypeConfiguration<Lake>
    {
        public LakeConfiguration()
        {
            this.HasKey(k => k.Id);

            Property(p => p.Id).IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).HasColumnName("LakeID");

            Property(p => p.Name).IsRequired().HasColumnName("LakeName");

            Property(p => p.Description).HasColumnName("LakeDescription");

            this.HasMany(p => p.GenusTypes).WithRequired(x => x.Lake).Map(m => m.MapKey("GenusTypeLakeID"));

            this.ToTable("Lakes");
        }
    }
}