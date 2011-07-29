namespace RiftData.Domain.Core
{
    public abstract class EntityBase
    {
        protected EntityBase(int id)
        {
            this.Id = id;
        }

        public int Id { get; private set; }
    }
}