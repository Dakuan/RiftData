namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusPages;
    using RiftData.Presentation.ViewModels.Admin.Genus;

    public class GenusCreatePageViewModelFactory : IGenusCreatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;

        public GenusCreatePageViewModelFactory(ILakeRepository lakeRepository)
        {
            this.lakeRepository = lakeRepository;
        }

        public GenusCreatePageViewModel Build()
        {
            var viewModel = new GenusCreatePageViewModel { Lakes = this.lakeRepository.GetAllWithGenusTypes().ToSelectList("Select a lake") };

            return viewModel;
        }
    }
}