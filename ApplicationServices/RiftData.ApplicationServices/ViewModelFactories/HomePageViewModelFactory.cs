using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeService _genusTypeService;

        public HomePageViewModelFactory(IGenusTypeService genusTypeService)
        {
            _genusTypeService = genusTypeService;
        }

        public HomePageViewModel Build()
        {
            var genusTypes = this._genusTypeService.GetGenusTypesThatContainGenus();

            return new HomePageViewModel { GenusTypes = genusTypes };
        }
    }
}
