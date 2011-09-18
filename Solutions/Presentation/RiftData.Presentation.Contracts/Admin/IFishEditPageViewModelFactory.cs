using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface IFishEditPageViewModelFactory
    {
        FishEditPageViewModel Build(int fishId, bool? showSuccessMessage);
    }
}