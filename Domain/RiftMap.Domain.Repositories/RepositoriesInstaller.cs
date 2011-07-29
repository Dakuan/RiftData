using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using RiftData.Domain.Core;
using RiftMap.Domain.Repositories;

namespace RiftData.Domain.Repositories
{
    public class RepositoriesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(Component
                .For<IRepository<Species>>()
                .ImplementedBy<SpeciesRepository>());

            container.Register(Component
                .For<IRepository<Genus>>()
                .ImplementedBy<GenusRepository>());
        }
    }
}
