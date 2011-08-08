using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface IDtoFactory
    {
        FishDto Build(Fish fish);

        LocaleDto Build(Locale locale);

        SpeciesDto Build(Species species);

        GenusDto Build(Genus genus);

        PhotoDto Build(Photo photo);

        GenusTypeDto Build(GenusType genusType);
    }
}