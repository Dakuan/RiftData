using System.Web;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Collections.Generic;
    using System.Linq;
    using Domain.Entities;
    using Presentation.Contracts;
    using Presentation.ViewModels.Dto;

    public static class DtoFactory
    {
        public static FishDto Build(Fish fish)
        {
            return new FishDto
                       {
                           Id = fish.Id,
                           Name = fish.Name,
                           Locale = Build(fish.Locale),
                           UrlName = fish.UrlName,
                           Species = Build(fish.Species),
                           Description = HttpUtility.HtmlDecode(fish.Description),
                           HasDescription = fish.HasDescription
                       };
        }
        public static LocaleDto Build(Locale locale)
        {
            return new LocaleDto
                       {
                           Id = locale.Id,
                           Name = locale.Name,
                           Latitude = locale.Latitude,
                           Longitude = locale.Longitude,
                           HasPhotos = locale.HasPhotos,
                           ZoomLevel = locale.ZoomLevel,
                           Description = locale.Description,
                           HasDescription = locale.HasDescription
                       };
        }
        public static SpeciesDto Build(Species species)
        {
            return new SpeciesDto
                       {
                           Id = species.Id,
                           Name = species.FullName,
                           UrlName = species.UrlName,
                           HasPhotos = species.HasPhotos,
                           Description = species.Description,
                           HasDescription = species.HasDescription,
                           Temperament = species.Temperament.Name,
                           SizeString = species.MaxSize == 0 || species.MinSize == 0 ? "Unknown" : string.Format("{0} - {1}cm", species.MinSize, species.MaxSize)
                       };
        }
        public static GenusDto Build(Genus genus)
        {
            var speciesList = new List<SpeciesDto>();

            genus.Species.ToList().ForEach(s => speciesList.Add(Build(s)));

            return new GenusDto
                       {
                           Id = genus.Id,
                           Name = genus.Name,
                           Species = speciesList
                       };
        }
        public static PhotoDto Build(Photo photo)
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
        public static GenusTypeDto Build(GenusType genusType)
        {
            return new GenusTypeDto { Id = genusType.Id, Name = genusType.Name, Description = genusType.Description};
        }
        public static LakeDto Build(Lake lake)
        {

            var genustypes = new List<GenusTypeDto>();

            lake.GenusTypes.ToList().ForEach(g => genustypes.Add(Build(g)));

            return new LakeDto
                       {
                           Id = lake.Id,
                           Name = lake.Name,
                           GenusTypes = genustypes
                       };
        }
    }
}