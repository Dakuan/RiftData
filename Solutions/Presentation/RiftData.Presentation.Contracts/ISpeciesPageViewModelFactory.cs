using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build(string fullName);
        SpeciesPageViewModel Build(int speciesId);
    }
}