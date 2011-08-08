using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface IHomePageViewModelFactory
    {
        HomePageViewModel Build(string genusTypeName);
    }
}