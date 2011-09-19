namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;

    public interface ITemperamentRepository
    {
        Temperament Get(int temperamentId);

        IList<Temperament> GetAll();
    }
}