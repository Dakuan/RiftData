namespace RiftData.Presentation.Contracts.Admin.FishPages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IFishPageViewModelFactory
    {
        FishIndexPageViewModel Build(int id);
    }
}