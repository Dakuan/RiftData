using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Web;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin.Lake;

    public class LakeUpdatePageViewModelFactory : ILakeUpdatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public LakeUpdatePageViewModelFactory(ILakeRepository lakeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.lakeRepository = lakeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public LakeUpdatePageViewModel Build(int lakeId)
        {
            var lake = this.lakeRepository.Get(lakeId);

            return new LakeUpdatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Lake), Description = HttpUtility.HtmlDecode(lake.Description), Id = lake.Id, Name = lake.Name };
        }
    }
}