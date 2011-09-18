using System.Collections;
using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface ILocalesRepository
    {
        Locale Get(int localeId);

        IList<Locale> GetWithSpecies(int speciesId);

        Locale GetByFullName(string fullName);

        IList<Locale> GetForZoomLevel(int zoomLevel);

        IList<Locale> GetAll();
        AddResult Add(string name, double latitude, double longitude);
        UpdateResult Update(int localeId, string name, double latitude, double longitude);
        DeleteResult Delete(int localeId);
    }
}