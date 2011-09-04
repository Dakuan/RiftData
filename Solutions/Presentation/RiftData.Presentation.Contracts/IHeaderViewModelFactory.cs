using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.Contracts
{
    public interface IHeaderViewModelFactory
    {
        HeaderViewModel Build();

        HeaderViewModel Build(int lakeId, int genusTypeId);

        HeaderViewModel BuildFromSpecies(int speciesId);

        HeaderViewModel Build(Locale locale);

        HeaderViewModel Build(Fish fish);

        HeaderViewModel Build(GenusType genusType);

        HeaderViewModel Build(LakeDto genusType);
    }
}