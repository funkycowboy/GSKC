

--exec spGetProductRecords 0,20000,NULL,NULL,NULL,NULL,NULL,'',3
CREATE PROCEDURE [dbo].[spGetProductRecords]

@PageNumber INT, 
@PageLength INT, 
@SortColumn VARCHAR (255) = NULL, 
@RetailCostLow MONEY=NULL, 
@RetailCostHigh MONEY=NULL, 
@ManufacturerID VARCHAR(255)=NULL, 
@ProductCategoryID VARCHAR(255)=NULL, 
@KeywordSearch VARCHAR (255)='', 
@FilterBy INT=NULL

AS
SET NOCOUNT ON;

IF @SortColumn IS NOT NULL 
	
	BEGIN		

		;WITH cte AS
		(
			SELECT Row_Number() OVER (ORDER BY       
					CASE WHEN @SortColumn = 'ProductID DESC' THEN ProductID END DESC,    
					CASE WHEN @SortColumn = 'Name DESC' THEN p.Name END DESC,
					CASE WHEN @SortColumn = 'RetailCost DESC' THEN RetailCost END DESC,
					CASE WHEN @SortColumn = 'ProductID ASC' THEN ProductID END ASC,
					CASE WHEN @SortColumn = 'Name ASC' THEN p.Name END ASC,
					CASE WHEN @SortColumn = 'RetailCost ASC' THEN RetailCost END ASC  
					) AS RowNum,    
					ProductID AS CTEID,
					Count(*) OVER() AS TRowCount					

			FROM	Product p	
					outer apply(select * from fnSplitter(@KeywordSearch) where p.Name LIKE '%'+ Item +'%' OR p.[Description] LIKE '%'+ Item +'%' OR p.ItemNumber LIKE '%'+ Item +'%') sp			
			WHERE	p.RetailCost BETWEEN COALESCE(@RetailCostLow,p.RetailCost) AND COALESCE(@RetailCostHigh,p.RetailCost)			
					AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.ManufacturerID),','), CONCAT(',',COALESCE(@ManufacturerID,CONVERT(VARCHAR,p.ManufacturerID)),',')) > 0 
					AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.CategoryID),','), CONCAT(',',COALESCE(@ProductCategoryID,CONVERT(VARCHAR,p.CategoryID)),',')) > 0			  					
					AND p.IsActive = 1
					AND ((@KeywordSearch = '' AND sp.Item IS NULL) OR (@KeywordSearch <> '' AND sp.Item IS NOT NULL))	
					--TODO: Remove...not needed, replaced by line 45
					--AND (p.Name LIKE '%' + COALESCE(@KeywordSearch,p.Name) + '%'  
					--OR p.ItemNumber LIKE '%' + COALESCE(@KeywordSearch, p.ItemNumber) + '%'  
					--OR p.[Description] LIKE '%' + COALESCE(@KeywordSearch,p.[Description]) + '%' )
					AND (@FilterBy = 1
					OR (@FilterBy = 2 AND p.Inventory > 0)
					OR (@FilterBy = 3 AND p.Inventory = 0))       
			)		
							

			SELECT cte.TRowCount AS TotalRows, 
					cte.*, 
					p.*,
					s.ProductImageURL AS  ProductImageURL,
					m.Name AS ManufacturerName,
					pc.Name AS CategoryName
			FROM	cte 
					INNER JOIN Product p ON CTEID = p.ProductID
					INNER JOIN Supplier s ON s.SupplierID = p.SupplierID
					INNER JOIN Manufacturers m on p.ManufacturerID = m.ManufacturerID
					INNER JOIN ProductCategory pc on p.CategoryID = pc.ProductCategoryID
			WHERE	RowNum BETWEEN (((@PageNumber) * @PageLength) + 1 )
					AND (@PageNumber + 1)*@PageLength
			ORDER BY RowNum;			

		END
