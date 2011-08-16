using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IFishRepository
    {
        IQueryable<Fish> List { get; }

        IQueryable<Fish> GetFishBySpecies(int speciesId);

        IList<Fish> GetFishByLocale(int localeId);

        Fish GetFishFromName(string fishName);
    }
}