
namespace RiftData.ApplicationServices.Installers
{
    using System;

    using Castle.Core;
    using Castle.MicroKernel.Registration;
    using Castle.MicroKernel.SubSystems.Configuration;
    using Castle.Windsor;

    public class MailerInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(AllTypes.FromThisAssembly().Pick().If(IsService).WithService.DefaultInterface().Configure(x => x.LifeStyle.Is(LifestyleType.Transient)));
        }

        private static bool IsService(Type type)
        {
            return type.Name.EndsWith("Mailer", StringComparison.InvariantCultureIgnoreCase);
        }
    }
}