namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class GenusTypeConfiguration : EntityTypeConfiguration<GenusType>
    {
        public GenusTypeConfiguration()
        {
            this.HasKey(p => p.Id);
            Property(p => p.Id).HasColumnName("GenusTypeID").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
            Property(p => p.Name).HasColumnName("GenusTypeName").IsRequired();
            this.HasMany(p => p.Genus).WithRequired(x => x.GenusType);
            this.HasRequired(p => p.Lake).WithMany(l => l.GenusTypes).Map(m => m.MapKey("GenusTypeLakeID"));
            Property(p => p.Description).HasColumnName("GenusTypeDescription");
            this.ToTable("GenusTypes");
        }
    }
}