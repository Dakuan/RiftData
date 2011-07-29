using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Core;

namespace RiftMap.Domain.Factories
{
    public interface IGenusFactory
    {
        Genus Build(int id);
    }
}