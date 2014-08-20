CREATE TABLE [dbo].[Manufacturers_Sync] (
    [ManufacturerID]  INT           NOT NULL,
    [Code]            VARCHAR (50)  NULL,
    [Name]            VARCHAR (255) NULL,
    [DateEntered]     SMALLDATETIME NULL,
    [EnteredByUserID] INT           NULL,
    [DateUpdated]     SMALLDATETIME NULL,
    [UpdatedByUserID] INT           NULL,
    [IsActive]        BIT           NOT NULL,
    [Filename]        VARCHAR (255) NULL
);

