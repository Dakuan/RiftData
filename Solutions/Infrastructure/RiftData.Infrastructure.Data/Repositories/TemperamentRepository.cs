using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class TemperamentRepository : ITemperamentRepository
    {
        private readonly RiftDataDataContext _dataContext;

        public TemperamentRepository(RiftDataDataContext dataContext)
        {
            _dataContext = dataContext;
        }

        public IList<Temperament> GetAll()
        {
            return this._dataContext.Temperaments.ToList();
        }

        public Temperament Get(int temperamentId)
        {
            return this._dataContext.Temperaments.First(t => t.Id == temperamentId);
        }
    }
}