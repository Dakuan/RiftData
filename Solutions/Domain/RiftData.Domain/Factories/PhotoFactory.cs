using FlickrNet;
using Photo = RiftData.Domain.Entities.Photo;
namespace RiftData.Domain.Factories
{
    public class PhotoFactory : IPhotoFactory
    {
        public Photo CreatePhoto(int id)
        {
            var photo = new Photo();

            return photo;
        }

        public Photo CreatePhoto(PhotoInfo photoInfo)
        {
            return new Photo
            {
                FlickrId = photoInfo.PhotoId,
                MediumUrl = photoInfo.MediumUrl,
                SquareThumbnail = photoInfo.SquareThumbnailUrl,
                ThumbNailUrl = photoInfo.ThumbnailUrl,
                LargeUrl = photoInfo.LargeUrl,
                SmallUrl = photoInfo.SmallUrl
            };
        }
    }
}