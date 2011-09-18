-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CountSpeciesPhotos]
(
	-- Add the parameters for the function here
	@SpeciesID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PhotoCount int
	
	SELECT @PhotoCount = COUNT(*) 
	FROM         Fish INNER JOIN
                      FishPhotos ON Fish.FishID = FishPhotos.FishID INNER JOIN
                      Species ON Fish.FishSpeciesID = Species.SpeciesID
	WHERE SpeciesID = @SpeciesID

	-- Return the result of the function
	RETURN @PhotoCount

END
