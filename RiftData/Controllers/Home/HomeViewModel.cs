using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RiftData.Controllers.Home
{
    public class HomeViewModel
    {
        public HomeViewModel()
        {
            this.Items = new List<string>();
        }
        public List<string> Items { get; set; }
    }
}