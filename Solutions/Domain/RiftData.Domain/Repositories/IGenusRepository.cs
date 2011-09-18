using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IGenusRepository
    {
        IQueryable<Genus> List { get; }

        IList<Genus> GetGenusOfIdWithFish(int genusTypeId);
        
        IList<Genus> GetAllGenus();

        IList<Genus> GetGenusOfType(int genusTypeId);
        
        Genus GetGenus(int genusId);

        AddResult Add(string name);

        UpdateResult Update(int genusId, string name);

        DeleteResult Delete(int genusId);
    }
}