using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.Repositories
{
    public interface IGenusTypeRepository
    {
        IList<GenusType> GetGenusTypesContainingGenus();

        GenusType GetGenusTypeByName(string genusTypeName);
    }
}