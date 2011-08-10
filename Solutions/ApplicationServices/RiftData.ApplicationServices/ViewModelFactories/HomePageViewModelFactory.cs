using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;
using IGenusTypeRepository = RiftData.ApplicationServices.Repositories.IGenusTypeRepository;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeService _genusTypeService;
        private readonly IGenusTypeRepository _genusTypeRepository;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        public HomePageViewModelFactory(IGenusTypeService genusTypeService, IGenusTypeRepository genusTypeRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory)
        {
            _genusTypeService = genusTypeService;
            _genusTypeRepository = genusTypeRepository;
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