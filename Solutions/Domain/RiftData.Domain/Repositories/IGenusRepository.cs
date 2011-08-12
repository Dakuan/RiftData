using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IGenusRepository
    {
        IQueryable<Genus> List { get; }

        IList<Genus> GetGenusOfIdWithFish(int genusTypeId);
    }
}