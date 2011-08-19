namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;
    using RiftData.Domain.Entities;

    public interface ISpeciesRepository
    {
        Species GetSpeciesFromFullName(string speciesFullName);

        Species GetSpeciesFromId(int speciesId);

        IList<Species> GetSpeciesAtLocale(int id);
    }
}