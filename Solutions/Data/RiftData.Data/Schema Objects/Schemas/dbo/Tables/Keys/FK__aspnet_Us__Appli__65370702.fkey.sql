ALTER TABLE [dbo].[aspnet_Users]
    ADD CONSTRAINT [FK__aspnet_Us__Appli__65370702] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

