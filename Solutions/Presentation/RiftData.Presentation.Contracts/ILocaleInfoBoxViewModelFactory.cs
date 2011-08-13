using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface ILocaleInfoBoxViewModelFactory
    {
        LocaleInfoBoxViewModel Build(int localeId);
    }
}