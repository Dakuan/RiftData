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
            this.flickrApp = flickrApp;

            flickrApp.ApiKey = "ee83fcb598d60f1081c08dac83f9882d";

            flickrApp.ApiSecret = "1ef6f20185274ebe";

            flickrApp.AuthToken = "72157626863345193-fac9def5c6ed227d";
        }

        public Photo Build(RiftData.Infrastructure.Data.Photos dataPhoto)
        {
            var flickrPhoto = this.flickrApp.PhotosGetInfo(dataPhoto.FlickrId);

            var photo = new Photo(dataPhoto.ID)
                            {
                                FlickrId = dataPhoto.FlickrId,
                                MediumUrl = flickrPhoto.MediumUrl,
                                ThumbNailUrl = flickrPhoto.ThumbnailUrl
                            };

            return photo;
        }
    }
}
