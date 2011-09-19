namespace RiftData.Presentation.Contracts
{
    using RiftData.Presentation.ViewModels;

    public interface ILocalePageViewModelFactory
    {
        LocalePageViewModel Build(string fullName);
    }
}