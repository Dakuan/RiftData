CREATE TABLE [dbo].[Fish] (
    [FishID]          INT             IDENTITY (1, 1) NOT NULL,
    [FishGenusID]     INT             NOT NULL,
    [FishSpeciesID]   INT             NOT NULL,
    [FishLocaleID]    INT             NOT NULL,
    [FishDescription] NVARCHAR (1000) NULL
);

