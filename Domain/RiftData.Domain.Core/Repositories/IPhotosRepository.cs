using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IPhotosRepository
    {
        IQueryable<Photo> List { get; }

        IList<Photo> GetPhotosForSpecies(int speciesId);
    }
}