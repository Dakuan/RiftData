namespace RiftData.Presentation.Contracts.Admin
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build();
    }
}