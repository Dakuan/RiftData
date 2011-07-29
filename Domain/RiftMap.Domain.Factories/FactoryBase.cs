using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Infrastructure.Data;

namespace RiftMap.Domain.Factories
{
    public abstract class FactoryBase
    {
        protected RiftDataDataEntities dataEntities;

        protected FactoryBase(RiftDataDataEntities dataEntities)
        {
            this.dataEntities = dataEntities;
        }
    }
}
