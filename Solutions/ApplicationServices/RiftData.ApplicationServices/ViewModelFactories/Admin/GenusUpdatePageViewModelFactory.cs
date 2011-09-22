namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusPages;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusUpdatePageViewModelFactory : IGenusUpdatePageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        private readonly ILakeRepository lakeRepository;

        public GenusUpdatePageViewModelFactory(IGenusRepository genusRepository, ILakeRepository lakeRepository)
        {
            this.genusRepository = genusRepository;
            this.lakeRepository = lakeRepository;
        }

        public GenusUpdatePageViewModel Build(int genusId)
        {
            var genus = this.genusRepository.Get(genusId);

            var viewModel = new GenusUpdatePageViewModel { Id = genusId, Name = genus.Name,  };

            return viewModel;
        }
    }
}