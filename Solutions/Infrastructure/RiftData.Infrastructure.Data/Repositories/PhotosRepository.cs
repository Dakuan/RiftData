using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;
using RiftData.Domain.Factories;
using RiftData.Domain.Repositories;
using RiftData.Infrastructure.Flickr;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class PhotosRepository : IPhotosRepository
    {
        private readonly RiftDataDataContext dataContext;
        private readonly IFlickrInfrastructure _flickrInfrastructure;
        private readonly IPhotoFactory _photoFactory;

        public PhotosRepository(RiftDataDataContext dataContext,  IFlickrInfrastructure flickrInfrastructure, IPhotoFactory photoFactory)
        {
            this.dataContext = dataContext;
            _flickrInfrastructure = flickrInfrastructure;
            _photoFactory = photoFactory;
        }

        public IList<Photo>GetForSpecies(int speciesId)
        {
            var dictonary = new Dictionary<Photo, IPhotoSubject>();

            this.dataContext.Fish.Where(f => f.Species.Id ==speciesId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictonary.Add(p,f)));

            return AddCaptionsForPhotos(dictonary).ToList();
        }

        public IList<Photo> GetForLocale(int localeId)
        {
            var dictionary = new Dictionary<Photo, IPhotoSubject>();

            this.dataContext.Fish.Where(f => f.Locale.Id == localeId).ToList().ForEach(f => f.Photos.ToList().ForEach(p => dictionary.Add(p, f)));

            return AddCaptionsForPhotos(dictionary).ToList();
        }

        public DeleteResult Delete(int photoId)
        {
            var photo = this.dataContext.Photos.First(p => p.Id == photoId);

            try
            {
                dataContext.Photos.Remove(photo);

                this._flickrInfrastructure.DeletePhoto(photo.FlickrId);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public Photo Add(HttpPostedFileBase file, int id)
        {
            //save the photo to flickr,
            var flickrId = this._flickrInfrastructure.UploadPhoto(file, file.FileName);

            //get the photo info
            var photoInfo = this._flickrInfrastructure.GetPhoto(flickrId);

            //save to database
            var dbPhoto = this.dataContext.Photos.Add(this._photoFactory.CreatePhoto(photoInfo));

            this.dataContext.Fish.First(f => f.Id == id).Photos.Add(dbPhoto);

            this.dataContext.SaveChanges();

            //return the domain object));
            return dbPhoto;
        }

        public DeleteResult Delete(string flickrId)
        {
            try
            {
                var photo = this.dataContext.Photos.First(p => p.FlickrId == flickrId);

                dataContext.Photos.Remove(photo);

                this.dataContext.SaveChanges();

                this._flickrInfrastructure.DeletePhoto(flickrId);
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
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