namespace RiftData.Infrastructure.Data.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Infrastructure.Data.Logging;

    public class LocalesRepository : ILocalesRepository
    {
        private readonly RiftDataDataContext dataContext;

        private readonly ILogger logger;

        public LocalesRepository(RiftDataDataContext dataContext, ILogger logger)
        {
            this.dataContext = dataContext;
            this.logger = logger;
        }

        public AddResult Add(int lakeId, string name, double latitude, double longitude, string userName)
        {
            var lake = this.dataContext.Lakes.First(x => x.Id == lakeId);

            var locale = new Locale { Name = name.Trim(), Latitude = latitude, Longitude = longitude, Lake = lake};

            this.dataContext.Locales.Add(locale);

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return AddResult.Failure;
            }

            this.logger.LogAdd(locale, userName);

            return AddResult.Success;
        }

        public DeleteResult Delete(int localeId)
        {
            var locale = this.dataContext.Locales.FirstOrDefault(l => l.Id == localeId);

            if (locale == null)
            {
                return DeleteResult.DoesNotExist;
            }

            this.dataContext.Locales.Remove(locale);

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public Locale Get(int localeId)
        {
            var dataLocale = this.dataContext.Locales.First(l => l.Id == localeId);

            if (dataLocale == null)
            {
                return null;
            }

            return dataLocale;
        }

        public IList<Locale> GetAll()
        {
            return this.dataContext.Locales.SortLocales().ToList();
        }

        public Locale GetByFullName(string fullName)
        {
            return this.dataContext.Locales.First(f => string.Equals(f.Name, fullName));
        }

        public IList<Locale> GetForZoomLevel(int zoomLevel)
        {
            var dataZoom = Locale.GetDataZoomFromMapZoom(zoomLevel);

            return this.dataContext.Locales.Where(l => l.ZoomLevel <= dataZoom).SortLocales().ToList();
        }

        public IList<Locale> GetWithSpecies(int speciesId)
        {
            var list = new List<Locale>();

            this.dataContext.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(f => list.Add(f.Locale));

            return list.SortLocales().ToList();
        }

        public UpdateResult Update(int localeId, string name, double latitude, double longitude, string userName)
        {
            var locale = this.dataContext.Locales.FirstOrDefault(l => l.Id == localeId);

            if (locale == null)
            {
                return UpdateResult.DoesNotExist;
            }

            locale.Name = name;

            locale.Latitude = latitude;

            locale.Longitude = longitude;

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return UpdateResult.Failure;
            }

            this.logger.LogUpdate(locale, userName);

            return UpdateResult.Success;
        }

        public IList<Locale> GetByLake(int lakeId)
        {
            return this.dataContext.Locales.Where(l => l.Lake.Id == lakeId).ToList();
        }

        public IList<Locale> GetForLakeAtZoomLevel(int zoomLevel, int lakeId)
        {
            return this.GetForZoomLevel(zoomLevel).Where(x => x.Lake.Id == lakeId).ToList();
        }
    }
}