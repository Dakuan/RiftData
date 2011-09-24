using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Genus;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusIndexPageViewModel Builld()
        {
            var viewModel = new GenusIndexPageViewModel { Genus = this.genusRepository.GetAll().ToList().ToDtoList() };

            return viewModel;
        }
    }
}