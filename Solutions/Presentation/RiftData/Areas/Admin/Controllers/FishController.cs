using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.Areas.Admin.Controllers
{
    using System;
    using System.Web.Mvc;
    using System.Web.Routing;

    using RiftData.Extensions;
    using RiftData.ApplicationServices.Twitter;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Infrastructure.Data.Logging;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class FishController : Controller
    {
        private readonly IFishEditPageViewModelFactory fishEditPageViewModelFactory;

        private readonly ITwitterService twitterService;

        private readonly IFishPageViewModelFactory fishPageViewModelFactory;

        private readonly IFishRepository fishRepository;

        private readonly ILogger logger;

        private readonly IPhotosRepository photosRepository;

        private readonly ISpeciesRepository speciesRepository;

        public FishController(ITwitterService twitterService, IFishPageViewModelFactory fishPageViewModelFactory, IFishEditPageViewModelFactory fishEditPageViewModelFactory, IFishRepository fishRepository, ISpeciesRepository speciesRepository, IPhotosRepository photosRepository, ILogger logger)
        {
            this.twitterService = twitterService;
            this.fishPageViewModelFactory = fishPageViewModelFactory;
            this.fishEditPageViewModelFactory = fishEditPageViewModelFactory;
            this.fishRepository = fishRepository;
            this.speciesRepository = speciesRepository;
            this.photosRepository = photosRepository;
            this.logger = logger;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create(bool? showSuccessMessage)
        {
            var vm = this.fishEditPageViewModelFactory.Build(0, Convert.ToBoolean(showSuccessMessage));

            return View(vm);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(FishEditFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var updateResult = this.fishRepository.Add(viewModel.Genus, viewModel.Species, viewModel.Locales, viewModel.Description, this.User.Identity.Name);

            if (updateResult != null)
            {
                // post a twitter update
                this.twitterService.PostFishAddition(updateResult, this.ToPublicUrl(new Uri(Url.Action("Index", "Fish", new { Area = string.Empty, fishName = updateResult.UrlName }))));
            }

            return updateResult != null ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this.fishRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult DeletePhoto(int fishId, int photoId)
        {
            this.photosRepository.Delete(photoId);

            return this.RedirectToAction("Update", new { id = fishId });
        }

        public ActionResult GetSpecies(int id)
        {
            var speciesList = this.speciesRepository.GetSpeciesWithGenus(id).ToSelectList();

            return new JsonResult { Data = speciesList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public ActionResult Index(int? id)
        {
            if (id == null)
            {
                id = 1;
            }

            var viewModel = this.fishPageViewModelFactory.Build(Convert.ToInt16(id));

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id, bool? showSuccessMessage)
        {
            var viewModel = this.fishEditPageViewModelFactory.Build(id, Convert.ToBoolean(showSuccessMessage));

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(FishEditFormViewModel vm)
        {
            this.TryUpdateModel(vm);

            var updateResult = this.fishRepository.Update(vm.Id, vm.Genus, vm.Species, vm.Locales, vm.Description, this.User.Identity.Name);

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }


        public string ToPublicUrl(Uri relativeUri)
        {
            var httpContext = this.Request.RequestContext.HttpContext;

            var uriBuilder = new UriBuilder
            {
                Host = httpContext.Request.Url.Host,
                Path = "/",
                Port = 80,
                Scheme = "http",
            };

            if (httpContext.Request.IsLocal)
            {
                uriBuilder.Port = httpContext.Request.Url.Port;
            }

            return new Uri(uriBuilder.Uri, relativeUri).AbsoluteUri;
        }
    }
}