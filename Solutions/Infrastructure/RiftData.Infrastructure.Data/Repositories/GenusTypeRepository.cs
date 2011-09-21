using RiftData.Infrastructure.Data.Logging;

namespace RiftData.Infrastructure.Data.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;

    public class GenusTypeRepository : IGenusTypeRepository
    {
        private readonly RiftDataDataContext dataContext;
        private readonly ILogger logger;

        public GenusTypeRepository(RiftDataDataContext dataContext, ILogger logger)
        {
            this.dataContext = dataContext;
            this.logger = logger;
        }

        public AddResult Add(string name, int lakeId, string userName)
        {
            if (this.dataContext.GenusTypes.Any(g => g.Name == name))
            {
                return AddResult.AlreadyExists;
            }

            var lake = this.dataContext.Lakes.First(l => l.Id == lakeId);

            var genusType = new GenusType { Name = name, Lake = lake };
            try
            {
                this.dataContext.GenusTypes.Add(genusType);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return AddResult.Failure;
            }

            logger.LogAdd(genusType, userName);

            return AddResult.Success;
        }

        public DeleteResult Delete(int genusTypeId)
        {
            try
            {
                var genusType = this.Get(genusTypeId);

                if (genusType == null)
                {
                    return DeleteResult.DoesNotExist;
                }

                this.dataContext.GenusTypes.Remove(genusType);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public GenusType Get(int genusTypeId)
        {
            return this.dataContext.GenusTypes.First(g => g.Id == genusTypeId);
        }

        public IList<GenusType> GetAll()
        {
            return this.dataContext.GenusTypes.ToList();
        }

        public GenusType GetByName(string genusTypeName)
        {
            return this.dataContext.GenusTypes.Where(t => string.Equals(genusTypeName, t.Name)).First();
        }

        public GenusType GetFromSpecies(int speciesId)
        {
            return this.dataContext.GenusTypes.First(t => t.Genus.Any(g => g.Species.Any(s => s.Id == speciesId)));
        }

        public UpdateResult Update(int genusTypeId, string name, int lakeId, string userName)
        {
            try
            {
                var genusType = this.Get(genusTypeId);

                var lake = this.dataContext.Lakes.First(l => l.Id == lakeId);

                genusType.Name = name;

                genusType.Lake = lake;

                this.dataContext.SaveChanges();

                logger.LogUpdate(genusType, userName);
            }
            catch (Exception)
            {
                return UpdateResult.Failure;
            }

            return UpdateResult.Success;
        }
    }
}