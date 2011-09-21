namespace RiftData.Presentation.ViewModels.Admin
{
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;

    public class LogOnModel
    {
        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Password")]
        public string Password { get; set; }

        [DisplayName("Remember me?")]
        public bool RememberMe { get; set; }

        [Required]
        [DisplayName("User name")]
        public string UserName { get; set; }
    }
}