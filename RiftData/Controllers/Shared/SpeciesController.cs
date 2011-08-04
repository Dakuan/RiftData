using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.Controllers.Shared
{
    public class SpeciesController : Controller
    {
        private readonly ISpeciesPageViewModelFactory _speciesPageViewModelFactory;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory)
        {
            _speciesPageViewModelFactory = speciesPageViewModelFactory;
        }

        public ActionResult Index(string speciesFullName)
        {
            var viewModel = this._speciesPageViewModelFactory.Build(speciesFullName);

            return View(viewModel);
        }
    }
}
