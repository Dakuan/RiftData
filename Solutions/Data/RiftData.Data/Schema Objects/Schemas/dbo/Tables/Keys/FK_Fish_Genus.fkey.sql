﻿ALTER TABLE [dbo].[Fish]
    ADD CONSTRAINT [FK_Fish_Genus] FOREIGN KEY ([FishGenusID]) REFERENCES [dbo].[Genus] ([GenusID]) ON DELETE NO ACTION ON UPDATE NO ACTION;
