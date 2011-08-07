using RiftData.Domain.Entities;
using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public interface ILocaleInfoBoxViewModelFactory
    {
        LocaleInfoBoxViewModel Build(int localeId);
    }
}