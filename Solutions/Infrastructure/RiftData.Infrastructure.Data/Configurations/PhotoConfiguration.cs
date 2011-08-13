using System.ComponentModel.DataAnnotations;
using System.Data.Entity.ModelConfiguration;
using RiftData.Domain.Entities;

namespace RiftData.Infrastructure.Data.Configurations
{
    public class PhotoConfiguration : EntityTypeConfiguration<Photo>
    {
        public PhotoConfiguration()
        {
            HasKey(x => x.Id);

            Property(x => x.Id).IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).HasColumnName("PhotoID");

            Property(x => x.FlickrId).HasColumnName("PhotoFlickrId").IsRequired();

            Property(x => x.Caption).HasColumnName("PhotoCaption");

            Property(x => x.MediumUrl).HasColumnName("PhotoMediumUrl");

            Property(x => x.ThumbNailUrl).HasColumnName("PhotoThumbnailUrl");

            Property(x => x.SquareThumbnail).HasColumnName("PhotoSquareThumbnailUrl");

            ToTable("Photos");
        }
    }
}