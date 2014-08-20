
-- ================================
-- Created 
--    by: Aaron Gatlin
--    on: Sunday, January 18, 2009 6:16 PM
-- Description: Insert images into Lookup_Image
-- ================================
CREATE PROCEDURE [dbo].[Lookup_Image_Ins] 

   @FileName VARCHAR(50), 
   @UserID INT,
   @ClientID INT

AS

BEGIN

	INSERT 
	INTO	Lookup_Image(
			FileName,
			UserID,
                                                                ClientID)
	VALUES(
			@FileName,
			@UserID,
                                                                @ClientID )
END