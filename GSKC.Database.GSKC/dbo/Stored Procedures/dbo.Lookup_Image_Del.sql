-- ================================
-- Created 
--    by: Aaron Gatlin
--    on: Tuesday, March 20, 2009 11:17 PM
-- Description: Delete images from Lookup_Image
-- ================================
CREATE PROCEDURE [dbo].[Lookup_Image_Del] 

   @Filename VARCHAR(255)

AS

BEGIN

  DELETE
  FROM	Lookup_Image
  WHERE	[FileName] = @Filename
			

END