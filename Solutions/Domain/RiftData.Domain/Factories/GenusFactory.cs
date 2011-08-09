using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Exceptions;
using RiftData.Domain.Services;
using RiftData.Infrastructure.Data;
using Genus = RiftData.Domain.Entities.Genus;
using Species = RiftData.Domain.Entities.Species;

namespace RiftData.Domain.Factories
{
    public class GenusFactory : IGenusFactory
    {
        private readonly ISpeciesFactory speciesFactory;

        private IGenusTypeFactory genusTypeFactory;
        private readonly IHasPhotoService _hasPhotoService;

        public GenusFactory(ISpeciesFactory speciesFactory, IGenusTypeFactory genusTypeFactory, IHasPhotoService hasPhotoService)
        {
            this.speciesFactory = speciesFactory;

            this.genusTypeFactory = genusTypeFactory;
            _hasPhotoService = hasPhotoService;
        }

        public Genus Build(Infrastructure.Data.Genus dataGenus, RiftDataDataEntities dataEntities)
        {
            var speciesList = new List<Species>();

            var genus = new Genus(dataGenus.GenusID) { Name = dataGenus.GenusName.Trim(), GenusType = this.genusTypeFactory.Build(dataGenus.Type)};
            
            dataGenus.Species.ToList().Where(s => s.Genus == dataGenus.GenusID).ToList()
                                                    .ForEach(s => speciesList.Add(this.speciesFactory.Build(s, genus, _hasPhotoService.SpeciesHasPhoto(s.SpeciesID))));

            if (speciesList.Count < 1)
            {
                throw new EmptySpeciesListException();
            }

            genus.HasFish = dataGenus.Fish.Count > 0;

            genus.Species = speciesList.OrderBy(s => s.Name).ToList();

            return genus;
        }
    }
}