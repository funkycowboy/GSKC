-- ================================
-- Created 
--    by: Aaron Gatlin
--    on: Tuesday, January 20, 2009 6:16 PM
-- Description: Update images into Lookup_Image
-- ================================
CREATE PROCEDURE [dbo].[Lookup_Image_Upd] 

   @FileName VARCHAR(50), 
   @Title VARCHAR(50), 
   @UserID INT

AS

BEGIN

  UPDATE	Lookup_Image
  SET		Title = @Title
  WHERE	UserID = @UserID
	AND Filename = @FileName
			

END