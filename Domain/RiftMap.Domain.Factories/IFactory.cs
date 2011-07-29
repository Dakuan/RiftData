using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftMap.Domain.Factories
{
    public interface IFactory<T>
    {
        T Build(int id);
    }
}
