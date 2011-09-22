using RiftData.Presentation.ViewModels.Mobile;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Mobile
{
    public interface ISpeciesPhotosPageViewModelFactory
    {
        SpeciesPhotosPageViewModel Build(string speciesName);
    }
}