using System;
using RiftData.Domain.Enums;

namespace RiftData.Infrastructure.Data.Repositories
{
    using System.Collections.Generic;
    using System.Linq;
    using Domain.Entities;
    using Domain.Extensions;
    using Domain.Repositories;

    public class SpeciesRepository : ISpeciesRepository
    {
        private readonly RiftDataDataContext dataContext;

        public SpeciesRepository(RiftDataDataContext dataContext)
        {
            this.dataContext = dataContext;
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

        public IList<Species> GetSpeciesAtLocale(int id)
        {
            var species = new List<Species>();

            this.dataContext.Fish.Where(f => f.Locale.Id == id).ToList().ForEach(f => species.Add(f.Species));

            return species.SortSpecies().ToList();
        }

        public IList<Species> GetSpeciesWithGenus(int id)
        {
            return this.dataContext.Species.Where(s => s.Genus.Id == id).ToList().SortSpecies().ToList();
        }

        public IList<Species> GetAllSpecies()
        {
            return this.dataContext.Species.SortSpecies().ToList();
        }

        public AddResult AddSpecies(string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId)
        {
            var genus = this.dataContext.Genus.First(g => g.Id == genusId);

            var temperament = this.dataContext.Temperaments.First(t => t.Id == temperamentId);

            var species = new Species
            {
                Described = described,
                Genus = genus,
                Name = name,
                Description = description,
                MinSize = minSize,
                MaxSize = maxSize,
                Temperament = temperament
            };

            this.dataContext.Species.Add(species);

            try
            {
                this.dataContext.SaveChanges();

                return AddResult.Success;
            }
            catch (Exception)
            {
                return AddResult.Failure;
            }
        }

        public UpdateResult Update(int speciesId, string name, int genusId, bool described, string description, int minSize, int maxSize, int temperamentId)
        {
            var species = dataContext.Species.FirstOrDefault(s => s.Id == speciesId);

            var genus = dataContext.Genus.FirstOrDefault(g => g.Id == genusId);

            var temperament = this.dataContext.Temperaments.First(t => t.Id == temperamentId);

            species.Genus = genus;

            species.Described = described;

            species.Description = description;

            species.Name = name;

            species.MinSize = minSize;

            species.MaxSize = maxSize;

            species.Temperament = temperament;

            try
            {
                dataContext.SaveChanges();

                return UpdateResult.Success;
            }
            catch
            {
                return UpdateResult.Failure;
            }
        }

        public DeleteResult DeleteSpecies(int speciesId)
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
    }
}