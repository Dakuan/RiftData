ALTER TABLE [dbo].[Locales]
    ADD CONSTRAINT [DF_Locales_LocaleLakeID] DEFAULT ((1)) FOR [LocaleLakeID];

