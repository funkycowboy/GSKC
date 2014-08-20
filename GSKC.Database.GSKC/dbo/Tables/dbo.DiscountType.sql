CREATE TABLE [dbo].[DiscountType] (
    [DiscountTypeId]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (25)  NOT NULL,
    [Description]     VARCHAR (255) NOT NULL,
    [Status]          INT           NOT NULL,
    [DateEntered]     SMALLDATETIME CONSTRAINT [DF_DiscountType_DateEntered] DEFAULT (getdate()) NOT NULL,
    [EnteredByUserId] INT           NOT NULL,
    CONSTRAINT [PK_DiscountType] PRIMARY KEY CLUSTERED ([DiscountTypeId] ASC),
    CONSTRAINT [FK_DiscountType_Status] FOREIGN KEY ([Status]) REFERENCES [dbo].[Status] ([StatusID]),
    CONSTRAINT [FK_DiscountType_Users] FOREIGN KEY ([EnteredByUserId]) REFERENCES [dbo].[Users] ([UserID])
);

