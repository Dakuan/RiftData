using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using RiftData.Domain.Core;

namespace RiftMap.Domain.Factories
{
    public class FactoriesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(Component
                .For<IFactory<Species>>()
                .ImplementedBy<SpeciesFactory>());

            container.Register(Component
                .For<IFactory<Genus>>()
                .ImplementedBy<GenusFactory>());
        }
    }
}
