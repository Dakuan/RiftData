using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    using System.Collections.Generic;
    using System.Linq;

    using Castle.Core;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        private readonly IPhotosRepository photosRepository;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository, IPhotosRepository photosRepository)
        {
            this.genusRepository = genusRepository;
            this.photosRepository = photosRepository;
        }

        public GenusIndexPageViewModel Build(string genusName)
        {
            var genus = this.genusRepository.GetByName(genusName);

            var dictionary = new Dictionary<SpeciesDto, PhotoDto>();

            genus.Species.SortSpecies().ToDtoList().ForEach(s =>
                {
                    var photo = this.photosRepository.GetSingleForSpecies(s.Id);

                    if (photo == null)
                    {
                        dictionary.Add(s, null);
                    }
                    else
                    {
                        dictionary.Add(s, DtoFactory.Build(photo));
                    }
                });

            var viewModel = new GenusIndexPageViewModel
                                {
                                    Header = genus.Name,
                                    MetaData = MetaData.Build(string.Empty, genus.Name, string.Empty),
                                    SpeciesList = dictionary
                                };

            return viewModel;
        }
    }
}