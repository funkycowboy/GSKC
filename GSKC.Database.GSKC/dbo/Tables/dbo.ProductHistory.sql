﻿CREATE TABLE [dbo].[ProductHistory] (
    [ProductID]          INT            NOT NULL,
    [Name]               VARCHAR (255)  NOT NULL,
    [Description]        VARCHAR (4000) NULL,
    [Features]           VARCHAR (4000) NULL,
    [RetailCost]         MONEY          NULL,
    [MsrpCost]           MONEY          NULL,
    [ShippingCost]       MONEY          NULL,
    [Filename]           VARCHAR (255)  NULL,
    [ManufacturerID]     INT            NULL,
    [DateEntered]        SMALLDATETIME  NULL,
    [EnteredByUserID]    INT            NULL,
    [DateUpdated]        SMALLDATETIME  NULL,
    [UpdatedByUserID]    INT            NULL,
    [IsActive]           BIT            NOT NULL,
    [IsFeatured]         BIT            NOT NULL,
    [WholCost]           MONEY          NULL,
    [Inventory]          INT            NULL,
    [ItemNumber]         VARCHAR (50)   NULL,
    [KnifeTypeID]        INT            NULL,
    [ProductHistoryID]   INT            IDENTITY (1, 1) NOT NULL,
    [TriggerCreatedDate] VARCHAR (50)   DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ProductHistory] PRIMARY KEY CLUSTERED ([ProductHistoryID] ASC)
);

