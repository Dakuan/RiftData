namespace RiftData.Infrastructure.Flickr
{
    using System.Collections.Generic;
    using System.Web;

    using FlickrNet;

    public interface IFlickrInfrastructure
    {
        void DeletePhoto(string id);

        PhotoInfo GetPhoto(string photoId);

        Dictionary<int, PhotoInfo> GetPhotos(Dictionary<int, string> items);

        string UploadPhoto(HttpPostedFileBase file, string name);
    }
}