using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Domain.Installers
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

            container.Register(Component
                                   .For<IRepository<Locale>>()
                                   .ImplementedBy < LocalesRepository>());

            container.Register(Component
                                   .For<IRepository<Fish>>()
                                   .ImplementedBy<FishRepository>());

            container.Register(Component
                                    .For<IRepository<GenusType>>()
                                    .ImplementedBy<GenusTypeRepository>());
        }
    }
}