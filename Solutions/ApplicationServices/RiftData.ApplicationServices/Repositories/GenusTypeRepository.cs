using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data;

namespace RiftData.ApplicationServices.Repositories
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
            return this.dataEntities.GenusTypes.ToList();
            //return this.dataEntities.GenusTypes.Where(t => t.Genus.Count > 0).ToList();
        }

        public GenusType GetGenusTypeByName(string genusTypeName)
        {
            var species = this.dataEntities.Species.ToList()[0].Genus;

            var id = species.Id;

            return this.dataEntities.GenusTypes.Where(t => string.Equals(genusTypeName, t.Name)).First();
        }
    }
}