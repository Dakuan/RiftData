using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build(string fullName);
        SpeciesPageViewModel Build(int speciesId);
    }
}