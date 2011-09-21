namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LakePages;
    using RiftData.Presentation.ViewModels.Admin.Lake;

    public class LakeIndexPageViewModelFactory : ILakeIndexPageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;

        public LakeIndexPageViewModelFactory(ILakeRepository lakeRepository)
        {
            this.lakeRepository = lakeRepository;
        }

        public LakeIndexPageViewModel Build()
        {
            var viewModel = new LakeIndexPageViewModel { Lakes = this.lakeRepository.GetAll().ToDtoList() };

            return viewModel;
        }
    }
}