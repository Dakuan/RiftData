using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
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
            ToTable("Type");
        }
    }
}
