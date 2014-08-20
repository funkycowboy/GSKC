CREATE TABLE [dbo].[Customer] (
    [CustomerID]          INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]           VARCHAR (100) NOT NULL,
    [LastName]            VARCHAR (100) NOT NULL,
    [Address1]            VARCHAR (255) NOT NULL,
    [Address2]            VARCHAR (50)  NULL,
    [City]                VARCHAR (50)  NOT NULL,
    [State]               CHAR (10)     NOT NULL,
    [ZipCode]             CHAR (5)      NOT NULL,
    [Zip4]                CHAR (4)      NULL,
    [EmailAddress]        VARCHAR (255) NOT NULL,
    [PayPalPayerId]       VARCHAR (25)  NOT NULL,
    [PayPalPayerStatus]   VARCHAR (25)  NULL,
    [PayPalAddressStatus] VARCHAR (25)  NULL,
    [DateEntered]         SMALLDATETIME CONSTRAINT [DF_Customer_DateEntered] DEFAULT (getdate()) NOT NULL,
    [EnteredByUserID]     INT           CONSTRAINT [DF_Customer_EnteredByUserID] DEFAULT ((1)) NOT NULL,
    [DateUpdated]         SMALLDATETIME NULL,
    [UpdatedByUserID]     INT           NULL,
    [Status]              INT           CONSTRAINT [DF_Customer_Status] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);

