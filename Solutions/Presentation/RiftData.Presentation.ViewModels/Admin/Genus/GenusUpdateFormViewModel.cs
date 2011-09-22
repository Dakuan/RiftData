﻿using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Genus
{
    public class GenusUpdateFormViewModel : Shared.ViewModelBase
    {
        public GenusUpdateFormViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public int Id { get; set; }

        public string Name { get; set; }
    }
}