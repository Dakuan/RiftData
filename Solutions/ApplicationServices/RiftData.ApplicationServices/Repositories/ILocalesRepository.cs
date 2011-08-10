using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.Repositories
{
    public interface ILocalesRepository
    {
        Locale GetById(int id);

        IList<Locale> GetLocalesWithSpecies(int speciesId);
    }
}