using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public class GenusTypeRepository : RepositoryBase<GenusType>
    {
        private IGenusTypeFactory genusTypeFactory;

        public GenusTypeRepository(RiftDataDataEntities dataEntites, IGenusTypeFactory genusTypeFactory) : base(dataEntites)
        {
            this.genusTypeFactory = genusTypeFactory;
        }

        public override IQueryable<GenusType> List
        {
            get
            {
                var list = new List<GenusType>();

                this.dataEntites.Type.ToList().ForEach(t => list.Add(this.genusTypeFactory.Build(t)));

                return list.AsQueryable();
            }
        }
    }
}
