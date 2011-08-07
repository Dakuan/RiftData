using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface ILocaleInfoBoxViewModelFactory
    {
        LocaleInfoBoxViewModel Build(int localeId);
    }
}