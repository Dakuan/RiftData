using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories;
using Species = RiftData.Domain.Core.Species;

namespace RiftMap.Domain.Repositories
{
    public class SpeciesRepository : IRepository<Species>
    {
        private ISpeciesFactory speciesFactory;

        private IGenusFactory genusFactory;

        private RiftDataDataEntities dataEntities;

        public SpeciesRepository(ISpeciesFactory speciesFactory, IGenusFactory genusFactory, RiftDataDataEntities dataEntities)
        {
            this.dataEntities = dataEntities;

            this.speciesFactory = speciesFactory;

            this.genusFactory = genusFactory;
        }

        public IQueryable<Species> List
        {
            get
            {
                var list = new List<Species>();

                this.dataEntities.Species.ToList().ForEach(s =>
                {
                    try
                    {
                        var genus = this.genusFactory.Build(s.Genus);

                        var species = this.speciesFactory.Build(s.SpeciesID, genus);

                        list.Add(species);
                    }
                    catch (Exception)
                    {
                        //todo, log bad data
                    }
                });

                return list.AsQueryable();
            }
        }
    }
}
