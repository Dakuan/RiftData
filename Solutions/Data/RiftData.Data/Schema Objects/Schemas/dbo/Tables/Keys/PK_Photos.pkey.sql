﻿ALTER TABLE [dbo].[Photos]
    ADD CONSTRAINT [PK_Photos] PRIMARY KEY CLUSTERED ([PhotoID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

