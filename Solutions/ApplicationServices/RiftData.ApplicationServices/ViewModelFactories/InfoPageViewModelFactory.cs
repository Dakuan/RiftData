namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class InfoPageViewModelFactory : IInfoPageViewModelFactory
    {
        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        public InfoPageViewModelFactory(IHeaderViewModelFactory headerViewModelFactory)
        {
            this._headerViewModelFactory = headerViewModelFactory;
        }

        public InfoPageViewModel Build()
        {
            var viewModel = new InfoPageViewModel { HeaderViewModel = this._headerViewModelFactory.Build() };

            return viewModel;
        }
    }
}