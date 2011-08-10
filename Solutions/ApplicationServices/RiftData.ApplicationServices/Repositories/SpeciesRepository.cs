using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data;

namespace RiftData.ApplicationServices.Repositories
{
    public class SpeciesRepository : ISpeciesRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public SpeciesRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
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

            return this.dataEntities.Fish.Where(s => string.Equals(s.Species.Name.Trim(), speciesName) && string.Equals(s.Genus.Name.Trim(), genusName)).First().Species.Id;
        }

        public Species GetSpeciesFromId(int speciesId)
        {
            return this.dataEntities.Species.First(s => s.Id == speciesId);
        }

        public IList<Species> GetSpeciesAtLocale(int id)
        {
            var species = new List<Species>();

            /*
            this.dataEntities.Species.Where(s => s.Fish.Any(f => f.Locale == id)).ToList().ForEach(s =>
                                                                    {
                                                                        var genus = this.genusFactory.Build(s.Genu, this.dataEntities);
                                                                        var hasPhotos = _hasPhotoService.SpeciesHasPhoto(s.SpeciesID);
                                                                        species.Add(this.speciesFactory.Build(s, genus, hasPhotos));
                                                                    });
            */
            return species;
        }

        private IEnumerable<Species> Sort (IEnumerable<Species> unsortedList)
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