using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface ITemperamentRepository
    {
        IList<Temperament> GetAll();

        Temperament Get(int temperamentId);
    }
}