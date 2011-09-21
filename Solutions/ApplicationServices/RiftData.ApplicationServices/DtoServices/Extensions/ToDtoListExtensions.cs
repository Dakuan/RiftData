namespace RiftData.ApplicationServices.DtoServices.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.ApplicationServices.ViewModelFactories;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Logs;
    using RiftData.Presentation.ViewModels.Dto;

    public static class ToDtoListExtensions
    {
        public static IList<FishDto> ToDtoList(this IEnumerable<Fish> domainList)
        {
            var dtoList = new List<FishDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<GenusDto> ToDtoList(this IEnumerable<Genus> domainList)
        {
            var dtoList = new List<GenusDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<SpeciesDto> ToDtoList(this IEnumerable<Species> domainList)
        {
            var dtoList = new List<SpeciesDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<LocaleDto> ToDtoList(this IEnumerable<Locale> domainList)
        {
            var dtoList = new List<LocaleDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<GenusTypeDto> ToDtoList(this IEnumerable<GenusType> domainList)
        {
            var dtoList = new List<GenusTypeDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<LakeDto> ToDtoList(this IEnumerable<Lake> domainList)
        {
            var dtoList = new List<LakeDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<PhotoDto> ToDtoList(this IEnumerable<Photo> domainList)
        {
            var dtoList = new List<PhotoDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }

        public static IList<UserLogDto> ToDtoList(this IEnumerable<UserLog> domainList)
        {
            var dtoList = new List<UserLogDto>();

            domainList.ToList().ForEach(x => dtoList.Add(DtoFactory.Build(x)));

            return dtoList;
        }
    }
}