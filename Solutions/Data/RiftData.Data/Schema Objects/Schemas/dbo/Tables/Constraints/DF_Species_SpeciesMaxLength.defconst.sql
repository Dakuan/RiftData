ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesMaxLength] DEFAULT ((0)) FOR [SpeciesMaxSize];

