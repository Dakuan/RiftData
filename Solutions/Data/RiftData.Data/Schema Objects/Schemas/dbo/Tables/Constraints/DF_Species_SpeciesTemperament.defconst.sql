ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesTemperament] DEFAULT ((1)) FOR [SpeciesTemperamentID];

