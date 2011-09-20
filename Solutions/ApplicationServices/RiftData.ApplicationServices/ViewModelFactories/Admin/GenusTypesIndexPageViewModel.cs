namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusTypePages;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypeIndexPageViewModelFactory : IGenusTypeIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        public GenusTypeIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeIndexPageViewModel Build()
        {
            var viewModel = new GenusTypeIndexPageViewModel
                {
                   GenusTypes = this.genusTypeRepository.GetAll().ToList().ToDtoList() 
                };

            return viewModel;
        }
    }
}