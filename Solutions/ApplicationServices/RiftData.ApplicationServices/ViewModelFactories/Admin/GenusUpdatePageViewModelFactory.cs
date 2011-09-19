namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusUpdatePageViewModelFactory : IGenusUpdatePageViewModelFactory
    {
        private readonly IGenusRepository _genusRepository;

        public GenusUpdatePageViewModelFactory(IGenusRepository genusRepository)
        {
            this._genusRepository = genusRepository;
        }

        public GenusUpdatePageViewModel Build(int genusId)
        {
            var genus = this._genusRepository.Get(genusId);

            var viewModel = new GenusUpdatePageViewModel { Id = genusId, Name = genus.Name };

            return viewModel;
        }
    }
}