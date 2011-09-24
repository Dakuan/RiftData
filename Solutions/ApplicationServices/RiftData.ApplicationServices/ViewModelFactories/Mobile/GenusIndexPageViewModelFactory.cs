using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    using System.Linq;

    using System.Collections.Generic;
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

                                                                    dictionary.Add(s, photo == null ? null : DtoFactory.Build(photo));
                                                                });

            var viewModel = new GenusIndexPageViewModel
                                {
                                    Header = genus.Name,
                                    MetaData = MetaData.Build(string.Join(",", genus.Species.Select(x => x.Name)), genus.Name, string.Format("Information about {0}", genus.Name)),
                                    SpeciesList = dictionary
                                };

            return viewModel;
        }
    }
}