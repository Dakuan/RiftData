﻿ALTER TABLE [dbo].[Fish]
    ADD CONSTRAINT [FK_Fish_Species] FOREIGN KEY ([FishSpeciesID]) REFERENCES [dbo].[Species] ([SpeciesID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

