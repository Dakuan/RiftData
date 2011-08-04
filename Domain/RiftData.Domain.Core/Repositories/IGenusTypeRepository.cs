using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IGenusTypeRepository
    {
        IQueryable<GenusType> List { get; }
    }
}