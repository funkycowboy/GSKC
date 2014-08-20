CREATE TABLE [dbo].[Sites] (
    [SiteID]   INT           IDENTITY (1, 1) NOT NULL,
    [SiteName] VARCHAR (255) NULL,
    CONSTRAINT [PK__Sites] PRIMARY KEY CLUSTERED ([SiteID] ASC)
);

