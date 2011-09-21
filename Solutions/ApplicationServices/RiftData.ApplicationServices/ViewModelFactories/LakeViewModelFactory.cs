namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LakeViewModelFactory : ILakeViewModelFactory
    {
        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        private readonly ILakeDtoService lakeDtoService;

        public LakeViewModelFactory(ILakeDtoService lakeDtoService, IHeaderViewModelFactory headerViewModelFactory, ILocalesRepository localesRepository)
        {
            this.lakeDtoService = lakeDtoService;
            this.headerViewModelFactory = headerViewModelFactory;
            this.localesRepository = localesRepository;
        }

        public LakeViewModel Build(string lakeName)
        {
            var lake = this.lakeDtoService.GetLakeFromName(lakeName);

            var locales = this.localesRepository.GetByLake(lake.Id);

            var viewModel = new LakeViewModel
                {
                    Lake = lake, HeaderViewModel = this.headerViewModelFactory.Build(lake),
                    Locales = locales.ToDtoList(),
                    Description = string.Format("Information and map for Lake {0}", lake.Name), 
                    Keywords = string.Format("Lake {0}, {1}", lake.Name, string.Join(", ", lake.GenusTypes.Select(x => x.Name)))
                };

            return viewModel;
        }
    }
}