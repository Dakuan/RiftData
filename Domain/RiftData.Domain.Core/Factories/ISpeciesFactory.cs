using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public interface ISpeciesFactory
    {
        Species Build(Infrastructure.Data.Species dataSpecies, Genus genus);
    }
}