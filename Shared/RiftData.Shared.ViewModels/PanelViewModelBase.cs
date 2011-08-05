using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Shared.ViewModels
{
    public class PanelViewModelBase
    {
        public IList<GenusType> GenusTypes;

        public int? SelectedGenusTypeId { get; set; }

        public int? SelectedGenusId { get; set; }

        public int? SelectedSpeciesId { get; set; }
    }
}
