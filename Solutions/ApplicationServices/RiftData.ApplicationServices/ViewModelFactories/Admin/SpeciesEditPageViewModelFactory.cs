namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class SpeciesEditPageViewModelFactory : ISpeciesEditPageViewModelFactory
    {
        private readonly IGenusRepository _genusRepository;

        private readonly ISpeciesRepository _speciesRepository;

        private readonly ITemperamentRepository _temperamentRepository;

        public SpeciesEditPageViewModelFactory(
            ISpeciesRepository speciesRepository, 
            IGenusRepository genusRepository, 
            ITemperamentRepository temperamentRepository)
        {
            this._speciesRepository = speciesRepository;
            this._genusRepository = genusRepository;
            this._temperamentRepository = temperamentRepository;
        }

        public SpeciesEditPageViewModel Build(int speciesId)
        {
            var species = this._speciesRepository.GetSpeciesFromId(speciesId);

            var viewModel = new SpeciesEditPageViewModel
                {
                    Described = species.Described, 
                    Description = species.Description, 
                    Mode = "Update", 
                    Name = species.Name, 
                    MaxSize = species.MaxSize, 
                    MinSize = species.MinSize, 
                    Temperament = this._temperamentRepository.GetAll().ToSelectList(species.Temperament.Id), 
                    Genus = this._genusRepository.GetOfType(species.Genus.GenusType.Id).ToSelectList(species.Genus.Id)
                };

            return viewModel;
        }

        public SpeciesEditPageViewModel Build()
        {
            return new SpeciesEditPageViewModel
                {
                    Temperament = this._temperamentRepository.GetAll().ToSelectList("select a temperament"), 
                    Genus = this._genusRepository.GetAll().ToSelectList("select a genus"), 
                    Mode = "Create"
                };
        }
    }
}