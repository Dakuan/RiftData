using System;
using Castle.Core;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;

namespace RiftData.Domain.Installers
{
    public class DomainServicesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(AllTypes.FromThisAssembly()
                                .Pick()
                                .If(IsService)
                                .WithService.DefaultInterface()
                                .Configure(x => x.LifeStyle.Is(LifestyleType.Transient)));
        }

        private static bool IsService(Type type)
        {
            return type.Name.EndsWith("Service", StringComparison.InvariantCultureIgnoreCase);
        }
    }
}