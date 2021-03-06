namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface IGenusTypeRepository
    {
        AddResult Add(string name, int lakeId, string userName);

        DeleteResult Delete(int genusTypeId);

        GenusType Get(int genusTypeId);

        IList<GenusType> GetAll();

        GenusType GetByName(string genusTypeName);

        GenusType GetFromSpecies(int speciesId);

        UpdateResult Update(int genusTypeId, string name, int lakeId, string userName);

        IList<GenusType> GetFromLake(int lakeId);

        IList<GenusType> GetFromLocale(int localeId);
    }
}