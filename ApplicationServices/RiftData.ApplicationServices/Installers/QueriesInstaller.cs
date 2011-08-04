using System;
using Castle.Core;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;

namespace RiftData.ApplicationServices.Installers
{
    public class QueriesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(AllTypes.FromThisAssembly()
                                .Pick()
                                .If(IsQuery)
                                .WithService.DefaultInterface()
                                .Configure(x => x.LifeStyle.Is(LifestyleType.Transient)));
        }

        private static bool IsQuery(Type type)
        {
            return type.Name.EndsWith("Query", StringComparison.InvariantCultureIgnoreCase);
        }
    }
}
