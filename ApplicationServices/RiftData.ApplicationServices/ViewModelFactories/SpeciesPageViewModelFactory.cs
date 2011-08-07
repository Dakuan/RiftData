using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IPhotosRepository _photosRepository;
        private readonly IGenusTypeRepository _genusTypeRepository;
        private readonly IFishRepository _fishRepository;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, IPhotosRepository photosRepository, IGenusTypeRepository genusTypeRepository, IFishRepository fishRepository)
        {
            _speciesRepository = speciesRepository;
            _photosRepository = photosRepository;
            _genusTypeRepository = genusTypeRepository;
            _fishRepository = fishRepository;
        }

        public SpeciesPageViewModel Build(string fullName)
        {
            var speciesId = this._speciesRepository.FindSpeciesIdFromFullName(fullName);

            return this.Build(speciesId);
        }

        public SpeciesPageViewModel Build(int speciesId)
        {
            var species = this._speciesRepository.GetSpeciesFromId(speciesId);

            var locales = new List<Locale>();
                
            //this._fishRepository.GetFishBySpecies(speciesId).ToList().ForEach(f =>
            //                                                                      {
            //                                                                          if (!locales.Any(l => l.Id == f.Locale.Id))
            //                                                                              locales.Add(f.Locale);
            //                                                                      });

            var viewModel = new SpeciesPageViewModel
                                {
                                    SpeciesName = species.FullName,
                                    GenusTypes = this._genusTypeRepository.GetGenusTypesContainingGenus(),
                                    SelectedGenusId = species.Genus.Id,
                                    SelectedSpeciesId = species.Id,
                                    SelectedGenusTypeId = species.Genus.GenusType.Id,
                                    Locales = locales,
                                    PhotoGalleryViewModel = new PhotoGalleryViewModel
                                                                {
                                                                    Name = species.FullName,
                                                                    Photos = this._photosRepository.GetPhotosForSpecies(speciesId)                                                               
                                                                }
                                };

            return viewModel;
        }
    }
}
