using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeDtoService _genusTypeDtoService;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly IHeaderViewModelFactory _headerViewModelFactory;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public HomePageViewModelFactory(IGenusTypeDtoService genusTypeDtoService, IGenusPanelViewModelFactory genusPanelViewModelFactory, IHeaderViewModelFactory headerViewModelFactory, IGenusTypeRepository genusTypeRepository)
        {
            _genusTypeDtoService = genusTypeDtoService;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _headerViewModelFactory = headerViewModelFactory;
            _genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this._genusTypeRepository.GetGenusTypeByName(genusTypeName);

            var genusPanelViewModel = this._genusPanelViewModelFactory.Build(genusType.Id);

            var headerViewModel = this._headerViewModelFactory.Build(genusType);

            return new HomePageViewModel 
                { 
                    GenusPanelViewModel = genusPanelViewModel,
                    GenusType = this._genusTypeDtoService.GetGenusTypeDto(genusType.Id),
                    HeaderViewModel = headerViewModel
                };
        }
    }
}