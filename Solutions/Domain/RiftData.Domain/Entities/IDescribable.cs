namespace RiftData.Domain.Entities
{
    public interface IDescribable
    {
        string Description { get; set; }

        bool HasDescription { get; }
    }
}