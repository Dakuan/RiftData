using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface ILocalePageViewModelFactory
    {
        LocalePageViewModel Build(string fullName);
    }
}