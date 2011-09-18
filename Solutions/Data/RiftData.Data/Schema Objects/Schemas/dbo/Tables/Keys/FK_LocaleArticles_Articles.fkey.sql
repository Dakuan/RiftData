ALTER TABLE [dbo].[LocaleArticles]
    ADD CONSTRAINT [FK_LocaleArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

