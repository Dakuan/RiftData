namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;

    public interface ILakeRepository
    {
        IList<Lake> GetAll();

        Lake GetFromGenusType(int genusTypeId);

        Lake GetFromName(string lakeName);

        Lake GetLakeFromSpeciesId(int speciesId);
    }
}