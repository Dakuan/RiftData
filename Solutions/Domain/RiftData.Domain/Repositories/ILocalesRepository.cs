namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface ILocalesRepository
    {
        AddResult Add(string name, double latitude, double longitude);

        DeleteResult Delete(int localeId);

        Locale Get(int localeId);

        IList<Locale> GetAll();

        Locale GetByFullName(string fullName);

        IList<Locale> GetForZoomLevel(int zoomLevel);

        IList<Locale> GetWithSpecies(int speciesId);

        UpdateResult Update(int localeId, string name, double latitude, double longitude);
    }
}