CREATE TABLE [dbo].[Supplier] (
    [SupplierID]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (255) NOT NULL,
    [ProductImageURL] VARCHAR (255) NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);

