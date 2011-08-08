using FlickrNet;
using Photo = RiftData.Domain.Entities.Photo;

namespace RiftData.Domain.Factories
{
    public class PhotoFactory : IPhotoFactory
    {
        public Photo Build(PhotoInfo photoInfo, int photoId, string caption)
        {
            var photo = new Photo(photoId)
                            {
                                FlickrId = photoInfo.PhotoId,
                                MediumUrl = photoInfo.MediumUrl,
                                ThumbNailUrl = photoInfo.ThumbnailUrl,
                                SquareThumbnail = photoInfo.SquareThumbnailUrl,
                                Caption = caption
                            };

            return photo;
        }
    }
}