-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION CountSpeciesFish
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FishCount int

	-- Add the T-SQL statements to compute the return value here
	SELECT @FishCount =  COUNT(*)
	FROM         Fish INNER JOIN
						  Species ON Fish.FishSpeciesID = Species.SpeciesID
	WHERE     (Species.SpeciesID = 2)

	-- Return the result of the function
	RETURN @FishCount

END
