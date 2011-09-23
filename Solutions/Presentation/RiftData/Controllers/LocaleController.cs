namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class LocaleController : Controller
    {
        private readonly ILocaleDtoService localeDtoService;

        private readonly ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory;

        private readonly ILocalePageViewModelFactory localePageViewModelFactory;

        public LocaleController(ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocaleDtoService localeDtoService, ILocalePageViewModelFactory localePageViewModelFactory)
        {
            this.localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            this.localeDtoService = localeDtoService;
            this.localePageViewModelFactory = localePageViewModelFactory;
        }

        public ActionResult GetInfoBox(int id)
        {
            var viewModel = this.localeInfoBoxViewModelFactory.Build(id);

            return this.PartialView("LocaleInfoBox", viewModel);
        }

        public ActionResult GetLocaleData(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeDtoService.GetLocaleDto(id) };
        }

        public ActionResult GetLocaleLabel(int id)
        {
            var locale = this.localeDtoService.GetLocaleDto(id);

            return this.PartialView("LocaleLabel", locale);
        }

        public ActionResult GetLocalesBySpecies(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeDtoService.GetLocaleDtosFromSpecies(id) };
        }

        public ActionResult GetLocalesForZoomLevel(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeDtoService.GetLocalesForZoomLevel(id) };
        }

        public ActionResult Index(string localeName)
        {
            var viewModel = this.localePageViewModelFactory.Build(localeName);

            return View(viewModel);
        }
    }
}