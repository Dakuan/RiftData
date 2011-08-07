using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build(string fullName);
        SpeciesPageViewModel Build(int speciesId);
    }
}