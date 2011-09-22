using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface IFishEditPageViewModelFactory
    {
        FishEditPageViewModel Build(int fishId, bool? showSuccessMessage);
    }
}