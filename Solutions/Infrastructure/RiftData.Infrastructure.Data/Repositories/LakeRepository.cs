namespace RiftData.Infrastructure.Data.Repositories
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Extensions;
    using RiftData.Domain.Repositories;

    public class LakeRepository : ILakeRepository
    {
        private readonly RiftDataDataContext _dataContext;

        public LakeRepository(RiftDataDataContext dataContext)
        {
            this._dataContext = dataContext;
        }

        public IList<Lake> GetAll()
        {
            return this._dataContext.Lakes.SortLakes().ToList();
        }

        public Lake GetFromGenusType(int genusTypeId)
        {
            return this._dataContext.Lakes.First(l => l.GenusTypes.Any(g => g.Id == genusTypeId));
        }

        public Lake GetFromName(string lakeName)
        {
            return this._dataContext.Lakes.First(l => string.Equals(lakeName, l.Name));
        }

        public Lake GetLakeFromSpeciesId(int speciesId)
        {
            return this._dataContext.Lakes.First(l => l.GenusTypes.Any(t => t.Genus.Any(g => g.Species.Any(s => s.Id == speciesId))));
        }
    }
}