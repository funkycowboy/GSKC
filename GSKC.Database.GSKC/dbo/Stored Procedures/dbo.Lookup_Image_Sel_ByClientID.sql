-- ================================
-- Created 
--    by: Aaron Gatlin
--    on: Sunday, January 18, 2009 6:16 PM
-- Description: Select images from Lookup_Image by @ClientID
-- ================================
CREATE PROCEDURE [dbo].[Lookup_Image_Sel_ByClientID] 

	@ClientID int,
	@Row int,
	@TotalRows int

AS

BEGIN

	--DECLARE @Row int
	--DECLARE @TotalRows int
	--SET @Row = 2
	--SET @TotalRows = 25
	IF @Row = 0 and @TotalRows = 0
		BEGIN
			SELECT	*,
					(Select COUNT(DISTINCT FileName) FROM Lookup_Image WHERE ClientID = @ClientID) AS PhotoCount 
			FROM	Lookup_Image 
			WHERE	ClientID = @ClientID
		END
	ELSE
		BEGIN
			SELECT	*, (Select COUNT(DISTINCT FileName) FROM Lookup_Image WHERE ClientID = @ClientID) AS PhotoCount FROM 
					(
					SELECT	*, row_number() over(order by DateEntered ) AS RowNum
					FROM    Lookup_Image 
					WHERE	ClientID = @ClientID
					) As Records
				
			WHERE	RowNum BETWEEN ((@Row - 1) * @TotalRows + 1) AND (@Row * @TotalRows)
		END
	

END