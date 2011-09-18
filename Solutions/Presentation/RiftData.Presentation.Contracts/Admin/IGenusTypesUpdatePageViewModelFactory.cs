using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface IGenusTypesUpdatePageViewModelFactory
    {
        GenusTypeUpdatePageViewModel Build(int genusTypeId);
    }
}