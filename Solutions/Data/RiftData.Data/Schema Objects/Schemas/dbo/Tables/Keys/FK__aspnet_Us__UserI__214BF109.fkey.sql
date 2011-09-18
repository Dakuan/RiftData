ALTER TABLE [dbo].[aspnet_UsersInRoles]
    ADD CONSTRAINT [FK__aspnet_Us__UserI__214BF109] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

