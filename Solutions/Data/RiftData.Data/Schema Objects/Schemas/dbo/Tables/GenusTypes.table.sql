CREATE TABLE [dbo].[GenusTypes] (
    [GenusTypeID]          INT             IDENTITY (1, 1) NOT NULL,
    [GenusTypeName]        NVARCHAR (255)  NOT NULL,
    [GenusTypeLakeID]      INT             NOT NULL,
    [GenusTypeDescription] NVARCHAR (1000) NULL
);

