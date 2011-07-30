using RiftData.Domain.Entities;
using Type = RiftData.Infrastructure.Data.Type;

namespace RiftData.Domain.Factories
{
    public class GenusTypeFactory : IGenusTypeFactory
    {
        public GenusType Build(Type dataGenusType)
        {
            return new GenusType(dataGenusType.GenusTypeID) { Name = dataGenusType.GenusTypeName, GenusCount = dataGenusType.Genus.Count };
        }
    }
}