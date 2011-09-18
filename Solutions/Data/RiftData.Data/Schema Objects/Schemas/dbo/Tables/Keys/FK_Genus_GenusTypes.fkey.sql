ALTER TABLE [dbo].[Genus]
    ADD CONSTRAINT [FK_Genus_GenusTypes] FOREIGN KEY ([GenusGenusTypeID]) REFERENCES [dbo].[GenusTypes] ([GenusTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

