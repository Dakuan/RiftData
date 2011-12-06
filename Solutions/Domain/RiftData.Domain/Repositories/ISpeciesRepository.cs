namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface ISpeciesRepository
    {
        AddResult Add(string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName);

        DeleteResult Delete(int speciesId);

        IList<Species> GetAll();

        IList<Species> GetSpeciesAtLocale(int id);

        Species GetSpeciesFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesWithGenus(int id);

        UpdateResult Update(int speciesId, string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName);
        
        IList<Species>GetWithoutLocales();
    }
}