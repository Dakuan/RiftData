using System.Web.Mvc;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;

namespace RiftData.Controllers
{
    //[OutputCache(CacheProfile = "Daily")]
    public class LocaleController : Controller
    {
        private readonly ILocaleInfoBoxViewModelFactory _localeInfoBoxViewModelFactory;
        private readonly ILocaleDtoService _localeDtoService;

        public LocaleController(IDtoFactory dtoFactory, ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocaleDtoService localeDtoService)
        {
            _localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            _localeDtoService = localeDtoService;
        }

        public ActionResult Index(string localeName)
        {
            return null;
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
