namespace RiftData.Presentation.Contracts.ViewModelFactories
{
    using RiftData.Domain.Entities;
    using RiftData.Presentation.ViewModels;

    public interface IGenusPanelViewModelFactory
    {
        GenusPanelViewModel Build(int genusTypeId);

        GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpeciesId);

        GenusPanelViewModel Build(Lake lake);
    }
}