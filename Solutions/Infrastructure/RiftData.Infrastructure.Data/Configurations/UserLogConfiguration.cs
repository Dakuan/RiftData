namespace RiftData.Infrastructure.Data.Configurations
{
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.ModelConfiguration;

    using RiftData.Domain.Logs;

    public class UserLogConfiguration : EntityTypeConfiguration<UserLog>
    {
        public UserLogConfiguration()
        {
            this.HasKey(k => k.Id);

            Property(p => p.Id).IsRequired().HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).HasColumnName("UserLogID");

            Property(p => p.Date).IsRequired().HasColumnName("UserLogDate");

            Property(p => p.UserName).IsRequired().HasColumnName("UserLogUserName");

            Property(p => p.Message).IsRequired().HasColumnName("UserLogMessage");

            this.ToTable("UserLogs");
        }
    }
}