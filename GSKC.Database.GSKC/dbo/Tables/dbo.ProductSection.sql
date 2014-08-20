CREATE TABLE [dbo].[ProductSection] (
    [ProductSectionID] INT           IDENTITY (1, 1) NOT NULL,
    [Code]             VARCHAR (50)  NULL,
    [Name]             VARCHAR (255) NULL,
    [IsActive]         BIT           CONSTRAINT [DF_ProductSection_IsActive] DEFAULT ((1)) NULL,
    [EnteredByUserID]  INT           NULL,
    [DateEntered]      SMALLDATETIME CONSTRAINT [DF_ProductSection_DateEntered] DEFAULT (getdate()) NULL,
    [UpdatedByUserId]  INT           NULL,
    [DateUpdated]      SMALLDATETIME NULL,
    CONSTRAINT [PK_ProductSection] PRIMARY KEY CLUSTERED ([ProductSectionID] ASC)
);

