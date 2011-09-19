namespace RiftData.Infrastructure.Data.Repositories
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;

    public class TemperamentRepository : ITemperamentRepository
    {
        private readonly RiftDataDataContext _dataContext;

        public TemperamentRepository(RiftDataDataContext dataContext)
        {
            this._dataContext = dataContext;
        }

        public Temperament Get(int temperamentId)
        {
            return this._dataContext.Temperaments.First(t => t.Id == temperamentId);
        }

        public IList<Temperament> GetAll()
        {
            return this._dataContext.Temperaments.ToList();
        }
    }
}