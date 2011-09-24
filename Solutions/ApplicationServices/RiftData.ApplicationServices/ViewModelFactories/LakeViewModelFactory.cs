using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LakeViewModelFactory : ILakeViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        public LakeViewModelFactory(ILakeRepository lakeRepository, IHeaderViewModelFactory headerViewModelFactory, ILocalesRepository localesRepository)
        {
            this.lakeRepository = lakeRepository;
            this.headerViewModelFactory = headerViewModelFactory;
            this.localesRepository = localesRepository;
        }

        public LakeViewModel Build(string lakeName)
        {
            var lake = this.lakeRepository.GetFromName(lakeName);

            var locales = this.localesRepository.GetByLake(lake.Id);

            var viewModel = new LakeViewModel
                {
                    Lake = DtoFactory.Build(lake), 
                    HeaderViewModel = this.headerViewModelFactory.Build(lake),
                    Locales = locales.ToDtoList(),
                    Description = string.Format("Information and map for Lake {0}", lake.Name), 
                    Keywords = string.Format("Lake {0}, {1}", lake.Name, string.Join(", ", lake.GenusTypes.ToList().Select(x => x.Name)))
                };

            return viewModel;
        }
    }
}