-- =============================================
-- Author:		Aaron Gatlin
-- Create date: 02/20/2013
-- Description:	Get Product by ProductID (include Promo Pricing)
-- =============================================
CREATE PROCEDURE [dbo].[spGetProduct] 
	@ProductID INT,
	@GiftCode VARCHAR(10) = NULL
AS
BEGIN

	/*
	EXEC [spGetProduct] 320029, 'GSMULTDS01'
	EXEC [spGetProduct] 320008, 'GSMULTDS01'
	*/

	SET NOCOUNT ON;

	DECLARE @ProductDiscountAmount DECIMAL(9,2),@ShippingDiscountAmount DECIMAL(9,2)
	DECLARE @ProductPriceAfterDiscount MONEY, @ShippingCostAfterDiscount MONEY
	DECLARE @DiscountAmount INT, @DiscountType VARCHAR(50), @DiscountTargetId INT, @DiscountTargetType VARCHAR(50)

	CREATE TABLE #Discounts(ID INT NOT NULL IDENTITY(1,1), PromoCodeDiscountId INT NULL, DiscountAmount INT NULL, DiscountTargetType VARCHAR(50) NULL, DiscountType VARCHAR(50) NULL, DiscountTargetId INT NULL)

	--Get All Product Discounts associated with Promocode
	INSERT INTO #Discounts(PromoCodeDiscountId,DiscountAmount,DiscountTargetType, DiscountType, DiscountTargetId)
	SELECT	pcd.PromoCodeDiscountId AS PromoCodeDiscountId,
			pcd.DiscountAmount AS DiscountAmount, 
			dtt.Name AS DiscountTargetType, 
			dt.Name AS DiscountType, 
			pcd.DiscountTargetId AS DiscountTargetId
	FROM	PromoCode  pc
			INNER JOIN PromoCodeDiscount pcd ON pc.PromoCodeId = pcd.PromoCodeId
			INNER JOIN DiscountTargetType dtt ON dtt.DiscountTargetTypeId = pcd.DiscountTargetTypeId
			INNER JOIN DiscountType dt ON dt.DiscountTypeId = pcd.DiscountTypeId
	WHERE	PromoCode = @GiftCode 
			AND CurrentUsage < MaxUsage			
			AND GETDATE() BETWEEN StartDate AND EndDate
			AND pc.[Status] = 1
			AND pcd.[Status] = 1	
			--AND pcd.DiscountTargetTypeId = 1 -- [Options: Product (1), Shipping (2), Order (3)]
			AND pc.PromoCode = @GiftCode
			AND (DiscountTargetId = @ProductID OR DiscountTargetId IS NULL)	
	
	CREATE TABLE #DiscountDetail(ID INT NOT NULL IDENTITY(1,1), DiscountTargetType VARCHAR(50) NULL, DiscountTargetId INT NULL, ProductDiscountAmount INT NULL, ShippingDiscountAmount INT NULL, DiscountType VARCHAR(50) NULL)		

	INSERT INTO	#DiscountDetail(DiscountTargetType, DiscountTargetId, ProductDiscountAmount,ShippingDiscountAmount, DiscountType)			
	SELECT	d.DiscountTargetType,
			d.DiscountTargetId,
			(CASE d.DiscountTargetType
			WHEN 'Product'  THEN 
				(CASE d.DiscountType
					WHEN 'Percentage'  THEN (d.DiscountAmount)
					WHEN 'Flat Amount' THEN (d.DiscountAmount)
				END)
			END) AS ProductDiscountAmount,			
			(CASE d.DiscountTargetType
			WHEN 'Shipping'  THEN 
				(CASE d.DiscountType
					WHEN 'Percentage'  THEN (d.DiscountAmount)
					WHEN 'Flat Amount' THEN (d.DiscountAmount)
				END)															
			END) AS ShippingDiscountAmount,			
			d.DiscountType AS DiscountType	
	FROM	#Discounts d
			INNER JOIN 
				(SELECT	* 
				FROM	PRODUCT 
				WHERE	(@DiscountTargetId = ProductID AND ProductID = @DiscountTargetId)
						OR (@DiscountTargetId IS NULL AND ProductID = @ProductID)) p
				ON d.DiscountTargetId = p.ProductID OR @ProductID = p.ProductID

	--SELECT * FROM #DiscountDetail
	--Get Product Information
	SELECT	p.name AS ProductName,
			p.ProductID as ProductID,
			p.SKU as SKU,
			p.ItemNumber AS ItemNumber,
			p.[Description] AS ProductDescription,
			p.[Features] AS ProductFeatures,
			p.Specifications AS ProductSpecifications,
			p.RetailCost AS RetailPrice,
			p.DealerCost AS DealerCost,
			p.MsrpCost AS MSRPPrice,
			p.ShippingCost AS ShippingCost,
			p.ManufacturerID AS ManufacturerID,
			m.Name AS ManufacturerName,
			p.CategoryID AS ProductCategoryID,
			pc.Name AS ProductCategoryName,
			p.SectionID AS ProductSectionID,
			p.Inventory AS Inventory,
			p.[Weight] AS ProductWeight,
			s.ProductImageURL AS ProductImageURL,
			(SELECT	 ProductDiscountAmount FROM #DiscountDetail WHERE DiscountTargetType = 'Product') AS ProductDiscountAmount,
			(SELECT  DiscountType FROM #DiscountDetail WHERE DiscountTargetType = 'Product') AS ProductDiscountType,
			(SELECT  ShippingDiscountAmount FROM #DiscountDetail WHERE DiscountTargetType = 'Shipping') AS ShippingDiscountAmount,
			(SELECT  DiscountType FROM #DiscountDetail WHERE DiscountTargetType = 'Shipping') AS ShippingDiscountType
			
	FROM	Product p
			INNER JOIN Manufacturers m ON p.manufacturerid = m.manufacturerid 
			INNER JOIN ProductCategory pc ON p.CategoryID = pc.ProductCategoryID 
			INNER JOIN Supplier s ON s.SupplierID = p.SupplierID 
	WHERE	p.ProductID = @ProductID;
			 
END


