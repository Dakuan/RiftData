using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Collections.Generic;
    using System.Linq;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Logs;
    using RiftData.Presentation.ViewModels.Dto;

    public static class DtoFactory
    {
        public static UserLogDto Build(UserLog log)
        {
            return new UserLogDto { Date = log.Date.ToShortDateString(), Message = log.Message };
        }

        public static FishDto Build(Fish fish)
        {
            return new FishDto
                {
                    Id = fish.Id, 
                    Name = fish.Name, 
                    Locale = Build(fish.Locale), 
                    UrlName = fish.UrlName, 
                    Genus = Build(fish.Genus), 
                    Species = Build(fish.Species), 
                    Description = string.IsNullOrEmpty(fish.Description) ? fish.Species.Description : fish.Description, 
                    Photos = fish.Photos.ToDtoList()
                };
        }

        public static LocaleDto Build(Locale locale)
        {
            return new LocaleDto { Id = locale.Id, Name = locale.Name, Latitude = locale.Latitude, Longitude = locale.Longitude, HasPhotos = locale.HasPhotos, ZoomLevel = locale.ZoomLevel, Description = locale.Description, HasDescription = locale.HasDescription, Lake = Build(locale.Lake) };
        }

        public static SpeciesDto Build(Species species)
        {
            return new SpeciesDto { Id = species.Id, Name = species.FullName, UrlName = species.UrlName, HasPhotos = species.HasPhotos, Description = species.Description, HasDescription = species.HasDescription, Temperament = species.Temperament.Name, SizeString = species.MaxSize == 0 || species.MinSize == 0 ? "Unknown" : string.Format("{0} - {1}cm", species.MinSize, species.MaxSize), GenusName = species.Genus.Name };
        }

        public static GenusDto Build(Genus genus)
        {
            var speciesList = new List<SpeciesDto>();

            genus.Species.ToList().ForEach(s => speciesList.Add(Build(s)));

            return new GenusDto { Id = genus.Id, Name = genus.Name, Species = speciesList };
        }

        public static PhotoDto Build(Photo photo)
        {
            return new PhotoDto { Caption = photo.Caption, Id = photo.Id, MediumUrl = photo.MediumUrl, ThumbNailUrl = photo.ThumbNailUrl, SquareThumbnail = photo.SquareThumbnail };
        }

        public static GenusTypeDto Build(GenusType genusType)
        {
            var genera = new List<GenusDto>();

            genusType.Genus.ToList().ForEach(t => genera.Add(Build(t)));

            return new GenusTypeDto { Genera = genera, Id = genusType.Id, Name = genusType.Name, Description = genusType.Description, NumberOfGenera = genusType.Genus.Count, Lake = new LakeDto { Id = genusType.Lake.Id, Name = genusType.Lake.Name } };
        }

        public static LakeDto Build(Lake lake)
        {
            return new LakeDto { Id = lake.Id, Name = lake.Name, GenusTypes = lake.GenusTypes.ToDtoList(), Description = lake.Description };
        }
    }
}