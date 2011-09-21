namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface IGenusRepository
    {
        AddResult Add(string name, string userName);

        DeleteResult Delete(int genusId);

        Genus Get(int genusId);

        IList<Genus> GetAll();

        IList<Genus> GetOfIdWithFish(int genusTypeId);

        IList<Genus> GetOfType(int genusTypeId);

        UpdateResult Update(int genusId, string userName);
    }
}