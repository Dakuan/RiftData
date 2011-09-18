using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IFishRepository
    {
        IQueryable<Fish> List { get; }

        IQueryable<Fish> GetFishBySpecies(int speciesId);

        IList<Fish> GetFishByLocale(int localeId);

        Fish GetFishFromName(string fishName);

        Fish GetFish(int fishId);
        IList<Fish> GetFishOfType(int genusTypeId);
        AddResult Add(int genusId, int speciesId, int localeId, string description);

        UpdateResult Update(int fishId, int genusId, int speciesId, int localeId, string description);
        DeleteResult Delete(int fishId);
    }
}