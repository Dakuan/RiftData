ALTER TABLE [dbo].[Articles]
    ADD CONSTRAINT [FK_Articles_Authors] FOREIGN KEY ([ArticleAuthorID]) REFERENCES [dbo].[Authors] ([AuthorID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

