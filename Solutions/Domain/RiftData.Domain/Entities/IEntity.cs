﻿namespace RiftData.Domain.Entities
{
    public interface IEntity
    {
        int Id { get; set; }

        string Name { get; }
    }
}