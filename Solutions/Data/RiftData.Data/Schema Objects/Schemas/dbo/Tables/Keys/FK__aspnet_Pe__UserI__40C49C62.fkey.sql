ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
    ADD CONSTRAINT [FK__aspnet_Pe__UserI__40C49C62] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

