namespace RiftData.ApplicationServices.DtoServices.Extensions
{
    using RiftData.Domain.Entities;

    internal class SelectListComment : IEntity
    {
        public int Id { get; set; }

        public string Name { get; set; }
    }
}