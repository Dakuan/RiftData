namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Collections.Generic;
    using System.Linq;
    using Domain.Entities;
    using Presentation.Contracts;
    using Presentation.ViewModels.Dto;

    public class DtoFactory : IDtoFactory
    {
        public FishDto Build(Fish fish)
        {
            return new FishDto
                       {
                           Id = fish.Id,
                           Name = fish.Name,
                           Locale = this.Build(fish.Locale),
                           UrlName = fish.UrlName,
                           Species = this.Build(fish.Species)
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
                           HasPhotos = locale.HasPhotos,
                           ZoomLevel = locale.ZoomLevel
                       };
        }

        public SpeciesDto Build(Species species)
        {
            return new SpeciesDto
                       {
                           Id = species.Id,
                           Name = species.FullName,
                           UrlName = species.UrlName,
                           HasPhotos = species.HasPhotos,
                           Description = species.Description,
                           HasDescription = species.HasDescription
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

        public LakeDto Build(Lake lake)
        {

            var genustypes = new List<GenusTypeDto>();

            lake.GenusTypes.ToList().ForEach(g => genustypes.Add(this.Build(g)));

            return new LakeDto
                       {
                           Id = lake.Id,
                           Name = lake.Name,
                           GenusTypes = genustypes
                       };
        }
    }
}