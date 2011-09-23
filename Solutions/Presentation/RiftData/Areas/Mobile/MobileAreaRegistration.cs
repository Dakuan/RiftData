namespace RiftData.Areas.Mobile
{
    using System.Web.Mvc;

    public class MobileAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Mobile";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute("Mobile_photos", // Route name
                "Mobile/species/photos/{speciesName}", // URL with parameters
                new { controller = "Species", action = "Photos", speciesName = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Areas.Mobile.Controllers" });

            context.MapRoute("Mobile_species", // Route name
                "Mobile/species/{speciesName}", // URL with parameters
                new { controller = "Species", action = "Index", speciesName = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Areas.Mobile.Controllers" });

            context.MapRoute("Mobile_genus", // Route name
                "Mobile/genus/{genusName}", // URL with parameters
                new { controller = "Genus", action = "Index", genusName = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Areas.Mobile.Controllers" });

            context.MapRoute("Mobile_genusType", // Route name
                "Mobile/genustypes/{genusTypeName}", // URL with parameters
                new { controller = "GenusTypes", action = "Index", genusTypeName = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Areas.Mobile.Controllers" });

            context.MapRoute("Mobile_default", "Mobile/{controller}/{action}/{id}", new { controller = "Home", action = "Index", id = UrlParameter.Optional }, new[] { "RiftData.Areas.Mobile.Controllers" });
        }
    }
}