using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Type = RiftData.Infrastructure.Data.Type;

namespace RiftData.Domain.Repositories
{
    public class GenusTypeRepository : RepositoryBase<GenusType, RiftData.Infrastructure.Data.Type>, IGenusTypeRepository
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

        protected override IEnumerable<GenusType> Sort(IEnumerable<GenusType> unsortedList)
        {
            throw new NotImplementedException();
        }

        protected override GenusType BuildUp(Type dataObject)
        {
            throw new NotImplementedException();
        }
    }
}
