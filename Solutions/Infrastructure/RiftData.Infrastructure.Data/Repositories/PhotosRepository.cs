using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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

            this.dataEntities.Fish.Where(f => f.Species.Id ==speciesId).ToList().ForEach(f => f.Photos.ToList().ForEach(list.Add));

            return list;
        }
    }
}
