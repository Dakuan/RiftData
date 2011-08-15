using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface ILocalesRepository
    {
        Locale GetById(int id);

        IList<Locale> GetLocalesWithSpecies(int speciesId);

        Locale GetByFullName(string fullName);

        IList<Locale> GetLocalesForZoomLevel(int zoomLevel);
    }
}