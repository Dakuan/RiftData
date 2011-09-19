namespace RiftData.Presentation.ViewModels.Dto
{
    public class GenusTypeDto
    {
        public string Description { get; set; }

        public bool HasDescription
        {
            get
            {
                return !string.IsNullOrEmpty(this.Description);
            }
        }

        public int Id { get; set; }

        public LakeDto Lake { get; set; }

        public string Name { get; set; }

        public int NumberOfGenera { get; set; }
    }
}