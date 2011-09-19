namespace RiftData.Presentation.Contracts.Admin
{
    using RiftData.Presentation.ViewModels.Admin;

    public interface ILocaleUpdatePageViewModelFactory
    {
        LocaleUpdatePageViewModel Build(int localeId);
    }
}