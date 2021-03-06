namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface IFishRepository
    {
        Fish Add(int genusId, int speciesId, int localeId, string description);

        DeleteResult Delete(int fishId);

        IList<Fish> GetByLocale(int localeId);

        IList<Fish> GetBySpecies(int speciesId);

        Fish GetFish(int fishId);

        Fish GetFromName(string fishName);

        IList<Fish> GetOfType(int genusTypeId);

        Fish Update(int fishId, int genusId, int speciesId, int localeId, string description);
        
        IList<Fish> GetWithoutPhotos();
    }
}