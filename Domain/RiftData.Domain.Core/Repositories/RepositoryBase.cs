using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public abstract class RepositoryBase<TDomain, TData>
    {
        protected readonly RiftDataDataEntities dataEntities;

        protected RepositoryBase(RiftDataDataEntities dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        protected abstract IEnumerable<TDomain> Sort(IEnumerable<TDomain> unsortedList);

        protected abstract TDomain BuildUp(TData dataObject);
    }
}
