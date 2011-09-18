ALTER TABLE [dbo].[SpeciesArticles]
    ADD CONSTRAINT [FK_SpeciesArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

