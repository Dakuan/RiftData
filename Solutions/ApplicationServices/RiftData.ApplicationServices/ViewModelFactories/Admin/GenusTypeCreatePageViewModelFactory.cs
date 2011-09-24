using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
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