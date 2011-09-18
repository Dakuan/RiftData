CREATE TABLE [dbo].[Genus] (
    [GenusID]          INT            IDENTITY (1, 1) NOT NULL,
    [GenusName]        NVARCHAR (255) NOT NULL,
    [GenusGenusTypeID] INT            NOT NULL
);

