using RiftData.Domain.Entities;

namespace RiftData.Domain.Extensions
{
    internal class SelectListComment : IEntity
    {
        public int Id { get; set; }

        public string Name { get; set; }
    }
}