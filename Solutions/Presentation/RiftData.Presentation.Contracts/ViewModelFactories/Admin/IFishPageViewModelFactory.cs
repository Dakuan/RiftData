using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface IFishPageViewModelFactory
    {
        FishIndexPageViewModel Build(int id);
    }
}