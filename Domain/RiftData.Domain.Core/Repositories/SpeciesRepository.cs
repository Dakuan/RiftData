using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Domain.Services;
using RiftData.Infrastructure.Data;
using Species = RiftData.Domain.Entities.Species;

namespace RiftData.Domain.Repositories
{
    public class SpeciesRepository : RepositoryBase<Species, RiftData.Infrastructure.Data.Species>, ISpeciesRepository
    {
        private ISpeciesFactory speciesFactory;

        private IGenusFactory genusFactory;

        public SpeciesRepository(ISpeciesFactory speciesFactory, IGenusFactory genusFactory, RiftDataDataEntities dataEntities) : base(dataEntities)
        {
            this.speciesFactory = speciesFactory;

            this.genusFactory = genusFactory;
        }

        public IQueryable<Species> List
        {
            get
            {
                var unsortedList = new List<Species>();

                this.dataEntities.Species.ToList()
                    .ForEach(s =>
                                 {
                                     var species = this.BuildUp(s);

                                     if (species != null) unsortedList.Add(species);
                                 });

                return Sort(unsortedList).AsQueryable();
            }
        }

        public int FindSpeciesIdFromFullName(string speciesFullName)
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

            return this.dataEntities.Fish.Where(s => string.Equals(s.Species1.SpeciesName.Trim(), speciesName) && string.Equals(s.Genus1.GenusName.Trim(), genusName)).First().Species;
        }

        public Species GetSpeciesFromId(int speciesId)
        {
            return this.BuildUp(this.dataEntities.Species.First(s => s.SpeciesID == speciesId));
        }

        protected override Species BuildUp (RiftData.Infrastructure.Data.Species dataSpecies)
        {
            try
            {
                var genus = this.genusFactory.Build(dataSpecies.Genu, this.dataEntities);

                var hasFish = this.dataEntities.Fish.Any(f => f.Species == dataSpecies.SpeciesID);

                var hasPhotos = SpeciesService.SpeciesHasPhoto(this.dataEntities, dataSpecies.SpeciesID);

                var species = this.speciesFactory.Build(dataSpecies, genus, hasPhotos);

                return species;
            }
            catch (Exception)
            {
                
                //todo: Log bad data

                return null;
            }
        }

        protected override IEnumerable<Species> Sort (IEnumerable<Species> unsortedList)
        {
            var sortedList = new List<Species>();

            sortedList.OrderBy(y => y.Genus.Name)
                .GroupBy(z => z.Genus.Name).ToList()
                .ForEach(subG => subG.OrderBy(x => x.Name).ToList()
                .ForEach(sortedList.Add));

            return sortedList;
        }
    }
}