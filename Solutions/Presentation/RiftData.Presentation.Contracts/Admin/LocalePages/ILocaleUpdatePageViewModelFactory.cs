namespace RiftData.Presentation.Contracts.Admin.LocalePages
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface ILocaleUpdatePageViewModelFactory
    {
        LocaleUpdatePageViewModel Build(int localeId);
    }
}