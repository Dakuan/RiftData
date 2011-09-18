using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface ISpeciesEditPageViewModelFactory
    {
        SpeciesEditPageViewModel Build(int speciesId);

        SpeciesEditPageViewModel Build();
    }
}