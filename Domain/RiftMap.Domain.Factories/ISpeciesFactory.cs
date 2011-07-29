using RiftData.Domain.Core;
using Genus = RiftData.Domain.Core.Genus;

namespace RiftMap.Domain.Factories
{
    public interface ISpeciesFactory
    {
        Species Build(int id, Genus genus);
    }
}