using Castle.Core;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;

namespace RiftData.Infrastructure.Data.Installers
{
    public class DataContextInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(Component.For<RiftDataDataContext>().LifeStyle.Is(LifestyleType.Thread));
        }
    }
}
