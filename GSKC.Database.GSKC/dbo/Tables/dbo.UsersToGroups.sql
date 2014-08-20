CREATE TABLE [dbo].[UsersToGroups] (
    [UsersToGroupsID] INT IDENTITY (1, 1) NOT NULL,
    [GroupID]         INT NULL,
    [UserID]          INT NULL,
    CONSTRAINT [PK_UsersToGroups] PRIMARY KEY CLUSTERED ([UsersToGroupsID] ASC)
);

