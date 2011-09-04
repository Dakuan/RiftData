using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class PhotosRepository : IPhotosRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public PhotosRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public IList<Photo>GetPhotosForSpecies(int speciesId)
        {
            var dictonary = new Dictionary<Photo, IPhotoSubject>();

            this.dataEntities.Fish.Where(f => f.Species.Id ==speciesId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictonary.Add(p,f)));

            return AddCaptionsForPhotos(dictonary).ToList();
        }

        public IEnumerable<Photo> GetPhotosForLocale(int localeId)
        {
            var dictionary = new Dictionary<Photo, IPhotoSubject>();

            this.dataEntities.Fish.Where(f => f.Locale.Id == localeId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictionary.Add(p, f)));

            return AddCaptionsForPhotos(dictionary);
        }

        private static IEnumerable<Photo> AddCaptionsForPhotos(Dictionary<Photo, IPhotoSubject> dictionary)
        {
            var list = new List<Photo>();

            dictionary.ToList().ForEach(d =>
                                            {
                                                if (string.IsNullOrEmpty(d.Key.Caption))
                                                {
                                                    d.Key.Caption = d.Value.Name;
                                                }

                                                list.Add(d.Key);
                                            });

            return list;
        }
    }
}