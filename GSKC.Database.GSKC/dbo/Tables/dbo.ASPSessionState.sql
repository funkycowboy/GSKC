CREATE TABLE [dbo].[ASPSessionState] (
    [ID]           INT           IDENTITY (1, 1) NOT NULL,
    [GUID]         CHAR (38)     NULL,
    [SessionKey]   VARCHAR (254) NULL,
    [SessionValue] VARCHAR (254) NULL,
    CONSTRAINT [PK_ASPSessionState] PRIMARY KEY CLUSTERED ([ID] ASC)
);

