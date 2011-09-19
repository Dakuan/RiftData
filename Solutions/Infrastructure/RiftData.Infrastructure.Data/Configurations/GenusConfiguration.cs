namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Entities;

    public class GenusConfiguration : EntityTypeConfiguration<Genus>
    {
        public GenusConfiguration()
        {
            this.HasKey(p => p.Id);
            Property(p => p.Id).HasColumnName("GenusID").IsRequired().HasDatabaseGeneratedOption(
                DatabaseGeneratedOption.Identity);
            Property(p => p.Name).HasColumnName("GenusName");
            this.Ignore(p => p.HasFish);
            this.HasMany(x => x.Species).WithRequired(x => x.Genus).Map(m => m.MapKey("SpeciesGenusID"));
            this.HasRequired(x => x.GenusType).WithMany(x => x.Genus).Map(m => m.MapKey("GenusGenusTypeID"));
            this.ToTable("Genus");
        }
    }
}