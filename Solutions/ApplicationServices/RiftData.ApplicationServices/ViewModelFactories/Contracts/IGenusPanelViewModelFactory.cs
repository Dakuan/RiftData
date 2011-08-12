using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface IGenusPanelViewModelFactory
    {
        GenusPanelViewModel Build (int genusTypeId);

        GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpeciesId);

        GenusPanelViewModel Build();
    }
}