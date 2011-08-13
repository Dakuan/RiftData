using System.Web.Mvc;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Presentation.Contracts;

namespace RiftData.Controllers
{
    //[OutputCache(CacheProfile = "Daily")]
    public class LocaleController : Controller
    {
        private readonly ILocaleInfoBoxViewModelFactory _localeInfoBoxViewModelFactory;
        private readonly ILocaleDtoService _localeDtoService;
        private readonly ILocalePageViewModelFactory _localePageViewModelFactory;

        public LocaleController(IDtoFactory dtoFactory, ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocaleDtoService localeDtoService, ILocalePageViewModelFactory localePageViewModelFactory)
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
    }
}
