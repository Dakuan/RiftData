﻿using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusTypeUpdatePageViewModel : ViewModelBase
    {
        public GenusTypeUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public GenusTypeDto GenusType { get; set; }

        public SelectList Lakes { get; set; }
    }
}