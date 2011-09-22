namespace RiftData.Presentation.Contracts.Admin.GenusPages
{
    using RiftData.Presentation.ViewModels.Admin;
    using RiftData.Presentation.ViewModels.Admin.Genus;

    public interface IGenusCreatePageViewModelFactory
    {
        GenusCreatePageViewModel Build();
    }
}