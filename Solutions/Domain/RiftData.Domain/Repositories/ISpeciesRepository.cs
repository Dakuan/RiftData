namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface ISpeciesRepository
    {
        Species GetSpeciesFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesAtLocale(int id);

        IList<Species> GetAll();

        IList<Species>GetWithoutLocales();

        IList<Species> GetSpeciesWithGenus(int id);
        
        Species Add(string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName);

        UpdateResult Update(int speciesId, string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName);
        
        DeleteResult Delete(int speciesId);
    }
}