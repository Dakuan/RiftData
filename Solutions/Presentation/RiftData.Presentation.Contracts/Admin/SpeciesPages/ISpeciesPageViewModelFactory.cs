namespace RiftData.Presentation.Contracts.Admin.SpeciesPages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface ISpeciesPageViewModelFactory
    {
        SpeciesPageViewModel Build();
    }
}