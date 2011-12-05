using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.Contracts.ViewModelFactories;
using RiftData.Presentation.ViewModels;

using System.Linq;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HelpPageViewModelFactory : IHelpPageViewModelFactory
    {
        private readonly IHeaderViewModelFactory _headerViewModelFactory;
        private readonly IFishRepository _fishRepository;
        private readonly ISpeciesRepository _speciesRepository;

        public HelpPageViewModelFactory(IHeaderViewModelFactory headerViewModelFactory, IFishRepository fishRepository, ISpeciesRepository speciesRepository)
        {
            _headerViewModelFactory = headerViewModelFactory;
            _fishRepository = fishRepository;
            _speciesRepository = speciesRepository;
        }

        public HelpPageViewModel Build()
        {
            var viewModel = new HelpPageViewModel
                                {
                                    HeaderViewModel = this._headerViewModelFactory.Build(),
                                    FishRequiringPhotos = this._fishRepository.GetWithoutPhotos().ToDtoList().GroupBy(x => x.Locale.Lake.Id),
                                    SpeciesRequiringLocales = _speciesRepository.GetWithoutLocales().GroupBy(x => x.Genus.GenusType.Lake.Id).ToList().Select(x => x.ToDtoList())
                                };

            return viewModel;
        }
    }
}
