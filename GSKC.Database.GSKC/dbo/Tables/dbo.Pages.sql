CREATE TABLE [dbo].[Pages] (
    [PageID]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (255)  NULL,
    [ParentID]        INT            NULL,
    [Link]            VARCHAR (255)  NULL,
    [OrderID]         INT            NULL,
    [Show]            INT            NULL,
    [Title]           VARCHAR (255)  NULL,
    [MetaDescription] VARCHAR (1000) NULL,
    CONSTRAINT [PK__Pages] PRIMARY KEY CLUSTERED ([PageID] ASC)
);

