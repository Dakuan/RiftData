﻿ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [PK_Species] PRIMARY KEY CLUSTERED ([SpeciesID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);
