using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class LakeRepository : ILakeRepository
    {
        private readonly RiftDataDataContext _dataContext;

        public LakeRepository(RiftDataDataContext dataContext)
        {
            _dataContext = dataContext;
        }

        public Lake GetLakeFromSpeciesId(int speciesId)
        {
            return this._dataContext.Lakes.First(l => l.GenusTypes.Any(t => t.Genus.Any(g => g.Species.Any(s => s.Id == speciesId))));
        }

        public IList<Lake> GetAll()
        {
            return this._dataContext.Lakes.SortLakes().ToList();
        }

        public Lake GetLakeFromGenusType(int id)
        {
            return this._dataContext.Lakes.First(l => l.GenusTypes.Any(g => g.Id == id));
        }
    }
}
