using System;
using RiftData.Domain.Enums;
using RiftData.Presentation.Contracts.Mailer;

namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class SpeciesController : Controller
    {
        private readonly ISpeciesPageViewModelFactory speciesPageViewModelFactory;
        private readonly IMailer mailer;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory, IMailer mailer)
        {
            this.speciesPageViewModelFactory = speciesPageViewModelFactory;
            this.mailer = mailer;
        }

        public ActionResult Index(string speciesFullName)
        {
            try
            {
                var viewModel = this.speciesPageViewModelFactory.Build(speciesFullName);

                return View(viewModel);
            }
            catch(Exception exception)
            {
                //todo, log this
                this.mailer.LogNotFound(speciesFullName, ItemType.Species);

                return RedirectToAction("NoFish", "Error");
            }
        }
    }
}