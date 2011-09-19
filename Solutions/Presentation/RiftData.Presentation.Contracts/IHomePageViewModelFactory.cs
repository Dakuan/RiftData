namespace RiftData.Presentation.Contracts
{
    using RiftData.Presentation.ViewModels;

    public interface IHomePageViewModelFactory
    {
        HomePageViewModel Build(string genusTypeName);
    }
}