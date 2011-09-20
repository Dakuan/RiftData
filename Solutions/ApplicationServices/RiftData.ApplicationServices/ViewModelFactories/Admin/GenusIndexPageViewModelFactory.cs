namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusPages;
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