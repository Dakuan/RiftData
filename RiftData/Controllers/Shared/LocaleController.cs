using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.Controllers.Shared
{
    public class LocaleController : Controller
    {
        private readonly IFishRepository _fishRepository;
        private readonly IDtoFactory _dtoFactory;
        private readonly ILocaleInfoBoxViewModelFactory _localeInfoBoxViewModelFactory;

        public LocaleController(IFishRepository fishRepository, IDtoFactory dtoFactory, ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocalesRepository localesRepository)
        {
            _fishRepository = fishRepository;
            _dtoFactory = dtoFactory;
            _localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            _localesRepository = localesRepository;
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
            var localeList = new List<LocaleDto>();

            _fishRepository.GetFishBySpecies(id).ToList().ForEach(f => localeList.Add(this._dtoFactory.Build(f.Locale)));

            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = localeList
                       };
        }
    }
}
