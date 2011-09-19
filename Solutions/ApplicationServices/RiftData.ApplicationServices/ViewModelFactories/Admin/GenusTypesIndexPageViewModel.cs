namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypeIndexPageViewModelFactory : IGenusTypeIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository _genusTypeRepository;

        public GenusTypeIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this._genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeIndexPageViewModel Build()
        {
            var viewModel = new GenusTypeIndexPageViewModel
                {
                   GenusTypes = this._genusTypeRepository.GetAll().ToList().ToDtoList() 
                };

            return viewModel;
        }
    }
}