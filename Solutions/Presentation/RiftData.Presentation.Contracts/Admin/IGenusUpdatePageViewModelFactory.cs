using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface IGenusUpdatePageViewModelFactory
    {
        GenusUpdatePageViewModel Build(int genusId);
    }
}