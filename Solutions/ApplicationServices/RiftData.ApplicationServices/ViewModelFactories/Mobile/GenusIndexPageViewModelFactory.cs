using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusIndexPageViewModel Build(string genusName)
        {
            var genus = this.genusRepository.GetByName(genusName);

            var viewModel = new GenusIndexPageViewModel
                                {
                                    Header = genus.Name,
                                    MetaData = MetaData.Build(string.Empty, genus.Name, string.Empty),
                                    SpeciesList = genus.Species.SortSpecies().ToDtoList()
                                };

            return viewModel;
        }
    }
}