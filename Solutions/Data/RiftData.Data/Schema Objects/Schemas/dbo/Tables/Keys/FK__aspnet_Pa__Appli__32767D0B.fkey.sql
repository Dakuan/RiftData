ALTER TABLE [dbo].[aspnet_Paths]
    ADD CONSTRAINT [FK__aspnet_Pa__Appli__32767D0B] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

