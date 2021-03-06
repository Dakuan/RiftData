﻿using RiftData.Domain.Exceptions;

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

    public class SpeciesRepository : ISpeciesRepository
    {
        private readonly RiftDataDataContext dataContext;

        private readonly ILogger logger;

        public SpeciesRepository(RiftDataDataContext dataContext, ILogger logger)
        {
            this.dataContext = dataContext;
            this.logger = logger;
        }

        public Species Add(string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName)
        {
            
            var genus = this.dataContext.Genus.FirstOrDefault(g => g.Id == genusId);

            if (genus == null)
            {
                throw new ItemDoesNotExistException();
            }

            if (temperamentId == 0)
            {
                temperamentId = 1;
            }

            var temperament = this.dataContext.Temperaments.FirstOrDefault(t => t.Id == temperamentId);

            if(temperament == null)
            {
                throw new ItemDoesNotExistException();
            }

            var species = new Species { Described = described, Genus = genus, Name = name.Trim(), Description = description, MinSize = minSize, MaxSize = maxSize, Temperament = temperament };

            species = this.dataContext.Species.Add(species);

            this.dataContext.SaveChanges();

            return species;
        }

        public DeleteResult Delete(int speciesId)
        {
            var species = this.dataContext.Species.First(s => s.Id == speciesId);

            this.dataContext.Species.Remove(species);

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

        public IList<Species> GetAll()
        {
            return this.dataContext.Species.SortSpecies().ToList();
        }

        public IList<Species> GetSpeciesAtLocale(int id)
        {
            var species = new List<Species>();

            this.dataContext.Fish.Where(f => f.Locale.Id == id).ToList().ForEach(f => species.Add(f.Species));

            return species.SortSpecies().ToList();
        }

        public Species GetSpeciesFromFullName(string speciesFullName)
        {
            var components = speciesFullName.Split('_');

            var genusName = components[0].Trim();

            string speciesName;

            var described = !string.Equals(components[1], "sp");

            if (described)
            {
                speciesName = components[1];
            }
            else
            {
                speciesName = components[2].Trim();
            }

            var species = this.dataContext.Species;
            var matchingSpecies = species.Where(s => string.Equals(s.Name.Trim(), speciesName) && string.Equals(s.Genus.Name.Trim(), genusName));
            var firstMatch = matchingSpecies.First();

            return firstMatch;
        }

        public Species GetSpeciesFromId(int speciesId)
        {
            return this.dataContext.Species.First(s => s.Id == speciesId);
        }

        public IList<Species> GetSpeciesWithGenus(int id)
        {
            return this.dataContext.Species.Where(s => s.Genus.Id == id).ToList().SortSpecies().ToList();
        }

        public UpdateResult Update(int speciesId, string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId, string userName)
        {
            var species = this.dataContext.Species.FirstOrDefault(s => s.Id == speciesId);

            if (species == null)
            {
                return UpdateResult.DoesNotExist;
            }

            var genus = this.dataContext.Genus.FirstOrDefault(g => g.Id == genusId);

            var temperament = this.dataContext.Temperaments.First(t => t.Id == temperamentId);

            species.Genus = genus;

            species.Described = described;

            species.Description = description;

            species.Name = name.Trim();

            species.MinSize = minSize;

            species.MaxSize = maxSize;

            species.Temperament = temperament;

            try
            {
                this.dataContext.SaveChanges();
            }
            catch
            {
                return UpdateResult.Failure;
            }

            this.logger.LogUpdate(species, userName);

            return UpdateResult.Success;
        }

        public IList<Species> GetWithoutLocales()
        {
            return this.dataContext.Species.Where(s => !this.dataContext.Fish.Any(f => f.Species.Id == s.Id)).ToList();
        }
    }
}