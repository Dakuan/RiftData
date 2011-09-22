using RiftData.Presentation.ViewModels.Mobile;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Mobile
{
    public interface IGenusIndexPageViewModelFactory
    {
        GenusIndexPageViewModel Build(string genusName);
    }
}