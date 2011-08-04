using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FlickrNet;
using Photo = RiftData.Domain.Entities.Photo;

namespace RiftData.Domain.Factories
{
    public class PhotoFactory : IPhotoFactory
    {
        private FlickrNet.Flickr flickrApp;

        public PhotoFactory(FlickrNet.Flickr flickrApp)
        {

        }

        public Photo Build(PhotoInfo photoInfo, int photoId, string caption)
        {
            var photo = new Photo(photoId)
                            {
                                FlickrId = photoInfo.PhotoId,
                                MediumUrl = photoInfo.MediumUrl,
                                ThumbNailUrl = photoInfo.ThumbnailUrl,
                                Caption = caption
                            };

            return photo;
        }
    }
}
