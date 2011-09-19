using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class FishEditPageViewModelFactory : IFishEditPageViewModelFactory
    {
        private readonly IFishRepository _fishRepository;
        private readonly ILocalesRepository _localesRepository;
        private readonly IGenusRepository _genusRepository;
        private readonly ISpeciesRepository _speciesRepository;

        public FishEditPageViewModelFactory(IFishRepository fishRepository, ILocalesRepository localesRepository, IGenusRepository genusRepository, ISpeciesRepository speciesRepository)
        {
            _fishRepository = fishRepository;
            _localesRepository = localesRepository;
            _genusRepository = genusRepository;
            _speciesRepository = speciesRepository;
        }

        public FishEditPageViewModel Build(int fishId, bool? showSuccessMessage)
        {
            if (fishId == 0)
            {
                var genuslist = this._genusRepository.GetAll();
                var speciesList = this._speciesRepository.GetSpeciesWithGenus(genuslist[0].Id);
                return new FishEditPageViewModel(fishId)
                {
                    Locales = new SelectList(this._localesRepository.GetAll(), "Id", "Name"),
                    Genus = new SelectList(genuslist, "Id", "Name"),
                    Species = new SelectList(speciesList, "Id", "Name"),
                    //Description = HttpUtility.HtmlDecode(fish.Description),
                    MessageBoxVisible = showSuccessMessage != null ? true : false,
                    MessageBoxContentSource = Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial"
                };
            }

            var fish = _fishRepository.GetFish(fishId);

            var viewModel = new FishEditPageViewModel(fishId)
            {
                Locales = new SelectList(this._localesRepository.GetAll(), "Id", "Name", fish.Locale.Id),
                Genus = new SelectList(this._genusRepository.GetAll(), "Id", "Name", fish.Genus.Id),
                Species = new SelectList(this._speciesRepository.GetSpeciesWithGenus(fish.Genus.Id), "Id", "Name", fish.Species.Id),
                Name = fish.Name,
                Photos = fish.Photos.ToList().ToDtoList(),
                Description = HttpUtility.HtmlDecode(fish.Description),
                MessageBoxVisible = showSuccessMessage != null ? true : false,
                MessageBoxContentSource = Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial"
            };

            return viewModel;
        }
    }
}