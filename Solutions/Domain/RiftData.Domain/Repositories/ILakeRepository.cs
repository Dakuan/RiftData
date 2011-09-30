namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface ILakeRepository
    {
        IList<Lake> GetAll();

        Lake GetFromGenusType(int genusTypeId);

        Lake GetFromName(string lakeName);

        Lake GetLakeFromSpeciesId(int speciesId);

        Lake Get(int lakeId);

        UpdateResult Update(int lakeId, string description, string name, string userName);

        IList<Lake> GetAllWithGenusTypes();

        Lake GetFirst();
    }
}