using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeDtoService _genusTypeDtoService;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        public HomePageViewModelFactory(IGenusTypeDtoService genusTypeDtoService, IGenusPanelViewModelFactory genusPanelViewModelFactory)
        {
            _genusTypeDtoService = genusTypeDtoService;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this._genusTypeDtoService.GetGenusTypeByName(genusTypeName);

            var genusTypes = this._genusTypeDtoService.GetGenusTypesThatContainGenus();

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