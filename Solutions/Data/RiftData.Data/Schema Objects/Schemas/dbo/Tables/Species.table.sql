CREATE TABLE [dbo].[Species] (
    [SpeciesID]            INT             IDENTITY (1, 1) NOT NULL,
    [SpeciesName]          NVARCHAR (255)  NOT NULL,
    [SpeciesGenusID]       INT             NOT NULL,
    [SpeciesDescribed]     BIT             NOT NULL,
    [SpeciesHasPhotos]     AS              ([dbo].[SpeciesHasPhoto]([SpeciesID])),
    [SpeciesHasFish]       AS              ([dbo].[SpeciesHasFish]([SpeciesID])),
    [SpeciesDescription]   NVARCHAR (1000) NULL,
    [SpeciesMinSize]       INT             NOT NULL,
    [SpeciesMaxSize]       INT             NOT NULL,
    [SpeciesTemperamentID] INT             NOT NULL
);

