using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class DtoFactory : IDtoFactory
    {
        public FishDto Build(Fish fish)
        {
            return new FishDto
                       {
                           Id = fish.Id,
                           Name = fish.Name,
                           LocaleName = fish.Locale.Name,
                           Latitude = fish.Locale.Latitude,
                           Longitude = fish.Locale.Longitude
                       };
        }

        public LocaleDto Build(Locale locale)
        {
            return new LocaleDto
                       {
                           Id = locale.Id,
                           Name = locale.Name,
                           Latitude = locale.Latitude,
                           Longitude = locale.Longitude
                       };
        }

        public SpeciesDto Build(Species species)
        {
            return new SpeciesDto
                       {
                           Id = species.Id,
                           Name = species.FullName,
                           UrlName = species.UrlName
                       };
        }

        public GenusDto Build(Genus genus)
        {
            var speciesList = new List<SpeciesDto>();

            genus.Species.ToList().ForEach(s => speciesList.Add(this.Build(s)));

            return new GenusDto
                       {
                           Id = genus.Id,
                           Name = genus.Name,
                           Species = speciesList
                       };
        }
    }
}
