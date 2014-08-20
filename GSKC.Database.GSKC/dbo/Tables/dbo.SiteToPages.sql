CREATE TABLE [dbo].[SiteToPages] (
    [SitePageID] INT IDENTITY (1, 1) NOT NULL,
    [SiteID]     INT NULL,
    [PageID]     INT NULL,
    CONSTRAINT [PK__SiteToPages] PRIMARY KEY CLUSTERED ([SitePageID] ASC)
);

