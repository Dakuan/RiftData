-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION SpeciesHasFish
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SpeciesHasFish bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @SpeciesHasFish = (CONVERT([bit],case when dbo.CountSpeciesFish(@SpeciesId)>(0) then (1) else (0) end,0))

	-- Return the result of the function
	RETURN @SpeciesHasFish

END
