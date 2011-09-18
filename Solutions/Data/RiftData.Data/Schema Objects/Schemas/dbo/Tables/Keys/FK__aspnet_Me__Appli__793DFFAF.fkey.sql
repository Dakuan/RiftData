ALTER TABLE [dbo].[aspnet_Membership]
    ADD CONSTRAINT [FK__aspnet_Me__Appli__793DFFAF] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

