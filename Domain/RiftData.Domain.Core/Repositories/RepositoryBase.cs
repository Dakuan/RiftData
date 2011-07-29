using System;
using System.Linq;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public abstract class RepositoryBase<T> : IRepository<T>
    {
        protected RiftDataDataEntities dataEntites;

        protected RepositoryBase(RiftDataDataEntities dataEntites)
        {
            this.dataEntites = dataEntites;
        }

        public virtual IQueryable<T> List
        {
            get { throw new NotImplementedException(); }
        }
    }
}
