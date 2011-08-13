using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface ILocalePageViewModelFactory
    {
        LocalePageViewModel Build(string fullName);
    }
}