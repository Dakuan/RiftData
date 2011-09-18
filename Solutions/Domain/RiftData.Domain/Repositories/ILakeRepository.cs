using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface ILakeRepository
    {
        Lake GetLakeFromSpeciesId(int speciesId);

        IList<Lake> GetAll();

        Lake GetFromGenusType(int genusTypeId);

        Lake GetFromName(string lakeName);
    }
}