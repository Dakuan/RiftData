namespace RiftData.Infrastructure.Data.Installers
{
    using System;

    using Castle.Core;
    using Castle.MicroKernel.Registration;
    using Castle.MicroKernel.SubSystems.Configuration;
    using Castle.Windsor;

    public class LoggerInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(AllTypes.FromThisAssembly().Pick().If(IsLogger).WithService.DefaultInterface().Configure(x => x.LifeStyle.Is(LifestyleType.Transient)));
        }

        private static bool IsLogger(Type type)
        {
            return type.Name.EndsWith("Logger", StringComparison.InvariantCultureIgnoreCase);
        }
    }
}