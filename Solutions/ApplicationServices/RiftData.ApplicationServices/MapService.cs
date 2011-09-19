namespace RiftData.ApplicationServices
{
    public class MapService : IMapService
    {
        public int GetDataZoomFromMapZoom(int mapZoom)
        {
            if (mapZoom <= 8)
            {
                return 1;
            }

            if (mapZoom == 9)
            {
                return 2;
            }

            if (mapZoom > 9 && mapZoom <= 11)
            {
                return 3;
            }

            if (mapZoom > 11)
            {
                return 4;
            }

            return 1;
        }
    }
}