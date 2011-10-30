using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.Extensions;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

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
        private readonly IGenusRepository genusRepository;

        private readonly ILakeRepository lakeRepository;

        public LocaleController(ILocaleInfoBoxViewModelFactory localeInfoBoxViewModelFactory, ILocalesRepository localeRepository, ILocalePageViewModelFactory localePageViewModelFactory, IGenusRepository genusRepository, ILakeRepository lakeRepository)
        {
            this.localeInfoBoxViewModelFactory = localeInfoBoxViewModelFactory;
            this.localeRepository = localeRepository;
            this.localePageViewModelFactory = localePageViewModelFactory;
            this.genusRepository = genusRepository;
            this.lakeRepository = lakeRepository;
        }

        public ActionResult GetInfoBox(int id)
        {
            var viewModel = this.localeInfoBoxViewModelFactory.Build(id);

            return this.PartialView("LocaleInfoBox", viewModel);
        }

        public ActionResult GetLocaleData(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = DtoFactory.Build(this.localeRepository.Get(id)) };
        }

        public ActionResult GetLocaleLabel(int id)
        {
            var locale = DtoFactory.Build(this.localeRepository.Get(id));

            return this.PartialView("LocaleLabel", locale);
        }

        public ActionResult GetForLakeFromGenus(int id)
        {
            var genus = this.genusRepository.Get(id);

            return RedirectToAction("GetForLake", new { id = genus.GenusType.Lake.Id });
        }

        public ActionResult GetForLake(int id)
        {
            var data = this.localeRepository.GetByLake(id).ToDtoList().StripToBasic();

            return new JsonResult
                       {
                           Data = data,
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet
                       };
        }

        public ActionResult GetLocalesBySpecies(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localeRepository.GetWithSpecies(id).ToDtoList().StripToBasic()};
        }

        public ActionResult GetLocalesForZoomLevel(int id, int? lakeId)
        {
            if (lakeId == null)
            {
                lakeId = this.lakeRepository.GetFirst().Id;
            }
            var data = this.localeRepository.GetForLakeAtZoomLevel(id, Convert.ToInt16(lakeId)).ToDtoList().ToList();

            var testData = data.StripToBasic();

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = testData };
        }

        public ActionResult Index(string localeName)
        {
            try
            {
                var viewModel = this.localePageViewModelFactory.Build(localeName);

                return View(viewModel);
            }
            catch
            {
                return RedirectToAction("NoLocale", "Error");
            }
        }
    }
}