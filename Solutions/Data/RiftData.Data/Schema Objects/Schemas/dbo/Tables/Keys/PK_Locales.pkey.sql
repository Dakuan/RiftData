﻿ALTER TABLE [dbo].[Locales]
    ADD CONSTRAINT [PK_Locales] PRIMARY KEY CLUSTERED ([LocaleID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

