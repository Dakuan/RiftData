-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION SpeciesHasPhoto
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HasPhotos bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @HasPhotos = (CONVERT([bit],case when dbo.CountSpeciesPhotos(@SpeciesID)>(0) then (1) else (0) end,0))
	-- Return the result of the function
	RETURN @HasPhotos
END
