ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesMinLength] DEFAULT ((0)) FOR [SpeciesMinSize];

