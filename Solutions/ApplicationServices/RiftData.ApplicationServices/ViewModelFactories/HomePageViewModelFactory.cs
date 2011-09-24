namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        public HomePageViewModelFactory(IGenusPanelViewModelFactory genusPanelViewModelFactory, IHeaderViewModelFactory headerViewModelFactory, IGenusTypeRepository genusTypeRepository)
        {
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this.genusTypeRepository.GetByName(genusTypeName);

            var genusPanelViewModel = this.genusPanelViewModelFactory.Build(genusType.Id);

            var headerViewModel = this.headerViewModelFactory.Build(genusType);

            return new HomePageViewModel { GenusPanelViewModel = genusPanelViewModel, GenusType = DtoFactory.Build(genusType), HeaderViewModel = headerViewModel, Keywords = "Lake " + genusType.Lake.Name + ", " + genusType.Name + ", " + string.Join(@", ", genusType.Genus.Select(x => x.Name)), Description = string.Format("Information about Lake Malawi's {0} cichlids", genusType.Name) };
        }
    }
}