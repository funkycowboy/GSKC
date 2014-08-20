CREATE TABLE [dbo].[Status] (
    [StatusID] INT          IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED ([StatusID] ASC)
);

