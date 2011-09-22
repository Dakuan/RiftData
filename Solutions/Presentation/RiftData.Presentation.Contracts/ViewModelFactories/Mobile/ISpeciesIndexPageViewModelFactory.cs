using RiftData.Presentation.ViewModels.Mobile;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Mobile
{
    public interface ISpeciesIndexPageViewModelFactory
    {
        SpeciesIndexPageViewModel Build(string speciesName);
    }
}