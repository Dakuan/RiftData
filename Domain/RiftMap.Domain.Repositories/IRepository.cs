using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftMap.Domain.Repositories
{
    public interface IRepository<out T>
    {
        IQueryable<T> List { get; }
    }
}
