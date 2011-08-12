using System;
using System.Collections.Generic;
using System.Linq;
using FlickrNet;
using RiftData.Domain.Repositories;
using Photo = RiftData.Domain.Entities.Photo;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class PhotosRepository : IPhotosRepository
    {
        private Flickr flickrApp;
        private readonly RiftDataDataContext dataEntities;

        public PhotosRepository(Flickr flickrApp, RiftDataDataContext dataEntities)
        {
            this.flickrApp = flickrApp;
            this.dataEntities = dataEntities;

            flickrApp.ApiKey = "ee83fcb598d60f1081c08dac83f9882d";

            flickrApp.ApiSecret = "1ef6f20185274ebe";

            flickrApp.AuthToken = "72157626863345193-fac9def5c6ed227d";

        }

        public IQueryable<Photo> List
        {
            get { throw new NotImplementedException(); }
        }

        public IList<Photo>GetPhotosForSpecies(int speciesId)
        {
            var list = new List<Photo>();

            /*
            this.dataEntities.Fish.Where(
                f => f.Species.Id == speciesId && dataEntities.Photos.Any(p => p.FishId == f.FishID)).ToList().ForEach(
                    f => this.dataEntities.Photos.Where(p => p.FishId == f.FishID && p.FlickrId != null).ToList().ForEach(list.Add));


            var tasks = new Dictionary<int, Task<PhotoInfo>>();

            list.ForEach(t => tasks.Add(t.ID, new Task<PhotoInfo>(() => this.flickrApp.PhotosGetInfo(t.FlickrId))));

            tasks.ToList().ForEach(t => t.Value.Start());

            Task.WaitAll();

            var photoList = new List<Photo>();

            tasks.ToList().ForEach(t =>
                                       {
                                           var dataPhoto = this.dataEntities.Photos.Where(p => p.ID == t.Key).First();

                                           var fish = this.dataEntities.Fish.Where(f => f.FishID == dataPhoto.FishId).First();

                                           var caption = RiftData.Domain.Entities.Fish.GetFullName(fish.Genus1.GenusName, fish.Species1.SpeciesName, fish.Locale1.LocaleName, Convert.ToBoolean(fish.Species1.Described));

                                           photoList.Add(this.photoFactory.Build(t.Value.Result, t.Key, caption));
                                       });
            */
            return list;
        }
    }
}
