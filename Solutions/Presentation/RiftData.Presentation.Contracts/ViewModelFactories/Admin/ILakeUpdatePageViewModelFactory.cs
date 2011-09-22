using RiftData.Presentation.ViewModels.Admin.Lake;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface ILakeUpdatePageViewModelFactory
    {
        LakeUpdatePageViewModel Build(int lakeId);
    }
}