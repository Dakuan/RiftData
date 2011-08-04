using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Controllers.Shared
{
    public class LocaleController : Controller
    {
        private readonly IFishRepository _fishRepository;

        public LocaleController(IFishRepository fishRepository)
        {
            _fishRepository = fishRepository;
        }

        public ActionResult GetLocalesBySpecies(int id)
        {
            var localeList = new List<Locale>();

            _fishRepository.GetFishBySpecies(id).ToList().ForEach(f => localeList.Add(f.Locale));

            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = localeList
                       };
        }
    }
}
