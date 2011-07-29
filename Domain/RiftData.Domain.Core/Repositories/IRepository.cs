using System.Linq;

namespace RiftData.Domain.Repositories
{
    public interface IRepository<out T>
    {
        IQueryable<T> List { get; }
    }
}
