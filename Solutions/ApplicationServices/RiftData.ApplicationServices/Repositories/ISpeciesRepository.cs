using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.Repositories
{
    public interface ISpeciesRepository
    {
        int FindSpeciesIdFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesAtLocale(int id);
    }
}