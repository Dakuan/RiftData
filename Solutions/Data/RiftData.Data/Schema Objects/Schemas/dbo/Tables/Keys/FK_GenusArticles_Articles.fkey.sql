ALTER TABLE [dbo].[GenusArticles]
    ADD CONSTRAINT [FK_GenusArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

