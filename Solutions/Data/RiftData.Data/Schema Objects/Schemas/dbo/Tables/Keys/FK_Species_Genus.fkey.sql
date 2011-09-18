ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [FK_Species_Genus] FOREIGN KEY ([SpeciesGenusID]) REFERENCES [dbo].[Genus] ([GenusID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

