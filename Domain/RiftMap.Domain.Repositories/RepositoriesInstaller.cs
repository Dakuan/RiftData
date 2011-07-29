using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using RiftData.Domain.Core;

namespace RiftMap.Domain.Repositories
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
