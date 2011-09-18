using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IGenusTypeRepository
    {
        GenusType GetByName(string genusTypeName);

        IList<GenusType> GetAll();

        GenusType Get(int genusTypeId);

        GenusType GetFromSpecies(int speciesId);
        UpdateResult Update(int genusTypeId, string name, int lakeId);
        DeleteResult Delete(int genusTypeId);
        AddResult Add(string name, int lakeId);
    }
}