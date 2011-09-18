using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IFishRepository
    {
        IList<Fish> GetBySpecies(int speciesId);

        IList<Fish> GetByLocale(int localeId);

        Fish GetFromName(string fishName);

        Fish GetFish(int fishId);

        IList<Fish> GetOfType(int genusTypeId);

        AddResult Add(int genusId, int speciesId, int localeId, string description);

        UpdateResult Update(int fishId, int genusId, int speciesId, int localeId, string description);
        DeleteResult Delete(int fishId);
    }
}