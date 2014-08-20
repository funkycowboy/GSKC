CREATE TABLE [dbo].[Contacts] (
    [ContactID]       INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]       VARCHAR (50)   NULL,
    [LastName]        VARCHAR (50)   NULL,
    [PhoneNumber]     CHAR (13)      NULL,
    [EmailAddress]    VARCHAR (255)  NULL,
    [Comments]        VARCHAR (4000) NULL,
    [DateEntered]     SMALLDATETIME  NULL,
    [EnteredByUserID] INT            NULL,
    [DateUpdated]     SMALLDATETIME  NULL,
    [UpdatedByUserID] INT            NULL,
    CONSTRAINT [PK__Contacts] PRIMARY KEY CLUSTERED ([ContactID] ASC),
    CONSTRAINT [FK_Contacts.EnteredByUserID_Users.UserID] FOREIGN KEY ([EnteredByUserID]) REFERENCES [dbo].[Users] ([UserID]),
    CONSTRAINT [FK_Contacts.UpdatedByUserID_Users.UserID] FOREIGN KEY ([UpdatedByUserID]) REFERENCES [dbo].[Users] ([UserID])
);

