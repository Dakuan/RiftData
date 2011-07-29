using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftMap.Domain.Repositories;
using Species = RiftData.Domain.Core.Species;

namespace RiftData.Controllers.Home
{
    public class HomeController : Controller
    {
        private IRepository<Species> speciesRepository;

        public HomeController(IRepository<Species> speciesRepository)
        {
            this.speciesRepository = speciesRepository;
        }

        public ActionResult Index()
        {

            var viewModel = new HomeViewModel();

            this.speciesRepository.List.ToList().ForEach(s => viewModel.Items.Add(s.GetFullName));

            return View(viewModel);
        }
    }
}
