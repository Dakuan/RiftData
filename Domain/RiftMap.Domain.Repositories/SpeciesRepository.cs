using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories;
using RiftMap.Domain.Repositories;
using Species = RiftData.Domain.Core.Species;

namespace RiftData.Domain.Repositories
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

                this.dataEntities.Species.OrderBy(y => y.Genu.GenusName)
                    .GroupBy(z => z.Genu.GenusName).ToList()
                    .ForEach(subG => subG.OrderBy(x => x.SpeciesName).ToList().ForEach(s =>
                {
                    try
                    {
                        var genus = this.genusFactory.Build(s.Genu);

                        var species = this.speciesFactory.Build(s, genus);

                        list.Add(species);
                    }
                    catch (Exception)
                    {
                        //todo, log bad data
                    }
                }));
                return list.AsQueryable();
            }
        }
    }
}
