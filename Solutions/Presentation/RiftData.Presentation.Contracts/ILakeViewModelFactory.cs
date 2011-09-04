using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface ILakeViewModelFactory
    {
        LakeViewModel Build(string lakeName);
    }
}
