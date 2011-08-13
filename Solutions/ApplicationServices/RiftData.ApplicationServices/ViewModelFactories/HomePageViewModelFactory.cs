using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeService _genusTypeService;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        public HomePageViewModelFactory(IGenusTypeService genusTypeService, IGenusPanelViewModelFactory genusPanelViewModelFactory)
        {
            _genusTypeService = genusTypeService;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this._genusTypeService.GetGenusTypeByName(genusTypeName);

            var genusTypes = this._genusTypeService.GetGenusTypesThatContainGenus();

            var genusPanelViewModel = this._genusPanelViewModelFactory.Build(genusType.Id);

            return new HomePageViewModel 
                { 
                    GenusTypes = genusTypes, 
                    SelectedGenusTypeId = genusType.Id, 
                    GenusPanelViewModel = genusPanelViewModel,
                    GenusType = genusType
                };
        }
    }
}