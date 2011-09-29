using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System;
    using System.Linq;
    using System.Web;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class FishEditPageViewModelFactory : IFishEditPageViewModelFactory
    {
        private readonly IFishRepository fishRepository;

        private readonly IGenusRepository genusRepository;

        private readonly ILocalesRepository localesRepository;

        private readonly ISpeciesRepository speciesRepository;

        public FishEditPageViewModelFactory(IFishRepository fishRepository, ILocalesRepository localesRepository, IGenusRepository genusRepository, ISpeciesRepository speciesRepository)
        {
            this.fishRepository = fishRepository;
            this.localesRepository = localesRepository;
            this.genusRepository = genusRepository;
            this.speciesRepository = speciesRepository;
        }

        public FishEditPageViewModel Build(int fishId, bool? showSuccessMessage)
        {
            if (fishId == 0)
            {
                var genuslist = this.genusRepository.GetAll();
                var speciesList = this.speciesRepository.GetSpeciesWithGenus(genuslist[0].Id);
                return new FishEditPageViewModel(fishId) { Locales = this.localesRepository.GetAll().ToList().ToSelectList("select a locale"), Genus = genuslist.ToSelectList("select a genus"), Species = speciesList.ToSelectList("select a species"), MessageBoxVisible = showSuccessMessage != null ? true : false, MessageBoxContentSource = Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial" };
            }

            var fish = this.fishRepository.GetFish(fishId);

            var viewModel = new FishEditPageViewModel(fishId) { Locales = this.localesRepository.GetByLake(fish.Genus.GenusType.Lake.Id).ToSelectList(fish.Locale.Id), Genus = this.genusRepository.GetAll().ToSelectList(fish.Genus.Id), Species = this.speciesRepository.GetSpeciesWithGenus(fish.Genus.Id).ToSelectList(fish.Species.Id), Name = fish.Name, Photos = fish.Photos.ToList().ToDtoList(), Description = HttpUtility.HtmlDecode(fish.Description), MessageBoxVisible = showSuccessMessage != null ? true : false, MessageBoxContentSource = Convert.ToBoolean(showSuccessMessage) ? "UpdateSuccessPartial" : "UpdateFailurePartial" };

            return viewModel;
        }
    }
}