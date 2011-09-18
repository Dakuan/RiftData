using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IGenusRepository
    {
        IList<Genus> GetOfIdWithFish(int genusTypeId);
        
        IList<Genus> GetAll();

        IList<Genus> GetOfType(int genusTypeId);
        
        Genus Get(int genusId);

        AddResult Add(string name);

        UpdateResult Update(int genusId, string name);

        DeleteResult Delete(int genusId);
    }
}