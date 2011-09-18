namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;
    using Domain.Entities;

    public class PhotoConfiguration : EntityTypeConfiguration<Photo>
    {
        public PhotoConfiguration()
        {
            HasKey(x => x.Id);

            Property(x => x.Id).IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).HasColumnName("PhotoID");

            Property(x => x.FlickrId).HasColumnName("PhotoFlickrId").IsRequired();

            Property(x => x.Caption).HasColumnName("PhotoCaption");

            Property(x => x.LargeUrl).HasColumnName("PhotoLargeUrl");

            Property(x => x.MediumUrl).HasColumnName("PhotoMediumUrl");

            Property(x => x.SmallUrl).HasColumnName("PhotoSmallUrl");

            Property(x => x.ThumbNailUrl).HasColumnName("PhotoThumbnailUrl");

            Property(x => x.SquareThumbnail).HasColumnName("PhotoSquareThumbnailUrl");

            ToTable("Photos");
        }
    }
}