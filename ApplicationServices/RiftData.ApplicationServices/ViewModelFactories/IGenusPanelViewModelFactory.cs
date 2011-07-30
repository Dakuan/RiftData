using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public interface IGenusPanelViewModelFactory
    {
        GenusPanelViewModel Build (int genusTypeId);
    }
}