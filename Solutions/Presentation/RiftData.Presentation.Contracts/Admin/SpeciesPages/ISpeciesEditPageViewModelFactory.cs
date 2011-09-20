namespace RiftData.Presentation.Contracts.Admin.SpeciesPages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface ISpeciesEditPageViewModelFactory
    {
        SpeciesEditPageViewModel Build(int speciesId);

        SpeciesEditPageViewModel Build();
    }
}