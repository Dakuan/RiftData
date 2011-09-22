using RiftData.Presentation.ViewModels.Mobile;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Mobile
{
    public interface IGenusTypesIndexPageViewModelFactory
    {
        GenusTypesIndexPageViewModel Build(string genusTypeName);
    }
}