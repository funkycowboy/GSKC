CREATE TABLE [dbo].[ProductCategory] (
    [ProductCategoryID] INT           IDENTITY (1, 1) NOT NULL,
    [Code]              VARCHAR (50)  NULL,
    [Name]              VARCHAR (255) NULL,
    [IsActive]          BIT           CONSTRAINT [DF__KnifeType__IsAct__1367E606] DEFAULT ((1)) NOT NULL,
    [EnteredByUserId]   INT           NULL,
    [DateEntered]       SMALLDATETIME CONSTRAINT [DF_ProductCategory_DateEntered] DEFAULT (getdate()) NULL,
    [UpdatedByUserId]   INT           NULL,
    [DateUpdated]       SMALLDATETIME NULL,
    CONSTRAINT [PK__KnifeTypes] PRIMARY KEY CLUSTERED ([ProductCategoryID] ASC),
    CONSTRAINT [FK_ProductCategory_ProductCategory] FOREIGN KEY ([ProductCategoryID]) REFERENCES [dbo].[ProductCategory] ([ProductCategoryID])
);

