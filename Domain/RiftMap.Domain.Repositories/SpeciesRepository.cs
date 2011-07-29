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
        private IFactory<Species> speciesFactory;

        private RiftDataDataEntities dataEntities;

        public SpeciesRepository(IFactory<Species> speciesFactory, RiftDataDataEntities dataEntities)
        {
            this.dataEntities = dataEntities;

            this.speciesFactory = speciesFactory;
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
                        var species = this.speciesFactory.Build(s.SpeciesID);

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
