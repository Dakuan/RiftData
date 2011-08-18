using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IGenusTypeRepository
    {
        IList<GenusType> GetGenusTypesContainingGenus();

        GenusType GetGenusTypeByName(string genusTypeName);

        IList<GenusType> GetAll();

        GenusType GetGenusType(int genusTypeId);

        GenusType GetFromSpecies(int speciesId);
    }
}