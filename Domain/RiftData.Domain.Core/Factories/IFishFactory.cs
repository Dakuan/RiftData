using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public interface IFishFactory
    {
        Fish Build(int id, Species species, Locale locale, bool hasPhoto);
    }
}
