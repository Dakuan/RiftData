﻿namespace RiftData.Domain.Installers
{
    using System;

    using Castle.Core;
    using Castle.MicroKernel.Registration;
    using Castle.MicroKernel.SubSystems.Configuration;
    using Castle.Windsor;

    public class FactoriesInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(AllTypes.FromThisAssembly().Pick().If(IsFactory).WithService.DefaultInterface().Configure(x => x.LifeStyle.Is(LifestyleType.Transient)));
        }

        private static bool IsFactory(Type type)
        {
            return type.Name.EndsWith("Factory", StringComparison.InvariantCultureIgnoreCase);
        }
    }
}