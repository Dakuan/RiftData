CREATE TABLE [dbo].[Lakes] (
    [LakeID]   INT           IDENTITY (1, 1) NOT NULL,
    [LakeName] NVARCHAR (50) NOT NULL,
	[LakeDescription] NVARCHAR(4000) NULL
);