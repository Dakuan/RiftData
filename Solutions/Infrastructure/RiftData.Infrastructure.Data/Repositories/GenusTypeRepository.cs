using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class GenusTypeRepository : IGenusTypeRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public GenusTypeRepository(RiftDataDataContext dataEntities)
        {
           this.dataEntities = dataEntities;
        }

        public IList<GenusType> GetGenusTypesContainingGenus()
        {
            return this.dataEntities.GenusTypes.Where(t => t.Genus.Count > 0).ToList();
        }

        public GenusType GetGenusTypeByName(string genusTypeName)
        {
            return this.dataEntities.GenusTypes.Where(t => string.Equals(genusTypeName, t.Name)).First();
        }
    }
}