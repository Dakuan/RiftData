﻿ALTER TABLE [dbo].[FishPhotos]
    ADD CONSTRAINT [FK_FishPhotos_Photos] FOREIGN KEY ([PhotoID]) REFERENCES [dbo].[Photos] ([PhotoID]) ON DELETE CASCADE ON UPDATE NO ACTION;

