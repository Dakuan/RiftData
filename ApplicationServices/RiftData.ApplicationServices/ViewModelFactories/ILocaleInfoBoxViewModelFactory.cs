using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public interface ILocaleInfoBoxViewModelFactory
    {
        LocaleInfoBoxViewModel Build(int localeId);
    }
}