ELSE --@SortColumn IS NULL
		BEGIN
			
			CREATE TABLE #Temp2 (
				RowNum INT IDENTITY(1,1),
				ProductID BIGINT,
				TRowCount INT
			);

			INSERT INTO #Temp2 	
			SELECT	p.ProductID AS ProductID,
					Count(*) Over() AS TRowCount	
			FROM	Product p
					outer apply(select * from fnSplitter(@KeywordSearch) where p.Name LIKE '%'+ Item +'%' OR p.[Description] LIKE '%'+ Item +'%' OR p.ItemNumber LIKE '%'+ Item +'%') sp					
			WHERE	1 = 1
					AND p.RetailCost BETWEEN COALESCE(@RetailCostLow,p.RetailCost) AND COALESCE(@RetailCostHigh,p.RetailCost)					
					AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.ManufacturerID),','), CONCAT(',',COALESCE(@ManufacturerID,CONVERT(VARCHAR,p.ManufacturerID)),',')) > 0
					AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.CategoryID),','), CONCAT(',',COALESCE(@ProductCategoryID,CONVERT(VARCHAR,p.CategoryID)),',')) > 0	  
					AND p.IsActive = 1
					AND ((@KeywordSearch = '' AND sp.Item IS NULL) OR (@KeywordSearch <> '' AND sp.Item IS NOT NULL))
					--TODO: Remove...not needed, replaced by line 84
					--AND (p.Name LIKE '%' + COALESCE(@KeywordSearch,p.Name) + '%'  
					--OR p.ItemNumber LIKE '%' + COALESCE(@KeywordSearch, p.ItemNumber) + '%'  
					--OR p.[Description] LIKE '%' + COALESCE(@KeywordSearch,p.[Description]) + '%' )
					AND (@FilterBy = 1
					OR (@FilterBy = 2 AND p.Inventory > 0)
					OR (@FilterBy = 3 AND p.Inventory = 0))	
						

			--INSERT INTO #Temp2 	
			--SELECT	p.ProductID AS ProductID,
			--		Count(*) Over() AS TRowCount							
			--FROM	Product p					
			--WHERE	p.SectionID <> 85
			--		AND p.RetailCost BETWEEN COALESCE(@RetailCostLow,p.RetailCost) AND COALESCE(@RetailCostHigh,p.RetailCost)					
			--		AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.ManufacturerID),','), CONCAT(',',COALESCE(@ManufacturerID,CONVERT(VARCHAR,p.ManufacturerID)),',')) > 0					
			--		AND CHARINDEX(CONCAT(',', CONVERT(VARCHAR,p.CategoryID),','), CONCAT(',',COALESCE(@ProductCategoryID,CONVERT(VARCHAR,p.CategoryID)),',')) > 0	    
			--		AND (p.Name LIKE '%' + COALESCE(@KeywordSearch,p.Name) + '%'  
			--		OR p.ItemNumber LIKE '%' + COALESCE(@KeywordSearch, p.ItemNumber) + '%'  
			--		OR p.[Description] LIKE '%' + COALESCE(@KeywordSearch,p.[Description]) + '%' )
			--		AND (@FilterBy = 1
			--		OR (@FilterBy = 2 AND p.Inventory > 0)
			--		OR (@FilterBy = 3 AND p.Inventory = 0))
			
			SELECT	t.TRowCount AS TotalRows, 
					t.*, 
					p.*,
					s.ProductImageURL AS  ProductImageURL,
					pc.Name AS CategoryName,
					m.Name AS ManufacturerName
			FROM	#Temp2 t
					INNER JOIN Product p ON t.ProductID = p.ProductID
					INNER JOIN ProductCategory pc on p.CategoryID = pc.ProductCategoryID
					INNER JOIN Manufacturers m on p.ManufacturerID = m.ManufacturerID
					INNER JOIN Supplier s ON s.SupplierID = p.SupplierID
			WHERE	RowNum BETWEEN (((@PageNumber) * @PageLength) + 1 )
					AND (@PageNumber + 1)*@PageLength
			ORDER BY RowNum;	
			
			DROP TABLE #Temp2;			      						

		END

	




