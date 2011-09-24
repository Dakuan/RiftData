using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class LocaleController : Controller
    {
        private readonly ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory;
        private readonly ILocalesRepository localeRepository;

        private readonly ILocalePageViewModelFactory localePageViewModelFactory;

        public LocaleController(ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocalesRepository localeRepository, ILocalePageViewModelFactory localePageViewModelFactory)
        {
            this.localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            this.localeRepository = localeRepository;
            this.localePageViewModelFactory = localePageViewModelFactory;
        }

        public ActionResult GetInfoBox(int id)
        {
            var viewModel = this.localeInfoBoxViewModelFactory.Build(id);

            return this.PartialView("LocaleInfoBox", viewModel);
        }

        public ActionResult GetLocaleData(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeRepository.Get(id) };
        }

        public ActionResult GetLocaleLabel(int id)
        {
            var locale = this.localeRepository.Get(id);

            return this.PartialView("LocaleLabel", locale);
        }

        public ActionResult GetLocalesBySpecies(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeRepository.GetWithSpecies(id).ToDtoList() };
        }

        public ActionResult GetLocalesForZoomLevel(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeRepository.GetForZoomLevel(id) };
        }

        public ActionResult Index(string localeName)
        {
            var viewModel = this.localePageViewModelFactory.Build(localeName);

            return View(viewModel);
        }
    }
}