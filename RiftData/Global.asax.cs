using System.Web.Mvc;
using System.Web.Routing;
using Castle.Windsor;
using Castle.Windsor.Configuration.Interpreters;
using Castle.Windsor.Installer;
using RiftData.ApplicationServices.Installers;
using RiftData.Controllers;
using RiftData.Domain.Installers;
using RiftData.Infrastructure.Data;

namespace RiftData
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Species", 
                "Species/{speciesFullName}",
                new { controller = "Species", action = "Index" }
                );

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            InitializeServiceLocator();

            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }

        private static void InitializeServiceLocator()
        {
            IWindsorContainer container = new WindsorContainer(new XmlInterpreter());

            container.Install(FromAssembly.Containing<DataContextInstaller>());

            container.Install(FromAssembly.Containing<FactoriesInstaller>());

            //container.Install(FromAssembly.Containing<RepositoriesInstaller>());

            //container.Install(FromAssembly.Containing<QueriesInstaller>());

            container.Install(FromAssembly.Containing<ViewModelFactoryInstaller>());

            container.Install(FromAssembly.Containing<WindsorControllerFactory>());
        }
    }
}