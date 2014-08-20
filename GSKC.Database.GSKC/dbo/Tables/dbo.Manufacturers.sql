CREATE TABLE [dbo].[Manufacturers] (
    [ManufacturerID]  INT           IDENTITY (1, 1) NOT NULL,
    [Code]            VARCHAR (50)  NULL,
    [Name]            VARCHAR (255) NULL,
    [DateEntered]     SMALLDATETIME CONSTRAINT [DF__Manufactu__DateE__00551192] DEFAULT (getdate()) NULL,
    [EnteredByUserID] INT           NULL,
    [DateUpdated]     SMALLDATETIME NULL,
    [UpdatedByUserID] INT           NULL,
    [IsActive]        BIT           CONSTRAINT [DF__Manufactu__IsAct__014935CB] DEFAULT ((1)) NOT NULL,
    [Filename]        VARCHAR (255) NULL,
    CONSTRAINT [PK__Manufacturers] PRIMARY KEY CLUSTERED ([ManufacturerID] ASC)
);

