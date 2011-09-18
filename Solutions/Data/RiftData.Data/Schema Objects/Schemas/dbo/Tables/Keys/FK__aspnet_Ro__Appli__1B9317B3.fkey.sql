ALTER TABLE [dbo].[aspnet_Roles]
    ADD CONSTRAINT [FK__aspnet_Ro__Appli__1B9317B3] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

