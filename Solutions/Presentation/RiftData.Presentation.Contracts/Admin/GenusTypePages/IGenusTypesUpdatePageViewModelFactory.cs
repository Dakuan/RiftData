namespace RiftData.Presentation.Contracts.Admin.GenusTypePages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IGenusTypesUpdatePageViewModelFactory
    {
        GenusTypeUpdatePageViewModel Build(int genusTypeId);
    }
}