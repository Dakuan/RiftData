namespace RiftData.Presentation.Contracts
{
    using RiftData.Presentation.ViewModels;

    public interface ILocaleInfoBoxViewModelFactory
    {
        LocaleInfoBoxViewModel Build(int localeId);
    }
}