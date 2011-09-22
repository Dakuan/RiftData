namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusTypePages;
    using RiftData.Presentation.ViewModels.Admin;
    using RiftData.Presentation.ViewModels.Admin.GenusType;

    public class GenusTypeCreatePageViewModelFactory : IGenusTypeCreatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;

        public GenusTypeCreatePageViewModelFactory(ILakeRepository lakeRepository)
        {
            this.lakeRepository = lakeRepository;
        }

        public GenusTypeCreatePageViewModel Build()
        {
            var lakes = this.lakeRepository.GetAll();

            var viewModel = new GenusTypeCreatePageViewModel { Lakes = lakes.ToSelectList("select a lake") };

            return viewModel;
        }
    }
}