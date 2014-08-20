CREATE TABLE [dbo].[PromoCodeDiscount] (
    [PromoCodeDiscountId]  INT           IDENTITY (1, 1) NOT NULL,
    [PromoCodeId]          INT           NOT NULL,
    [DiscountTypeId]       INT           NOT NULL,
    [DiscountAmount]       INT           NULL,
    [DiscountTargetId]     INT           NULL,
    [DiscountTargetTypeId] INT           NOT NULL,
    [Status]               INT           CONSTRAINT [DF_PromoCodeDiscount_Status] DEFAULT ((1)) NOT NULL,
    [DateEntered]          SMALLDATETIME CONSTRAINT [DF_PromoCodeDiscount_DateEntered] DEFAULT (getdate()) NOT NULL,
    [EnteredByUserId]      INT           NOT NULL,
    CONSTRAINT [PK_PromoCodeDiscount] PRIMARY KEY CLUSTERED ([PromoCodeDiscountId] ASC),
    CONSTRAINT [FK_PromoCodeDiscount_DiscountTargetType] FOREIGN KEY ([DiscountTargetTypeId]) REFERENCES [dbo].[DiscountTargetType] ([DiscountTargetTypeId]),
    CONSTRAINT [FK_PromoCodeDiscount_DiscountType] FOREIGN KEY ([DiscountTypeId]) REFERENCES [dbo].[DiscountType] ([DiscountTypeId]),
    CONSTRAINT [FK_PromoCodeDiscount_Product] FOREIGN KEY ([DiscountTargetId]) REFERENCES [dbo].[Product] ([ProductID]),
    CONSTRAINT [FK_PromoCodeDiscount_PromoCode] FOREIGN KEY ([PromoCodeId]) REFERENCES [dbo].[PromoCode] ([PromoCodeId]),
    CONSTRAINT [FK_PromoCodeDiscount_Status] FOREIGN KEY ([Status]) REFERENCES [dbo].[Status] ([StatusID]),
    CONSTRAINT [FK_PromoCodeDiscount_Users] FOREIGN KEY ([EnteredByUserId]) REFERENCES [dbo].[Users] ([UserID])
);

