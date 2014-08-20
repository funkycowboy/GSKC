CREATE TABLE [dbo].[Users] (
    [UserID]        INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]     VARCHAR (255) NULL,
    [LastName]      VARCHAR (255) NULL,
    [StreetAddress] VARCHAR (255) NULL,
    [AptSuite]      VARCHAR (255) NULL,
    [City]          VARCHAR (255) NULL,
    [State]         CHAR (2)      NULL,
    [Zip]           VARCHAR (5)   NULL,
    [EmailAddress]  VARCHAR (255) NULL,
    [HomeNumber]    CHAR (13)     NULL,
    [CellNumber]    CHAR (13)     NULL,
    [WorkNumber]    CHAR (13)     NULL,
    [Birthday]      SMALLDATETIME NULL,
    [Username]      VARCHAR (10)  NULL,
    [Password]      VARCHAR (10)  NULL,
    [GroupID]       INT           NULL,
    CONSTRAINT [PK__Users] PRIMARY KEY CLUSTERED ([UserID] ASC)
);

