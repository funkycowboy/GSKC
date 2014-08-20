CREATE TABLE [dbo].[PagesToGroups] (
    [PageGroupID] INT IDENTITY (1, 1) NOT NULL,
    [PageID]      INT NULL,
    [GroupID]     INT NULL,
    CONSTRAINT [PK__PagesToGroups] PRIMARY KEY CLUSTERED ([PageGroupID] ASC)
);

