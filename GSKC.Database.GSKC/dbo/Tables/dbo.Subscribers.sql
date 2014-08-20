CREATE TABLE [dbo].[Subscribers] (
    [SubscriberID] INT           IDENTITY (1, 1) NOT NULL,
    [EmailAddress] VARCHAR (255) NULL,
    [DateEntered]  SMALLDATETIME DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__Subscribers] PRIMARY KEY CLUSTERED ([SubscriberID] ASC)
);

