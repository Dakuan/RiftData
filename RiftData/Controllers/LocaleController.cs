using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Controllers
{
    public class LocaleController : Controller
    {
        private readonly ILocaleInfoBoxViewModelFactory _localeInfoBoxViewModelFactory;

        public LocaleController(IDtoFactory dtoFactory, ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILo)
        {
            _fishRepository = fishRepository;
            _dtoFactory = dtoFactory;
            _localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
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
                           Data = localeList
                       };
        }
    }
}
