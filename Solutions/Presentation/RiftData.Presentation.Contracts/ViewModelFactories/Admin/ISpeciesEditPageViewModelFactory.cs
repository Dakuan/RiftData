using RiftData.Presentation.ViewModels.Admin.Species;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface ISpeciesEditPageViewModelFactory
    {
        SpeciesEditPageViewModel Build(int speciesId);

        SpeciesEditPageViewModel Build();
    }
}