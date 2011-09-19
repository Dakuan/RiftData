namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IGenusTypeDtoService genusTypeDtoService;

        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        public HomePageViewModelFactory(
            IGenusTypeDtoService genusTypeDtoService, 
            IGenusPanelViewModelFactory genusPanelViewModelFactory, 
            IHeaderViewModelFactory headerViewModelFactory, 
            IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeDtoService = genusTypeDtoService;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this.genusTypeRepository.GetByName(genusTypeName);

            var genusPanelViewModel = this.genusPanelViewModelFactory.Build(genusType.Id);

            var headerViewModel = this.headerViewModelFactory.Build(genusType);

            return new HomePageViewModel
                {
                    GenusPanelViewModel = genusPanelViewModel, 
                    GenusType = this.genusTypeDtoService.GetGenusTypeDto(genusType.Id), 
                    HeaderViewModel = headerViewModel
                };
        }
    }
}