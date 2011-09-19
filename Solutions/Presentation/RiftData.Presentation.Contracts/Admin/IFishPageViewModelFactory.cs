namespace RiftData.Presentation.Contracts.Admin
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IFishPageViewModelFactory
    {
        FishIndexPageViewModel Build(int id);
    }
}