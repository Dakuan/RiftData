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

    public class LakeRepository : ILakeRepository
    {
        private readonly RiftDataDataContext dataContext;

        private readonly ILogger logger;

        public LakeRepository(RiftDataDataContext dataContext, ILogger logger)
        {
            this.dataContext = dataContext;
            this.logger = logger;
        }

        public IList<Lake> GetAll()
        {
            return this.dataContext.Lakes.SortLakes().ToList();
        }

        public Lake GetFromGenusType(int genusTypeId)
        {
            return this.dataContext.Lakes.First(l => l.GenusTypes.Any(g => g.Id == genusTypeId));
        }

        public Lake GetFromName(string lakeName)
        {
            return this.dataContext.Lakes.First(l => string.Equals(lakeName, l.Name));
        }

        public Lake GetLakeFromSpeciesId(int speciesId)
        {
            return this.dataContext.Lakes.First(l => l.GenusTypes.Any(t => t.Genus.Any(g => g.Species.Any(s => s.Id == speciesId))));
        }

        public Lake Get(int lakeId)
        {
            return this.dataContext.Lakes.First(l => l.Id == lakeId);
        }

        public UpdateResult Update(int lakeId, string description, string name, string userName)
        {
            var lake = this.dataContext.Lakes.FirstOrDefault(l => l.Id == lakeId);

            if (lake == null)
            {
                return UpdateResult.DoesNotExist;
            }

            lake.Description = description;

            lake.Name = name.Trim();

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return UpdateResult.Failure;
            }

            this.logger.LogUpdate(lake, userName);

            return UpdateResult.Success;
        }

        public IList<Lake> GetAllWithGenusTypes()
        {
            return this.dataContext.Lakes.Where(l => l.GenusTypes.Count > 0).ToList();
        }

        public Lake GetFirst()
        {
            return this.dataContext.Lakes.First();
        }
    }
}