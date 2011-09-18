using System.Collections.Generic;
using System.Web;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IPhotosRepository
    {
        IList<Photo> GetPhotosForSpecies(int speciesId);

        IEnumerable<Photo> GetPhotosForLocale(int localeId);

        DeleteResult Delete(int photoId);

        Photo Add(HttpPostedFileBase file, int id);

        DeleteResult Delete(string flickrId);
    }
}