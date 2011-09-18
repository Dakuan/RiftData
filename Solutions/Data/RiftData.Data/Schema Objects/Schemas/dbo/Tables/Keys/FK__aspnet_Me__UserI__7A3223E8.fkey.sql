ALTER TABLE [dbo].[aspnet_Membership]
    ADD CONSTRAINT [FK__aspnet_Me__UserI__7A3223E8] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

