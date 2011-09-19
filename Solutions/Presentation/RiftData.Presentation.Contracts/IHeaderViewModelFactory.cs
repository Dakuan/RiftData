namespace RiftData.Presentation.Contracts
{
    using RiftData.Domain.Entities;
    using RiftData.Presentation.ViewModels;
    using RiftData.Presentation.ViewModels.Dto;

    public interface IHeaderViewModelFactory
    {
        HeaderViewModel Build();

        HeaderViewModel Build(int lakeId, int genusTypeId);

        HeaderViewModel Build(Locale locale);

        HeaderViewModel Build(Fish fish);

        HeaderViewModel Build(GenusType genusType);

        HeaderViewModel Build(LakeDto genusType);

        HeaderViewModel BuildFromSpecies(int speciesId);
    }
}