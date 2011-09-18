using Castle.Core;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;


namespace RiftData.Infrastructure.Flickr
{
    public class FlickrInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(Component
                                   .For<IFlickrInfrastructure>()
                                   .LifeStyle.Is(LifestyleType.Transient)
                                   .ImplementedBy<FlickrInfrastructure>());

            container.Register(Component.For<FlickrNet.Flickr>().LifeStyle.Is(LifestyleType.PerWebRequest));

        }
    }
}
