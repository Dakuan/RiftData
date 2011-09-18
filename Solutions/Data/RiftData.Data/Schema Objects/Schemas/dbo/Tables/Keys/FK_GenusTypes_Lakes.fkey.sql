ALTER TABLE [dbo].[GenusTypes]
    ADD CONSTRAINT [FK_GenusTypes_Lakes] FOREIGN KEY ([GenusTypeLakeID]) REFERENCES [dbo].[Lakes] ([LakeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

