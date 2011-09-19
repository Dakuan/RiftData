namespace RiftData.Presentation.Contracts
{
    using RiftData.Presentation.ViewModels;

    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build(string fullName);
    }
}