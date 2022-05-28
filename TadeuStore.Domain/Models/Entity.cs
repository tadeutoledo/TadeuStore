﻿namespace TadeuStore.Domain.Models
{
    public abstract class Entity
    {
        public Entity()
        {
            Id = new Guid();
        }

        public Guid Id{ get; set; }

    }
}
