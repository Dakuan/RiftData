namespace RiftData.ApplicationServices.ViewModelFactories
{
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
                   Lake = lake, HeaderViewModel = this._headerViewModelFactory.Build(lake) 
                };

            return viewModel;
        }
    }
}