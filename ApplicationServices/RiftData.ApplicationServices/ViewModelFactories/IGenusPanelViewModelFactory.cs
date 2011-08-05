using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public interface IGenusPanelViewModelFactory
    {
        GenusPanelViewModel Build (int genusTypeId);
        GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpeciesId);
    }
}