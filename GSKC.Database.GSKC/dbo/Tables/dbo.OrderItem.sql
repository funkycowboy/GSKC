CREATE TABLE [dbo].[OrderItem] (
    [OrderItemID]     INT   IDENTITY (1, 1) NOT NULL,
    [OrderID]         INT   NOT NULL,
    [ProductID]       INT   NOT NULL,
    [Quantity]        INT   NOT NULL,
    [TaxAmount]       MONEY NULL,
    [ShippingAmount]  MONEY NULL,
    [UnitPriceAmount] MONEY NOT NULL,
    [Status]          INT   CONSTRAINT [DF_OrderItem_Status] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED ([OrderItemID] ASC),
    CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderID])
);

