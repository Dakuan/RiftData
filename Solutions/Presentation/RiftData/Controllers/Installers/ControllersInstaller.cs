namespace RiftData.Controllers.Installers
{
    using System;
    using System.Linq;
    using System.Reflection;
    using System.Web.Mvc;

    using Castle.Core;
    using Castle.MicroKernel.Registration;
    using Castle.MicroKernel.SubSystems.Configuration;
    using Castle.Windsor;

    using MvcSiteMapProvider.Web;

    public class ControllersInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            var types = Assembly.GetAssembly(typeof(HomeController)).GetExportedTypes().Where(IsController);

            types.ForEach(
                t => container.Register(
                    Component.For(t).ImplementedBy(t)
                         
                         // .Named(t.Name.ToLower())
                         .LifeStyle.Is(LifestyleType.Transient)));

            container.Register(
                Component.For<XmlSiteMapController>().ImplementedBy<XmlSiteMapController>().LifeStyle.Is(
                    LifestyleType.Transient));
        }

        private static bool IsController(Type type)
        {
            return typeof(IController).IsAssignableFrom(type);
        }
    }
}