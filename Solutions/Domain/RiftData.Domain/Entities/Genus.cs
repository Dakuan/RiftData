﻿using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Genus 
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public virtual ICollection<Species> Species { get; set; }

        public int NumberOfSpecies { get { return this.Species.Count; } }

        public virtual GenusType GenusType { get; set; }

        public bool HasFish { get; set; }

        public override string ToString()
        {
            return this.Name;
        }
    }
}