using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.GenusType;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypesUpdatePageViewModelFactory : IGenusTypesUpdatePageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        private readonly ILakeRepository lakeRepository;

        public GenusTypesUpdatePageViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusTypeUpdatePageViewModel Build(int genusTypeId)
        {
            var genusType = this.genusTypeRepository.Get(genusTypeId);

            var viewModel = new GenusTypeUpdatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.GenusTypes), Lakes = this.lakeRepository.GetAll().ToSelectList(genusType.Lake.Id), GenusType = DtoFactory.Build(genusType) };

            return viewModel;
        }
    }
}