using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface ILocaleUpdatePageViewModelFactory
    {
        LocaleUpdatePageViewModel Build(int localeId);
    }
}