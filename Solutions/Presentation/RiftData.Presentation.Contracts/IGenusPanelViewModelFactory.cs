using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface IGenusPanelViewModelFactory
    {
        GenusPanelViewModel Build (int genusTypeId);

        GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpeciesId);

        GenusPanelViewModel Build();
    }
}