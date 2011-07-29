using RiftData.Domain.Core;
using Genus = RiftData.Domain.Core.Genus;
using DataSpecies = RiftData.Infrastructure.Data.Species;

namespace RiftMap.Domain.Factories
{
    public interface ISpeciesFactory
    {
        Species Build(DataSpecies dataSpecies, Genus genus);
    }
}