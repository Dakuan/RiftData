using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private IGenusTypeRepository genusTypeRepository;

        public HomePageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build()
        {
            var genusTypes = this.genusTypeRepository.GetGenusTypesContainingGenus();

            return new HomePageViewModel { GenusTypes = genusTypes };
        }
    }
}
