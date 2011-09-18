using System.Web.Mvc;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class SpeciesEditPageViewModelFactory : ISpeciesEditPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IGenusRepository _genusRepository;
        private readonly ITemperamentRepository _temperamentRepository;

        public SpeciesEditPageViewModelFactory(ISpeciesRepository speciesRepository, IGenusRepository genusRepository, ITemperamentRepository temperamentRepository)
        {
            _speciesRepository = speciesRepository;
            _genusRepository = genusRepository;
            _temperamentRepository = temperamentRepository;
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
                                    Temperament = new SelectList(this._temperamentRepository.GetAll(), "Id", "Name", species.Temperament.Id),
                                    Genus = new SelectList(this._genusRepository.GetGenusOfType(species.Genus.GenusType.Id), "Id", "Name", species.Genus.Id)
                                };

            return viewModel;
        }

        public SpeciesEditPageViewModel Build()
        {
            return new SpeciesEditPageViewModel
                       {
                           Temperament = new SelectList(this._temperamentRepository.GetAll(), "Id", "Name"),
                           Genus = new SelectList(this._genusRepository.GetAllGenus(), "Id", "Name"), 
                           Mode = "Create"
                       };
        }
    }
}