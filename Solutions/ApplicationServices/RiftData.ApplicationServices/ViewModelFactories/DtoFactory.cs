using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
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
                           Longitude = locale.Longitude,
                           HasPhotos = locale.HasPhotos
                       };
        }

        public SpeciesDto Build(Species species)
        {
            return new SpeciesDto
                       {
                           Id = species.Id,
                           Name = species.FullName,
                           UrlName = species.UrlName,
                           HasPhotos = species.HasPhotos
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

        public PhotoDto Build(Photo photo)
        {
            return new PhotoDto
                       {
                           Caption = photo.Caption,
                           Id = photo.Id,
                           MediumUrl = photo.MediumUrl,
                           ThumbNailUrl = photo.ThumbNailUrl,
                           SquareThumbnail = photo.SquareThumbnail
                       };
        }

        public GenusTypeDto Build(GenusType genusType)
        {
            return new GenusTypeDto { Id = genusType.Id, Name = genusType.Name };
        }
    }
}