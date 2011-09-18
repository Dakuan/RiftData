ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [FK_Species_Temperaments] FOREIGN KEY ([SpeciesTemperamentID]) REFERENCES [dbo].[Temperaments] ([TemperamentID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

