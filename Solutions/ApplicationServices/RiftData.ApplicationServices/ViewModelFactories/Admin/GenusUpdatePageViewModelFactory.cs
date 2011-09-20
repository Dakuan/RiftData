namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.GenusPages;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusUpdatePageViewModelFactory : IGenusUpdatePageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        public GenusUpdatePageViewModelFactory(IGenusRepository genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusUpdatePageViewModel Build(int genusId)
        {
            var genus = this.genusRepository.Get(genusId);

            var viewModel = new GenusUpdatePageViewModel { Id = genusId, Name = genus.Name };

            return viewModel;
        }
    }
}