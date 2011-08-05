using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Shared.ViewModels
{
    public class GenusPanelViewModel
    {
        public IList<Genus> GenusList;

        public GenusType GenusType;

        public int ExpandedGenus { get; set; }

        public int SelectedSpecies { get; set; }
    }
}
