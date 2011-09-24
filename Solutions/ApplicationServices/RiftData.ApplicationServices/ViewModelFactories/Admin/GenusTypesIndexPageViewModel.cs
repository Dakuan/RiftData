using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.GenusType;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;

    public class GenusTypeIndexPageViewModelFactory : IGenusTypeIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        public GenusTypeIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeIndexPageViewModel Build()
        {
            var viewModel = new GenusTypeIndexPageViewModel { GenusTypes = this.genusTypeRepository.GetAll().ToList().ToDtoList() };

            return viewModel;
        }
    }
}