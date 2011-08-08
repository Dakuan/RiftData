using RiftData.Infrastructure.Data;
using Genus = RiftData.Domain.Entities.Genus;

namespace RiftData.Domain.Factories
{
    public interface IGenusFactory
    {
        Genus Build(Infrastructure.Data.Genus dataGenus, RiftDataDataEntities dataEntities);
    }
}