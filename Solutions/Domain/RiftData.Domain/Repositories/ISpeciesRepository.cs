using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;
    using Entities;

    public interface ISpeciesRepository
    {
        Species GetSpeciesFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesAtLocale(int id);

        IList<Species> GetSpeciesWithGenus(int id);

        IList<Species> GetAll();
        AddResult Add(string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId);
        UpdateResult Update(int speciesId, string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId);
        DeleteResult Delete(int speciesId);
    }
}