ALTER TABLE [dbo].[FishArticles]
    ADD CONSTRAINT [FK_FishArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

