CREATE TABLE [dbo].[ProductOption] (
    [ProductOptionID] INT           IDENTITY (1, 1) NOT NULL,
    [ProductID]       INT           NULL,
    [OptionName]      VARCHAR (50)  NOT NULL,
    [OptionValueList] VARCHAR (255) NOT NULL,
    [IsActive]        BIT           CONSTRAINT [DF_ProductOption_IsActive] DEFAULT ((1)) NOT NULL
);

