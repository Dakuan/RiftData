namespace RiftData.Presentation.Contracts.Admin.GenusPages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IGenusUpdatePageViewModelFactory
    {
        GenusUpdatePageViewModel Build(int genusId);
    }
}