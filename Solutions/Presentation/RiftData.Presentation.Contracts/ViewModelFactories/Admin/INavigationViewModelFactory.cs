using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface INavigationViewModelFactory
    {
        NavigationPartialViewModel Build(SelectedView selectedView);
    }
}