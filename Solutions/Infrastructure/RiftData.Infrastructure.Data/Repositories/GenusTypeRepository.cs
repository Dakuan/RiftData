using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class GenusTypeRepository : IGenusTypeRepository
    {
        private readonly RiftDataDataContext dataContext;

        public GenusTypeRepository(RiftDataDataContext dataContext)
        {
           this.dataContext = dataContext;
        }

        public IList<GenusType> GetGenusTypesContainingGenus()
        {
            return this.dataContext.GenusTypes.Where(t => t.Genus.Count > 0).ToList();
        }

        public GenusType GetGenusTypeByName(string genusTypeName)
        {
            return this.dataContext.GenusTypes.Where(t => string.Equals(genusTypeName, t.Name)).First();
        }

        public IList<GenusType> GetAll()
        {
            return this.dataContext.GenusTypes.ToList();
        }

        public GenusType GetGenusType(int genusTypeId)
        {
            return this.dataContext.GenusTypes.First(g => g.Id == genusTypeId);
        }

        public GenusType GetFromSpecies(int speciesId)
        {
            return this.dataContext.GenusTypes.First(t => t.Genus.Any(g => g.Species.Any(s => s.Id == speciesId)));
        }

        public UpdateResult Update(int genusTypeId, string name, int lakeId)
        {
            try
            {
                var genusType = this.GetGenusType(genusTypeId);

                var lake = this.dataContext.Lakes.First(l => l.Id == lakeId);

                genusType.Name = name;

                genusType.Lake = lake;

                dataContext.SaveChanges();
            }

            catch (Exception)
            {
                return UpdateResult.Failure;
            }

            return UpdateResult.Success;
        }

        public DeleteResult Delete(int genusTypeId)
        {
            try
            {
                var genusType = this.GetGenusType(genusTypeId);

                if (genusType == null) return DeleteResult.DoesNotExist;

                this.dataContext.GenusTypes.Remove(genusType);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return DeleteResult.Failure;
            }

            return DeleteResult.Success;
        }

        public AddResult Add(string name, int lakeId)
        {
            if (this.dataContext.GenusTypes.Any(g => g.Name == name)) return AddResult.AlreadyExists;

            var lake = this.dataContext.Lakes.First(l => l.Id == lakeId);

            var genusType = new GenusType
            {
                Name = name,
                Lake = lake
            };
            try
            {
                this.dataContext.GenusTypes.Add(genusType);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return AddResult.Failure;
            }

            return AddResult.Success;
        }
    }
}