namespace RiftData.Presentation.Contracts
{
    using ViewModels;

    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build(string fullName);
    }
}