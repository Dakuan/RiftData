using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Core;
using DataGenus = RiftData.Infrastructure.Data.Genus;

namespace RiftMap.Domain.Factories
{
    public interface IGenusFactory
    {
        Genus Build(DataGenus dataGenus);
    }
}