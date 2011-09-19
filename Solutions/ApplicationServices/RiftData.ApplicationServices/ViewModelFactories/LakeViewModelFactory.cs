namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LakeViewModelFactory : ILakeViewModelFactory
    {
        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        private readonly ILakeDtoService _lakeDtoService;

        public LakeViewModelFactory(ILakeDtoService lakeDtoService, IHeaderViewModelFactory headerViewModelFactory)
        {
            this._lakeDtoService = lakeDtoService;
            this._headerViewModelFactory = headerViewModelFactory;
        }

        public LakeViewModel Build(string lakeName)
        {
            var lake = this._lakeDtoService.GetLakeFromName(lakeName);

            var viewModel = new LakeViewModel
                {
                   Lake = lake, HeaderViewModel = this._headerViewModelFactory.Build(lake),
                   Description = string.Format("Information and map for Lake {0}", lake.Name),
                   Keywords = string.Format("Lake {0}, {1}", lake.Name, string.Join(", ", lake.GenusTypes.Select(x => x.Name)))
                };

            return viewModel;
        }
    }
}