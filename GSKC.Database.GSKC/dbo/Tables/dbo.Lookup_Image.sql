CREATE TABLE [dbo].[Lookup_Image] (
    [ImageID]     SMALLINT     IDENTITY (1, 1) NOT NULL,
    [FileName]    VARCHAR (50) NOT NULL,
    [Title]       VARCHAR (50) NULL,
    [ClientID]    INT          NULL,
    [UserID]      INT          NOT NULL,
    [DateEntered] DATETIME     CONSTRAINT [DF__Lookup_Im__DateE__787EE5A0] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__Lookup_Image__75A278F5] PRIMARY KEY CLUSTERED ([ImageID] ASC),
    CONSTRAINT [FK_Lookup_Image_Client] FOREIGN KEY ([ClientID]) REFERENCES [dbo].[Client] ([ClientID])
);

