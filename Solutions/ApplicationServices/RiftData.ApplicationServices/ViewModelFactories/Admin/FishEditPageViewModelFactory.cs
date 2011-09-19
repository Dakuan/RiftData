namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System;
    using System.Linq;
    using System.Web;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class FishEditPageViewModelFactory : IFishEditPageViewModelFactory
    {
        private readonly IFishRepository _fishRepository;

        private readonly IGenusRepository _genusRepository;

        private readonly ILocalesRepository _localesRepository;

        private readonly ISpeciesRepository _speciesRepository;

        public FishEditPageViewModelFactory(
            IFishRepository fishRepository, 
            ILocalesRepository localesRepository, 
            IGenusRepository genusRepository, 
            ISpeciesRepository speciesRepository)
        {
            this._fishRepository = fishRepository;
            this._localesRepository = localesRepository;
            this._genusRepository = genusRepository;
            this._speciesRepository = speciesRepository;
        }

        public FishEditPageViewModel Build(int fishId, bool? showSuccessMessage)
        {
            if (fishId == 0)
            {
                var genuslist = this._genusRepository.GetAll();
                var speciesList = this._speciesRepository.GetSpeciesWithGenus(genuslist[0].Id);
                return new FishEditPageViewModel(fishId)
                    {
                        Locales = this._localesRepository.GetAll().ToList().ToSelectList("select a locale"), 
                        Genus = genuslist.ToSelectList("select a genus"), 
                        Species = speciesList.ToSelectList("select a species"), 
                        MessageBoxVisible = showSuccessMessage != null ? true : false, 
                        MessageBoxContentSource =
                            Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial"
                    };
            }

            var fish = this._fishRepository.GetFish(fishId);

            var viewModel = new FishEditPageViewModel(fishId)
                {
                    Locales = this._localesRepository.GetAll().ToSelectList(fish.Locale.Id), 
                    Genus = this._genusRepository.GetAll().ToSelectList(fish.Genus.Id), 
                    Species = this._speciesRepository.GetSpeciesWithGenus(fish.Genus.Id).ToSelectList(fish.Species.Id), 
                    Name = fish.Name, 
                    Photos = fish.Photos.ToList().ToDtoList(), 
                    Description = HttpUtility.HtmlDecode(fish.Description), 
                    MessageBoxVisible = showSuccessMessage != null ? true : false, 
                    MessageBoxContentSource =
                        Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial"
                };

            return viewModel;
        }
    }
}