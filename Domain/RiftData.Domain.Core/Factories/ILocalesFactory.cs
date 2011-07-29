using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public interface ILocalesFactory
    {
        Locale Build(RiftData.Infrastructure.Data.Locale dataLocale);
    }
}
