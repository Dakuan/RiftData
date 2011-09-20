CREATE TABLE [dbo].[Locales] (
    [LocaleID]          INT             IDENTITY (1, 1) NOT NULL,
    [LocaleLatitude]    FLOAT           NOT NULL,
    [LocaleLongitude]   FLOAT           NOT NULL,
    [LocaleName]        NVARCHAR (255)  NOT NULL,
    [LocaleZoomLevel]   INT             NOT NULL,
    [LocaleLakeID]      INT             NOT NULL,
    [LocaleDescription] NVARCHAR (4000) NULL
);

