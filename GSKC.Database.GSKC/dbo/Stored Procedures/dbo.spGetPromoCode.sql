-- =============================================
-- Author:		Aaron Gatlin
-- Create date: 02/19/2013
-- Description:	Get Discounts By PromoCode
-- =============================================
CREATE PROCEDURE [dbo].[spGetPromoCode] 
	@PromoCode VARCHAR(10)
AS
BEGIN

	--EXEC spGetPromoCode 'GSMULTDS01'

	SET NOCOUNT ON;

	SELECT	pcd.DiscountAmount, 
			dtt.Name AS DiscountTargetType, 
			dt.Name  AS DiscountType, 
			pcd.DiscountTargetId
	FROM	PromoCode  pc
			INNER JOIN PromoCodeDiscount pcd ON pc.PromoCodeId = pcd.PromoCodeId
			INNER JOIN DiscountTargetType dtt ON dtt.DiscountTargetTypeId = pcd.DiscountTargetTypeId
			INNER JOIN DiscountType dt ON dt.DiscountTypeId = pcd.DiscountTypeId
	WHERE	PromoCode = @PromoCode 
			AND CurrentUsage < MaxUsage			
			AND GETDATE() BETWEEN StartDate AND EndDate
			AND pc.[Status] = 1
			AND pcd.[Status] = 1;		
END


