using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public class LocalesFactory : ILocalesFactory
    {
        public Locale Build(Infrastructure.Data.Locale dataLocale, bool hasPhoto)
        {
            return new Locale(dataLocale.LocaleID) { Latitude = dataLocale.Lat, Longitude = dataLocale.Long, Name = dataLocale.LocaleName, HasPhotos = hasPhoto };
        }
    }
}
