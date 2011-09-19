namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface IGenusTypeRepository
    {
        AddResult Add(string name, int lakeId);

        DeleteResult Delete(int genusTypeId);

        GenusType Get(int genusTypeId);

        IList<GenusType> GetAll();

        GenusType GetByName(string genusTypeName);

        GenusType GetFromSpecies(int speciesId);

        UpdateResult Update(int genusTypeId, string name, int lakeId);
    }
}