-- =============================================
-- Author:		Aaron Gatlin
-- Create date: 09/17/2013
-- Description:	Get Product Options by ProductID
-- =============================================
CREATE PROCEDURE [dbo].[spGetProductOptions] 
	@ProductID INT
AS
BEGIN

	SELECT	po.OptionName,
			po.OptionValueList
	FROM	ProductOption po
	WHERE	IsActive = 1
			AND ProductID = @ProductID;

END