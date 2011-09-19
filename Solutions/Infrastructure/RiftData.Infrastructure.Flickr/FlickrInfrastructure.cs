namespace RiftData.Infrastructure.Flickr
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using System.Web;

    using FlickrNet;

    public class FlickrInfrastructure : IFlickrInfrastructure
    {
        private readonly Flickr flickrApp;

        public FlickrInfrastructure(Flickr flickrApp)
        {
            this.flickrApp = flickrApp;

            flickrApp.ApiKey = "ee83fcb598d60f1081c08dac83f9882d";

            flickrApp.ApiSecret = "1ef6f20185274ebe";

            flickrApp.AuthToken = "72157626863345193-fac9def5c6ed227d";
        }

        public void DeletePhoto(string id)
        {
            this.flickrApp.PhotosDelete(id);
        }

        public PhotoInfo GetPhoto(string photoId)
        {
            var task = new Task<PhotoInfo>(() => this.flickrApp.PhotosGetInfo(photoId));

            task.Start();

            Task.WaitAll();

            return task.Result;
        }

        public Dictionary<int, PhotoInfo> GetPhotos(Dictionary<int, string> items)
        {
            var tasks = new Dictionary<int, Task<PhotoInfo>>();

            items.ToList().ForEach(
                i =>
                    {
                        var task = new Task<PhotoInfo>(() => this.flickrApp.PhotosGetInfo(i.Value));

                        tasks.Add(i.Key, task);

                        task.Start();
                    });

            Task.WaitAll();

            var dictionary = new Dictionary<int, PhotoInfo>();

            tasks.ToList().ForEach(t => dictionary.Add(t.Key, t.Value.Result));

            return dictionary;
        }

        public string UploadPhoto(HttpPostedFileBase file, string name)
        {
            var id = this.flickrApp.UploadPicture(
                file.InputStream, 
                file.FileName, 
                file.FileName, 
                string.Empty, 
                string.Empty, 
                true, 
                true, 
                false, 
                ContentType.Photo, 
                SafetyLevel.Safe, 
                HiddenFromSearch.Visible);

            return id;
        }
    }
}