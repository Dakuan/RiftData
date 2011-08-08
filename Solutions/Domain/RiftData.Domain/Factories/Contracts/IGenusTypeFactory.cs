using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data;
using Type = RiftData.Infrastructure.Data.Type;

namespace RiftData.Domain.Factories
{
    public interface IGenusTypeFactory
    {
        GenusType Build(Type dataGenusType);
    }
}
