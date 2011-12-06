namespace RiftData.Infrastructure.Data.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Exceptions;
    using RiftData.Domain.Extensions;
    using RiftData.Domain.Repositories;

    public class FishRepository : IFishRepository
    {
        private readonly RiftDataDataContext dataContext;

        public FishRepository(RiftDataDataContext dataContext)
        {
            this.dataContext = dataContext;
        }

        public Fish Add(int genusId, int speciesId, int localeId, string description)
        {
            var genus = this.dataContext.Genus.First(g => g.Id == genusId);

            var species = this.dataContext.Species.First(s => s.Id == speciesId);

            var locale = this.dataContext.Locales.First(l => l.Id == localeId);

            if (this.dataContext.Fish.Any(f => f.Genus.Id == genusId && f.Species.Id == speciesId && f.Locale.Id == localeId))
            {
                throw new ItemExistsException();
            }

            var fish = new Fish { Genus = genus, Species = species, Locale = locale, Description = description };

            fish = this.dataContext.Fish.Add(fish);

            this.dataContext.SaveChanges();

            return fish;
        }

        public Fish GetFish(int fishId)
        {
            return this.dataContext.Fish.First(f => f.Id == fishId);
        }

        public Fish GetFromName(string fishName)
        {
            var components = fishName.Split('_');

            var genusName = components[0];

            var speciesName = components[1];

            var localeName = components[2];

            return this.dataContext.Fish.First(f => f.Genus.Name == genusName && f.Species.Name == speciesName && f.Locale.Name == localeName);
        }

        public IList<Fish> GetByLocale(int localeId)
        {
            return this.dataContext.Fish.Where(f => f.Locale.Id == localeId).SortFish().ToList();
        }

        public IList<Fish> GetBySpecies(int speciesId)
        {
            var list = new List<Fish>();

            this.dataContext.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(list.Add);

            return list.SortFish().ToList();
        }

        public IList<Fish> GetOfType(int genusTypeId)
        {
            return this.dataContext.Fish.Where(f => f.Genus.GenusType.Id == genusTypeId).SortFish().ToList();
        }

        public IList<Fish> GetWithoutPhotos()
        {
            var fish =
                this.dataContext.Fish.Where(f => f.Photos.Count == 0).SortFish().ToList();

            return fish;
        }

        public Fish Update(int fishId, int genusId, int speciesId, int localeId, string description)
        {
            var fish = this.dataContext.Fish.FirstOrDefault(f => f.Id == fishId);

            if (fish != null)
            {
                fish.Genus = this.dataContext.Genus.FirstOrDefault(g => g.Id == genusId);

                fish.Species = this.dataContext.Species.FirstOrDefault(s => s.Id == speciesId);

                fish.Locale = this.dataContext.Locales.FirstOrDefault(l => l.Id == localeId);

                fish.Description = description;

                this.dataContext.SaveChanges();

                return fish;
            }
            throw new ItemDoesNotExistException();
        }

        public DeleteResult Delete(int fishId)
        {
            var fish = this.dataContext.Fish.First(f => f.Id == fishId);

            if (fish == null)
            {
                return DeleteResult.DoesNotExist;
            }

            this.dataContext.Fish.Remove(fish);

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
    }
}