namespace RiftData.Presentation.Contracts.Admin.LakePages
{
    using RiftData.Presentation.ViewModels.Admin.Lake;

    public interface ILakeUpdatePageViewModelFactory
    {
        LakeUpdatePageViewModel Build(int lakeId);
    }
}