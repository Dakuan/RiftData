namespace RiftData.Presentation.Contracts
{
    using RiftData.Presentation.ViewModels;

    public interface ILakeViewModelFactory
    {
        LakeViewModel Build(string lakeName);
    }
}