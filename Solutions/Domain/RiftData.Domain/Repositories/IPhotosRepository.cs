using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IPhotosRepository
    {
        IList<Photo> GetPhotosForSpecies(int speciesId);
    }
}