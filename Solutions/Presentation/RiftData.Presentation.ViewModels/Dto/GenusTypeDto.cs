namespace RiftData.Presentation.ViewModels.Dto
{
    public class GenusTypeDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool HasDescription { get { return !string.IsNullOrEmpty(this.Description); } }
    }
}