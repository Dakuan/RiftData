namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Presentation.Contracts;

    //[OutputCache(CacheProfile = "Daily")]
    public class LocaleController : Controller
    {
        private readonly ILocaleInfoBoxViewModelFactory _localeInfoBoxViewModelFactory;
        private readonly ILocaleDtoService _localeDtoService;
        private readonly ILocalePageViewModelFactory _localePageViewModelFactory;

        public LocaleController(ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocaleDtoService localeDtoService, ILocalePageViewModelFactory localePageViewModelFactory)
        {
            _localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            _localeDtoService = localeDtoService;
            _localePageViewModelFactory = localePageViewModelFactory;
        }

        public ActionResult Index(string localeName)
        {
            var viewModel = this._localePageViewModelFactory.Build(localeName);

            return View(viewModel);
        }

        public ActionResult GetInfoBox(int id)
        {
            var viewModel = this._localeInfoBoxViewModelFactory.Build(id);

            return PartialView("LocaleInfoBox", viewModel);
        }

        public ActionResult GetLocalesBySpecies(int id)
        {
            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = this._localeDtoService.GetLocaleDtosFromSpecies(id)
                       };
        }

        public ActionResult GetLocaleData(int id)
        {
            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = this._localeDtoService.GetLocaleDto(id)
                       };
        }

        public ActionResult GetLocalesForZoomLevel(int id)
        {
            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = this._localeDtoService.GetLocalesForZoomLevel(id)
                       };
        }

        public ActionResult GetLocaleLabel(int id)
        {
            var locale = this._localeDtoService.GetLocaleDto(id);

            return PartialView("LocaleLabel", locale);
        }
    }
}
