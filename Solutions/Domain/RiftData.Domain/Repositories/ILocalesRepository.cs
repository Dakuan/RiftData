using System.Collections;
using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface ILocalesRepository
    {
        Locale GetById(int id);

        IList<Locale> GetLocalesWithSpecies(int speciesId);

        Locale GetByFullName(string fullName);

        IList<Locale> GetLocalesForZoomLevel(int zoomLevel);

        IList<Locale> GetAllLocales();
        AddResult Create(string name, double latitude, double longitude);
        UpdateResult Update(int localeId, string name, double latitude, double longitude);
        DeleteResult Delete(int localeId);
    }
}