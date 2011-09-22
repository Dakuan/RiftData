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

    public class GenusRepository : IGenusRepository
    {
        private readonly RiftDataDataContext dataContext;

        private readonly ILogger logger;

        public GenusRepository(RiftDataDataContext dataContext, ILogger logger)
        {
            this.dataContext = dataContext;
            this.logger = logger;
        }

        public AddResult Add(string name, int genusTypeId, string userName)
        {
            var genusType = this.dataContext.GenusTypes.First(t => t.Id == genusTypeId);

            if (this.dataContext.Genus.Any(g => g.Name == name))
            {
                return AddResult.AlreadyExists;
            }

            this.dataContext.Genus.Add(new Genus { Name = name, GenusType = genusType });

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception ex)
            {
                return AddResult.Failure;
            }

            this.logger.LogAdd(genusType, userName);

            return AddResult.Success;
        }

        public DeleteResult Delete(int genusId)
        {
            try
            {
                var genus = this.dataContext.Genus.First(g => g.Id == genusId);

                this.dataContext.Genus.Remove(genus);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public Genus Get(int genusId)
        {
            return this.dataContext.Genus.FirstOrDefault(g => g.Id == genusId);
        }

        public IList<Genus> GetAll()
        {
            return this.dataContext.Genus.SortGenus().ToList();
        }

        public IList<Genus> GetOfIdWithFish(int genusTypeId)
        {
            var list = this.dataContext.Genus.Where(g => g.GenusType.Id == genusTypeId && this.dataContext.Fish.Any(f => f.Genus.Id == g.Id));

            return list.SortGenus().ToList();
        }

        public IList<Genus> GetOfType(int genusTypeId)
        {
            return this.dataContext.Genus.Where(g => g.GenusType.Id == genusTypeId).ToList();
        }

        public UpdateResult Update(int genusId, string userName)
        {
            var genus = this.dataContext.Genus.FirstOrDefault(g => g.Id == genusId);

            genus.Name = userName;

            try
            {
                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return UpdateResult.Failure;
            }

            this.logger.LogUpdate(genus, userName);

            return UpdateResult.Success;
        }
    }
}