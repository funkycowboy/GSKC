CREATE TABLE [dbo].[PromoCode] (
    [PromoCodeId]     INT           IDENTITY (1, 1) NOT NULL,
    [PromoCode]       VARCHAR (10)  NOT NULL,
    [MaxUsage]        INT           NULL,
    [CurrentUsage]    INT           NULL,
    [StartDate]       SMALLDATETIME NOT NULL,
    [EndDate]         SMALLDATETIME NOT NULL,
    [Status]          INT           NOT NULL,
    [DateEntered]     SMALLDATETIME CONSTRAINT [DF_PromoCode_DateEntered] DEFAULT (getdate()) NOT NULL,
    [EnteredByUserId] INT           NOT NULL,
    CONSTRAINT [PK_PromoCode_1] PRIMARY KEY CLUSTERED ([PromoCodeId] ASC),
    CONSTRAINT [FK_PromoCode_Status] FOREIGN KEY ([Status]) REFERENCES [dbo].[Status] ([StatusID]),
    CONSTRAINT [FK_PromoCode_Users] FOREIGN KEY ([EnteredByUserId]) REFERENCES [dbo].[Users] ([UserID])
);

