CREATE TABLE [dbo].[DiscountTargetType] (
    [DiscountTargetTypeId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]                 VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_DiscountTargetType] PRIMARY KEY CLUSTERED ([DiscountTargetTypeId] ASC)
);

