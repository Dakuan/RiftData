using Castle.Core;

namespace RiftData.Infrastructure.Data.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Factories;
    using RiftData.Domain.Repositories;
    using RiftData.Infrastructure.Flickr;

    public class PhotosRepository : IPhotosRepository
    {
        private readonly IFlickrInfrastructure flickrInfrastructure;

        private readonly IPhotoFactory photoFactory;

        private readonly RiftDataDataContext dataContext;

        public PhotosRepository(RiftDataDataContext dataContext, IFlickrInfrastructure flickrInfrastructure, IPhotoFactory photoFactory)
        {
            this.dataContext = dataContext;
            this.flickrInfrastructure = flickrInfrastructure;
            this.photoFactory = photoFactory;
        }

        public Photo Add(HttpPostedFileBase file, int id)
        {
            // save the photo to flickr,
            var flickrId = this.flickrInfrastructure.UploadPhoto(file, file.FileName);

            // get the photo info
            var photoInfo = this.flickrInfrastructure.GetPhoto(flickrId);

            // save to database
            var dbPhoto = this.dataContext.Photos.Add(this.photoFactory.CreatePhoto(photoInfo));

            this.dataContext.Fish.First(f => f.Id == id).Photos.Add(dbPhoto);

            this.dataContext.SaveChanges();

            // return the domain object));
            return dbPhoto;
        }

        public DeleteResult Delete(int photoId)
        {
            var photo = this.dataContext.Photos.First(p => p.Id == photoId);

            try
            {
                this.dataContext.Photos.Remove(photo);

                this.flickrInfrastructure.DeletePhoto(photo.FlickrId);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public DeleteResult Delete(string flickrId)
        {
            try
            {
                var photo = this.dataContext.Photos.First(p => p.FlickrId == flickrId);

                this.dataContext.Photos.Remove(photo);

                this.dataContext.SaveChanges();

                this.flickrInfrastructure.DeletePhoto(flickrId);
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public IList<Photo> GetForLocale(int localeId)
        {
            var dictionary = new Dictionary<Photo, IPhotoSubject>();

            this.dataContext.Fish.Where(f => f.Locale.Id == localeId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictionary.Add(p, f)));

            return AddCaptionsForPhotos(dictionary).ToList();
        }

        public IList<Photo> GetForSpecies(int speciesId)
        {
            var dictonary = new Dictionary<Photo, IPhotoSubject>();

            this.dataContext.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictonary.Add(p, f)));

            return AddCaptionsForPhotos(dictonary).ToList();
        }

        public Photo GetSingleForSpecies(int speciesId)
        {
            return this.GetForSpecies(speciesId).FirstOrDefault();
        }

        public Photo GetSingleForGenus(int genusId)
        {
            var fish = this.dataContext.Fish.Where(f => f.Genus.Id == genusId && f.Photos.Count > 0).FirstOrDefault();

            return fish == null ? null : fish.Photos.First();
        }

        public Photo GetSingleForGenusType(int genusTypeId)
        {
            var fish = this.dataContext.Fish.Where(f => f.Genus.GenusType.Id == genusTypeId && f.Photos.Count > 0).FirstOrDefault();

            return fish == null ? null : fish.Photos.First();
        }

        public bool AddCaption(int photoId, string caption)
        {
            var photo = this.dataContext.Photos.FirstOrDefault(x => x.Id == photoId);

            if (photo == null)
            {
                return false;
            }

            photo.Caption = caption;

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        public IList<Photo> GetAll()
        {
            var dictionary = new Dictionary<Photo, IPhotoSubject>();

            this.dataContext.Fish.Where(f => f.Photos.Count > 0).ToList().ForEach(x => x.Photos.ToList().ForEach(y => dictionary.Add(y, x)));

            return AddCaptionsForPhotos(dictionary).ToList();
        }

        private static IEnumerable<Photo> AddCaptionsForPhotos(Dictionary<Photo, IPhotoSubject> dictionary)
        {
            var list = new List<Photo>();

            dictionary.ToList().ForEach(d =>
                {
                    if (string.IsNullOrEmpty(d.Key.Title))
                    {
                        d.Key.Title = d.Value.Name;
                    }

                    list.Add(d.Key);
                });

            return list;
        }
    }
}