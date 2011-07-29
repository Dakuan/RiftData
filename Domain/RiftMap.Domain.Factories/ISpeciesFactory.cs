using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Core;


namespace RiftMap.Domain.Factories
{
    public interface ISpeciesFactory
    {
        Species Build(int id);
    }
}
