﻿namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;
    using System.Web;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface IPhotosRepository
    {
        Photo Add(HttpPostedFileBase file, int id);

        DeleteResult Delete(int photoId);

        DeleteResult Delete(string flickrId);

        IList<Photo> GetForLocale(int localeId);

        IList<Photo> GetForSpecies(int speciesId);
    }
}