namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypeCreatePageViewModelFactory : IGenusTypeCreatePageViewModelFactory
    {
        private readonly ILakeRepository _lakeRepository;

        public GenusTypeCreatePageViewModelFactory(ILakeRepository lakeRepository)
        {
            this._lakeRepository = lakeRepository;
        }

        public GenusTypeCreatePageViewModel Build()
        {
            var lakes = this._lakeRepository.GetAll();

            var viewModel = new GenusTypeCreatePageViewModel { Lakes = lakes.ToSelectList("select a lake") };

            return viewModel;
        }
    }
}