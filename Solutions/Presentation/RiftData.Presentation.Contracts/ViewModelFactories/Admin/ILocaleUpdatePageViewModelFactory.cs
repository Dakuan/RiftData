using RiftData.Presentation.ViewModels.Admin.Locale;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface ILocaleUpdatePageViewModelFactory
    {
        LocaleUpdatePageViewModel Build(int localeId);
    }
}