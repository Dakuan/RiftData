using System;

namespace RiftData
{
    using System.Web;
    using System.Web.Mvc;
    using System.Web.Routing;

    using Castle.Windsor;
    using Castle.Windsor.Configuration.Interpreters;
    using Castle.Windsor.Installer;

    using MvcSiteMapProvider.Web;

    using RiftData.ApplicationServices.Installers;
    using RiftData.Controllers.Factory;
    using RiftData.Domain.Installers;
    using RiftData.Infrastructure.Data.Installers;
    using RiftData.Infrastructure.Flickr;

    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("favicon.ico");

            routes.MapRoute("Home", // Route name
                "{genusTypeName}", // URL with parameters
                new { controller = "Home", action = "Index", genusTypeName = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Controllers" });

            routes.MapRoute("Species", "Species/{speciesFullName}", new { controller = "Species", action = "Index" }, new[] { "RiftData.Controllers" });

            routes.MapRoute("Locale", "Locale/{localeName}", new { controller = "Locale", action = "Index" }, new[] { "RiftData.Controllers" });

            routes.MapRoute("Fish", "Fish/{fishName}", new { controller = "Fish", action = "Index" }, new[] { "RiftData.Controllers" });

            routes.MapRoute("Lake", "Lake/{lakeName}", new { controller = "Lake", action = "Index" }, new[] { "RiftData.Controllers" });

            routes.MapRoute("Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }, // Parameter defaults
                new[] { "RiftData.Controllers" });
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Redirect mobile users to the mobile home page
            var httpRequest = HttpContext.Current.Request;

            if (!httpRequest.Browser.IsMobileDevice) return;
            var path = httpRequest.Url.PathAndQuery;
            var isOnMobilePage = path.StartsWith("/Mobile/", StringComparison.OrdinalIgnoreCase);
            if (!isOnMobilePage)
            {
                HttpContext.Current.Response.RedirectToRoute("Mobile_default");
            }
        }

        protected void Application_Start()
        {
            InitializeServiceLocator();

            AreaRegistration.RegisterAllAreas();

            XmlSiteMapController.RegisterRoutes(RouteTable.Routes);

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }

        private static void InitializeServiceLocator()
        {
            IWindsorContainer container = new WindsorContainer(new XmlInterpreter());

            container.Install(FromAssembly.Containing<DataContextInstaller>());

            container.Install(FromAssembly.Containing<FlickrInstaller>());

            container.Install(FromAssembly.Containing<FactoriesInstaller>());

            // container.Install(FromAssembly.Containing<RepositoriesInstaller>());
            container.Install(FromAssembly.Containing<ServicesInstaller>());

            container.Install(FromAssembly.Containing<ViewModelFactoryInstaller>());
            container.Install(FromAssembly.Containing<WindsorControllerFactory>());
        }
    }
}