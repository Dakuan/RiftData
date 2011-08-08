using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface ISpeciesRepository
    {
        IQueryable<Species> List { get; }

        int FindSpeciesIdFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesAtLocale(int id);
    }
}