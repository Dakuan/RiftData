using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface IHomePageViewModelFactory
    {
        HomePageViewModel Build(string genusTypeName);
    }
}