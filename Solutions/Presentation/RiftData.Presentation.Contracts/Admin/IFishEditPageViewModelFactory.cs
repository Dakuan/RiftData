namespace RiftData.Presentation.Contracts.Admin
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface IFishEditPageViewModelFactory
    {
        FishEditPageViewModel Build(int fishId, bool? showSuccessMessage);
    }
}