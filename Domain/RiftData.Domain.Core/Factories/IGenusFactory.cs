using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public interface IGenusFactory
    {
        Genus Build(Infrastructure.Data.Genus dataGenus);
    }
}