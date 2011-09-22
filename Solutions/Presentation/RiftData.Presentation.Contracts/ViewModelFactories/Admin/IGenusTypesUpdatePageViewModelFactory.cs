using RiftData.Presentation.ViewModels.Admin.GenusType;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface IGenusTypesUpdatePageViewModelFactory
    {
        GenusTypeUpdatePageViewModel Build(int genusTypeId);
    }
}