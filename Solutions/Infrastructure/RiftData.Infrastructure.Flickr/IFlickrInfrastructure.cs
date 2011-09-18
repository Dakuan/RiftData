using System.Collections.Generic;
using System.Web;
using FlickrNet;

namespace RiftData.Infrastructure.Flickr
{
    public interface IFlickrInfrastructure
    {
        PhotoInfo GetPhoto(string photoId);

        Dictionary<int, PhotoInfo>GetPhotos(Dictionary<int, string> items);

        string UploadPhoto(HttpPostedFileBase file, string name);

        void DeletePhoto(string id);
    }
}