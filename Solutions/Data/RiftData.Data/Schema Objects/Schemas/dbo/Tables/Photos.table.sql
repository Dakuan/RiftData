CREATE TABLE [dbo].[Photos] (
    [PhotoID]                 INT            IDENTITY (1, 1) NOT NULL,
    [PhotoFlickrID]           NVARCHAR (50)  NOT NULL,
    [PhotoCaption]            NVARCHAR (255) NULL,
	[PhotoTitle]					NVARCHAR(255) NULL,
    [PhotoSponsorID]          INT            NULL,
    [PhotoLargeUrl]           NVARCHAR (255) NOT NULL,
    [PhotoMediumUrl]          NVARCHAR (255) NOT NULL,
    [PhotoSmallUrl]           NVARCHAR (255) NOT NULL,
    [PhotoThumbnailUrl]       NVARCHAR (255) NOT NULL,
    [PhotoSquareThumbnailUrl] NVARCHAR (255) NOT NULL
);

