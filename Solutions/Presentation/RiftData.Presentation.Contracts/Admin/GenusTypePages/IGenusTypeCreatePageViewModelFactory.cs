namespace RiftData.Presentation.Contracts.Admin.GenusTypePages
{
    using RiftData.Presentation.ViewModels.Admin;
    using RiftData.Presentation.ViewModels.Admin.GenusType;

    public interface IGenusTypeCreatePageViewModelFactory
    {
        GenusTypeCreatePageViewModel Build();
    }
}