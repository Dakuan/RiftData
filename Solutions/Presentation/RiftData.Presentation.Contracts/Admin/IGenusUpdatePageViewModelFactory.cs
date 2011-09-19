namespace RiftData.Presentation.Contracts.Admin
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IGenusUpdatePageViewModelFactory
    {
        GenusUpdatePageViewModel Build(int genusId);
    }
}