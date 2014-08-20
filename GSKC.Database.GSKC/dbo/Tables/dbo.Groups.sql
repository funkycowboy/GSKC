CREATE TABLE [dbo].[Groups] (
    [GroupID]     INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NULL,
    [Description] VARCHAR (255) NULL,
    CONSTRAINT [PK__Groups] PRIMARY KEY CLUSTERED ([GroupID] ASC)
);

