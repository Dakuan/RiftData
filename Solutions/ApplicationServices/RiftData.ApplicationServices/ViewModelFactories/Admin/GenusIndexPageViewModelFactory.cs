namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository _genusRepository;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository)
        {
            this._genusRepository = genusRepository;
        }

        public GenusIndexPageViewModel Builld()
        {
            var viewModel = new GenusIndexPageViewModel { Genus = this._genusRepository.GetAll().ToList().ToDtoList() };

            return viewModel;
        }
    }
}