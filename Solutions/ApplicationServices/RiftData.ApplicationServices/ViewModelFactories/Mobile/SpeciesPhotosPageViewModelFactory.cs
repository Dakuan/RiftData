using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    public class SpeciesPhotosPageViewModelFactory : ISpeciesPhotosPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly IPhotosRepository photosRepository;

        public SpeciesPhotosPageViewModelFactory(ISpeciesRepository speciesRepository, IPhotosRepository photosRepository)
        {
            this.speciesRepository = speciesRepository;
            this.photosRepository = photosRepository;
        }

        public SpeciesPhotosPageViewModel Build(string speciesName)
        {
            var species = this.speciesRepository.GetSpeciesFromFullName(speciesName);

            var photos = this.photosRepository.GetForSpecies(species.Id);

            var viewModel = new SpeciesPhotosPageViewModel
                                {
                                    Header = string.Format("RiftData | {0} Photos", species.FullName),
                                    MetaData = MetaData.Build(string.Empty, string.Empty, string.Empty),
                                    Photos = photos.ToDtoList()
                                };

            return viewModel;
        }
    }
}
