using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Type = RiftData.Infrastructure.Data.Type;

namespace RiftData.Domain.Repositories
{
    public class GenusTypeRepository : RepositoryBase<GenusType, Type>, IGenusTypeRepository
    {
        private IGenusTypeFactory genusTypeFactory;

        public GenusTypeRepository(RiftDataDataEntities dataEntites, IGenusTypeFactory genusTypeFactory) : base(dataEntites)
        {
            this.genusTypeFactory = genusTypeFactory;
        }

        public IQueryable<GenusType> List
        {
            get
            {
                var list = new List<GenusType>();

                this.dataEntities.Type.ToList().ForEach(t => list.Add(this.genusTypeFactory.Build(t)));

                return list.AsQueryable();
            }
        }

        public IList<GenusType> GetGenusTypesContainingGenus()
        {
            var list = new List<GenusType>();

            this.dataEntities.Type.Where(t => t.Genus.Count > 0).ToList().ForEach(t => list.Add(this.genusTypeFactory.Build(t)));

            return list;
        }

        public GenusType GetGenusTypeByName(string genusTypeName)
        {
            return this.genusTypeFactory.Build(this.dataEntities.Type.Where(t => string.Equals(genusTypeName, t.GenusTypeName)).First());
        }

        protected override IEnumerable<GenusType> Sort(IEnumerable<GenusType> unsortedList)
        {
            //kinda redundant too really........
            throw new NotImplementedException();
        }

        protected override GenusType BuildUp(Type dataObject)
        {
            //redundant
            throw new NotImplementedException();
        }
    }
}