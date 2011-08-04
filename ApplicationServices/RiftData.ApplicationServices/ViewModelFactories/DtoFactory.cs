using RiftData.Domain.Entities;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class DtoFactory : IDtoFactory
    {
        public FishDto Build(Fish fish)
        {
            return new FishDto
                       {
                           Id = fish.Id,
                           Name = fish.FullName,
                           LocaleName = fish.Locale.Name,
                           Latitude = fish.Locale.Latitude,
                           Longitude = fish.Locale.Longitude
                       };
        }
    }
}
