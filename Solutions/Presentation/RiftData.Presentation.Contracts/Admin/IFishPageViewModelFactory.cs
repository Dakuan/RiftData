using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface IFishPageViewModelFactory
    {
        FishIndexPageViewModel Build(int id);
    }
}