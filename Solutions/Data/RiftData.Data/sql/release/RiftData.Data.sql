/*
Deployment script for RiftData.Data
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "RiftData.Data"
:setvar DefaultDataPath "c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
USE [master]
GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL
    AND DATABASEPROPERTYEX(N'$(DatabaseName)','Status') <> N'ONLINE')
BEGIN
    RAISERROR(N'The state of the target database, %s, is not set to ONLINE. To deploy to this database, its state must be set to ONLINE.', 16, 127,N'$(DatabaseName)') WITH NOWAIT
    RETURN
END

GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [db3854], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', MAXSIZE = 10485760 KB, FILEGROWTH = 1024 KB)
    LOG ON (NAME = [db3854_log], FILENAME = '$(DefaultLogPath)$(DatabaseName)_log.LDF', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
EXECUTE sp_dbcmptlevel [$(DatabaseName)], 100;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
USE [$(DatabaseName)]
GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Creating [aspnet_Membership_BasicAccess]...';


GO
CREATE ROLE [aspnet_Membership_BasicAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Membership_FullAccess]...';


GO
CREATE ROLE [aspnet_Membership_FullAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Membership_ReportingAccess]...';


GO
CREATE ROLE [aspnet_Membership_ReportingAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Personalization_BasicAccess]...';


GO
CREATE ROLE [aspnet_Personalization_BasicAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Personalization_FullAccess]...';


GO
CREATE ROLE [aspnet_Personalization_FullAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Personalization_ReportingAccess]...';


GO
CREATE ROLE [aspnet_Personalization_ReportingAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Profile_BasicAccess]...';


GO
CREATE ROLE [aspnet_Profile_BasicAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Profile_FullAccess]...';


GO
CREATE ROLE [aspnet_Profile_FullAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Profile_ReportingAccess]...';


GO
CREATE ROLE [aspnet_Profile_ReportingAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Roles_BasicAccess]...';


GO
CREATE ROLE [aspnet_Roles_BasicAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Roles_FullAccess]...';


GO
CREATE ROLE [aspnet_Roles_FullAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_Roles_ReportingAccess]...';


GO
CREATE ROLE [aspnet_Roles_ReportingAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [aspnet_WebEvent_FullAccess]...';


GO
CREATE ROLE [aspnet_WebEvent_FullAccess]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Membership_BasicAccess', @membername = N'aspnet_Membership_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Membership_ReportingAccess', @membername = N'aspnet_Membership_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Personalization_BasicAccess', @membername = N'aspnet_Personalization_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Personalization_ReportingAccess', @membername = N'aspnet_Personalization_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Profile_BasicAccess', @membername = N'aspnet_Profile_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Profile_ReportingAccess', @membername = N'aspnet_Profile_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Roles_BasicAccess', @membername = N'aspnet_Roles_FullAccess';


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'aspnet_Roles_ReportingAccess', @membername = N'aspnet_Roles_FullAccess';


GO
PRINT N'Creating [aspnet_Membership_BasicAccess]...';


GO
CREATE SCHEMA [aspnet_Membership_BasicAccess]
    AUTHORIZATION [aspnet_Membership_BasicAccess];


GO
PRINT N'Creating [aspnet_Membership_FullAccess]...';


GO
CREATE SCHEMA [aspnet_Membership_FullAccess]
    AUTHORIZATION [aspnet_Membership_FullAccess];


GO
PRINT N'Creating [aspnet_Membership_ReportingAccess]...';


GO
CREATE SCHEMA [aspnet_Membership_ReportingAccess]
    AUTHORIZATION [aspnet_Membership_ReportingAccess];


GO
PRINT N'Creating [aspnet_Personalization_BasicAccess]...';


GO
CREATE SCHEMA [aspnet_Personalization_BasicAccess]
    AUTHORIZATION [aspnet_Personalization_BasicAccess];


GO
PRINT N'Creating [aspnet_Personalization_FullAccess]...';


GO
CREATE SCHEMA [aspnet_Personalization_FullAccess]
    AUTHORIZATION [aspnet_Personalization_FullAccess];


GO
PRINT N'Creating [aspnet_Personalization_ReportingAccess]...';


GO
CREATE SCHEMA [aspnet_Personalization_ReportingAccess]
    AUTHORIZATION [aspnet_Personalization_ReportingAccess];


GO
PRINT N'Creating [aspnet_Profile_BasicAccess]...';


GO
CREATE SCHEMA [aspnet_Profile_BasicAccess]
    AUTHORIZATION [aspnet_Profile_BasicAccess];


GO
PRINT N'Creating [aspnet_Profile_FullAccess]...';


GO
CREATE SCHEMA [aspnet_Profile_FullAccess]
    AUTHORIZATION [aspnet_Profile_FullAccess];


GO
PRINT N'Creating [aspnet_Profile_ReportingAccess]...';


GO
CREATE SCHEMA [aspnet_Profile_ReportingAccess]
    AUTHORIZATION [aspnet_Profile_ReportingAccess];


GO
PRINT N'Creating [aspnet_Roles_BasicAccess]...';


GO
CREATE SCHEMA [aspnet_Roles_BasicAccess]
    AUTHORIZATION [aspnet_Roles_BasicAccess];


GO
PRINT N'Creating [aspnet_Roles_FullAccess]...';


GO
CREATE SCHEMA [aspnet_Roles_FullAccess]
    AUTHORIZATION [aspnet_Roles_FullAccess];


GO
PRINT N'Creating [aspnet_Roles_ReportingAccess]...';


GO
CREATE SCHEMA [aspnet_Roles_ReportingAccess]
    AUTHORIZATION [aspnet_Roles_ReportingAccess];


GO
PRINT N'Creating [aspnet_WebEvent_FullAccess]...';


GO
CREATE SCHEMA [aspnet_WebEvent_FullAccess]
    AUTHORIZATION [aspnet_WebEvent_FullAccess];


GO
PRINT N'Creating [dbo].[Articles]...';


GO
CREATE TABLE [dbo].[Articles] (
    [ArticleID]       INT            NOT NULL,
    [ArticleTitle]    NVARCHAR (255) NOT NULL,
    [ArticleContent]  NVARCHAR (400) NOT NULL,
    [ArticleAuthorID] INT            NOT NULL
);


GO
PRINT N'Creating PK_Articles...';


GO
ALTER TABLE [dbo].[Articles]
    ADD CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED ([ArticleID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[aspnet_Applications]...';


GO
CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName]        NVARCHAR (256)   NOT NULL,
    [LoweredApplicationName] NVARCHAR (256)   NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER NOT NULL,
    [Description]            NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([ApplicationId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY],
    UNIQUE NONCLUSTERED ([LoweredApplicationName] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY],
    UNIQUE NONCLUSTERED ([ApplicationName] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[aspnet_Applications].[aspnet_Applications_Index]...';


GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index]
    ON [dbo].[aspnet_Applications]([LoweredApplicationName] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_Membership]...';


GO
CREATE TABLE [dbo].[aspnet_Membership] (
    [ApplicationId]                          UNIQUEIDENTIFIER NOT NULL,
    [UserId]                                 UNIQUEIDENTIFIER NOT NULL,
    [Password]                               NVARCHAR (128)   NOT NULL,
    [PasswordFormat]                         INT              NOT NULL,
    [PasswordSalt]                           NVARCHAR (128)   NOT NULL,
    [MobilePIN]                              NVARCHAR (16)    NULL,
    [Email]                                  NVARCHAR (256)   NULL,
    [LoweredEmail]                           NVARCHAR (256)   NULL,
    [PasswordQuestion]                       NVARCHAR (256)   NULL,
    [PasswordAnswer]                         NVARCHAR (128)   NULL,
    [IsApproved]                             BIT              NOT NULL,
    [IsLockedOut]                            BIT              NOT NULL,
    [CreateDate]                             DATETIME         NOT NULL,
    [LastLoginDate]                          DATETIME         NOT NULL,
    [LastPasswordChangedDate]                DATETIME         NOT NULL,
    [LastLockoutDate]                        DATETIME         NOT NULL,
    [FailedPasswordAttemptCount]             INT              NOT NULL,
    [FailedPasswordAttemptWindowStart]       DATETIME         NOT NULL,
    [FailedPasswordAnswerAttemptCount]       INT              NOT NULL,
    [FailedPasswordAnswerAttemptWindowStart] DATETIME         NOT NULL,
    [Comment]                                NTEXT            NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_Membership]', @OptionName = N'text in row', @OptionValue = N'3000';


GO
PRINT N'Creating [dbo].[aspnet_Membership].[aspnet_Membership_index]...';


GO
CREATE CLUSTERED INDEX [aspnet_Membership_index]
    ON [dbo].[aspnet_Membership]([ApplicationId] ASC, [LoweredEmail] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_Paths]...';


GO
CREATE TABLE [dbo].[aspnet_Paths] (
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    [PathId]        UNIQUEIDENTIFIER NOT NULL,
    [Path]          NVARCHAR (256)   NOT NULL,
    [LoweredPath]   NVARCHAR (256)   NOT NULL,
    PRIMARY KEY NONCLUSTERED ([PathId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[aspnet_Paths].[aspnet_Paths_index]...';


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index]
    ON [dbo].[aspnet_Paths]([ApplicationId] ASC, [LoweredPath] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAllUsers]...';


GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers] (
    [PathId]          UNIQUEIDENTIFIER NOT NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([PathId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationAllUsers]', @OptionName = N'text in row', @OptionValue = N'6000';


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser]...';


GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [PathId]          UNIQUEIDENTIFIER NULL,
    [UserId]          UNIQUEIDENTIFIER NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationPerUser]', @OptionName = N'text in row', @OptionValue = N'6000';


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser].[aspnet_PersonalizationPerUser_index1]...';


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1]
    ON [dbo].[aspnet_PersonalizationPerUser]([PathId] ASC, [UserId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser].[aspnet_PersonalizationPerUser_ncindex2]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2]
    ON [dbo].[aspnet_PersonalizationPerUser]([UserId] ASC, [PathId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];


GO
PRINT N'Creating [dbo].[aspnet_Profile]...';


GO
CREATE TABLE [dbo].[aspnet_Profile] (
    [UserId]               UNIQUEIDENTIFIER NOT NULL,
    [PropertyNames]        NTEXT            NOT NULL,
    [PropertyValuesString] NTEXT            NOT NULL,
    [PropertyValuesBinary] IMAGE            NOT NULL,
    [LastUpdatedDate]      DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_Profile]', @OptionName = N'text in row', @OptionValue = N'6000';


GO
PRINT N'Creating [dbo].[aspnet_Roles]...';


GO
CREATE TABLE [dbo].[aspnet_Roles] (
    [ApplicationId]   UNIQUEIDENTIFIER NOT NULL,
    [RoleId]          UNIQUEIDENTIFIER NOT NULL,
    [RoleName]        NVARCHAR (256)   NOT NULL,
    [LoweredRoleName] NVARCHAR (256)   NOT NULL,
    [Description]     NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([RoleId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[aspnet_Roles].[aspnet_Roles_index1]...';


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1]
    ON [dbo].[aspnet_Roles]([ApplicationId] ASC, [LoweredRoleName] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_SchemaVersions]...';


GO
CREATE TABLE [dbo].[aspnet_SchemaVersions] (
    [Feature]                 NVARCHAR (128) NOT NULL,
    [CompatibleSchemaVersion] NVARCHAR (128) NOT NULL,
    [IsCurrentVersion]        BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Feature] ASC, [CompatibleSchemaVersion] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[aspnet_Users]...';


GO
CREATE TABLE [dbo].[aspnet_Users] (
    [ApplicationId]    UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER NOT NULL,
    [UserName]         NVARCHAR (256)   NOT NULL,
    [LoweredUserName]  NVARCHAR (256)   NOT NULL,
    [MobileAlias]      NVARCHAR (16)    NULL,
    [IsAnonymous]      BIT              NOT NULL,
    [LastActivityDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[aspnet_Users].[aspnet_Users_Index]...';


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LoweredUserName] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0);


GO
PRINT N'Creating [dbo].[aspnet_Users].[aspnet_Users_Index2]...';


GO
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LastActivityDate] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles]...';


GO
CREATE TABLE [dbo].[aspnet_UsersInRoles] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles].[aspnet_UsersInRoles_index]...';


GO
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index]
    ON [dbo].[aspnet_UsersInRoles]([RoleId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];


GO
PRINT N'Creating [dbo].[aspnet_WebEvent_Events]...';


GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events] (
    [EventId]                CHAR (32)       NOT NULL,
    [EventTimeUtc]           DATETIME        NOT NULL,
    [EventTime]              DATETIME        NOT NULL,
    [EventType]              NVARCHAR (256)  NOT NULL,
    [EventSequence]          DECIMAL (19)    NOT NULL,
    [EventOccurrence]        DECIMAL (19)    NOT NULL,
    [EventCode]              INT             NOT NULL,
    [EventDetailCode]        INT             NOT NULL,
    [Message]                NVARCHAR (1024) NULL,
    [ApplicationPath]        NVARCHAR (256)  NULL,
    [ApplicationVirtualPath] NVARCHAR (256)  NULL,
    [MachineName]            NVARCHAR (256)  NOT NULL,
    [RequestUrl]             NVARCHAR (1024) NULL,
    [ExceptionType]          NVARCHAR (256)  NULL,
    [Details]                NTEXT           NULL,
    PRIMARY KEY CLUSTERED ([EventId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[Authors]...';


GO
CREATE TABLE [dbo].[Authors] (
    [AuthorID]      INT            NOT NULL,
    [AuthorName]    NVARCHAR (255) NOT NULL,
    [AuthorUrl]     NVARCHAR (255) NULL,
    [AuthorUrlText] NVARCHAR (255) NULL
);


GO
PRINT N'Creating PK_Authors...';


GO
ALTER TABLE [dbo].[Authors]
    ADD CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED ([AuthorID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[Fish]...';


GO
CREATE TABLE [dbo].[Fish] (
    [FishID]          INT             IDENTITY (1, 1) NOT NULL,
    [FishGenusID]     INT             NOT NULL,
    [FishSpeciesID]   INT             NOT NULL,
    [FishLocaleID]    INT             NOT NULL,
    [FishDescription] NVARCHAR (4000) NULL
);


GO
PRINT N'Creating PK_Fish...';


GO
ALTER TABLE [dbo].[Fish]
    ADD CONSTRAINT [PK_Fish] PRIMARY KEY CLUSTERED ([FishID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[FishArticles]...';


GO
CREATE TABLE [dbo].[FishArticles] (
    [FishID]    INT NOT NULL,
    [ArticleID] INT NOT NULL
);


GO
PRINT N'Creating [dbo].[FishPhotos]...';


GO
CREATE TABLE [dbo].[FishPhotos] (
    [PhotoID] INT NOT NULL,
    [FishID]  INT NOT NULL
);


GO
PRINT N'Creating [dbo].[Genus]...';


GO
CREATE TABLE [dbo].[Genus] (
    [GenusID]          INT            IDENTITY (1, 1) NOT NULL,
    [GenusName]        NVARCHAR (255) NOT NULL,
    [GenusGenusTypeID] INT            NOT NULL
);


GO
PRINT N'Creating PK_Genus...';


GO
ALTER TABLE [dbo].[Genus]
    ADD CONSTRAINT [PK_Genus] PRIMARY KEY CLUSTERED ([GenusID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[GenusArticles]...';


GO
CREATE TABLE [dbo].[GenusArticles] (
    [GenusID]   INT NOT NULL,
    [ArticleID] INT NOT NULL
);


GO
PRINT N'Creating [dbo].[GenusTypes]...';


GO
CREATE TABLE [dbo].[GenusTypes] (
    [GenusTypeID]          INT             IDENTITY (1, 1) NOT NULL,
    [GenusTypeName]        NVARCHAR (255)  NOT NULL,
    [GenusTypeLakeID]      INT             NOT NULL,
    [GenusTypeDescription] NVARCHAR (1000) NULL
);


GO
PRINT N'Creating PK_GenusTypes...';


GO
ALTER TABLE [dbo].[GenusTypes]
    ADD CONSTRAINT [PK_GenusTypes] PRIMARY KEY CLUSTERED ([GenusTypeID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[Lakes]...';


GO
CREATE TABLE [dbo].[Lakes] (
    [LakeID]          INT             IDENTITY (1, 1) NOT NULL,
    [LakeName]        NVARCHAR (50)   NOT NULL,
    [LakeDescription] NVARCHAR (4000) NULL
);


GO
PRINT N'Creating PK_Lakes...';


GO
ALTER TABLE [dbo].[Lakes]
    ADD CONSTRAINT [PK_Lakes] PRIMARY KEY CLUSTERED ([LakeID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[LocaleArticles]...';


GO
CREATE TABLE [dbo].[LocaleArticles] (
    [LocaleID]  INT NOT NULL,
    [ArticleID] INT NOT NULL
);


GO
PRINT N'Creating [dbo].[LocalePhotos]...';


GO
CREATE TABLE [dbo].[LocalePhotos] (
    [PhotoID]  INT NOT NULL,
    [LocaleID] INT NOT NULL
);


GO
PRINT N'Creating [dbo].[Locales]...';


GO
CREATE TABLE [dbo].[Locales] (
    [LocaleID]          INT             IDENTITY (1, 1) NOT NULL,
    [LocaleLatitude]    FLOAT           NOT NULL,
    [LocaleLongitude]   FLOAT           NOT NULL,
    [LocaleName]        NVARCHAR (255)  NOT NULL,
    [LocaleZoomLevel]   INT             NOT NULL,
    [LocaleLakeID]      INT             NOT NULL,
    [LocaleDescription] NVARCHAR (4000) NULL
);


GO
PRINT N'Creating PK_Locales...';


GO
ALTER TABLE [dbo].[Locales]
    ADD CONSTRAINT [PK_Locales] PRIMARY KEY CLUSTERED ([LocaleID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[Photos]...';


GO
CREATE TABLE [dbo].[Photos] (
    [PhotoID]                 INT            IDENTITY (1, 1) NOT NULL,
    [PhotoFlickrID]           NVARCHAR (50)  NOT NULL,
    [PhotoCaption]            NVARCHAR (255) NULL,
    [PhotoTitle]              NVARCHAR (255) NULL,
    [PhotoSponsorID]          INT            NULL,
    [PhotoLargeUrl]           NVARCHAR (255) NOT NULL,
    [PhotoMediumUrl]          NVARCHAR (255) NOT NULL,
    [PhotoSmallUrl]           NVARCHAR (255) NOT NULL,
    [PhotoThumbnailUrl]       NVARCHAR (255) NOT NULL,
    [PhotoSquareThumbnailUrl] NVARCHAR (255) NOT NULL
);


GO
PRINT N'Creating PK_Photos...';


GO
ALTER TABLE [dbo].[Photos]
    ADD CONSTRAINT [PK_Photos] PRIMARY KEY CLUSTERED ([PhotoID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[SpeciesArticles]...';


GO
CREATE TABLE [dbo].[SpeciesArticles] (
    [SpeciesID] INT NOT NULL,
    [ArticleID] INT NOT NULL
);


GO
PRINT N'Creating [dbo].[Sponsors]...';


GO
CREATE TABLE [dbo].[Sponsors] (
    [SponsorID]   INT            IDENTITY (1, 1) NOT NULL,
    [SponsorName] NVARCHAR (255) NOT NULL,
    [SponsorUrl]  NVARCHAR (255) NOT NULL
);


GO
PRINT N'Creating [dbo].[Temperaments]...';


GO
CREATE TABLE [dbo].[Temperaments] (
    [TemperamentID]       INT           IDENTITY (1, 1) NOT NULL,
    [TemperamentName]     NVARCHAR (50) NOT NULL,
    [TemperamentSeverity] INT           NOT NULL
);


GO
PRINT N'Creating PK_Temperaments...';


GO
ALTER TABLE [dbo].[Temperaments]
    ADD CONSTRAINT [PK_Temperaments] PRIMARY KEY CLUSTERED ([TemperamentID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [dbo].[UserLogs]...';


GO
CREATE TABLE [dbo].[UserLogs] (
    [UserLogID]       INT             IDENTITY (1, 1) NOT NULL,
    [UserLogDate]     DATETIME        NOT NULL,
    [UserLogUserName] NVARCHAR (50)   NOT NULL,
    [UserLogMessage]  NVARCHAR (1000) NOT NULL
);


GO
PRINT N'Creating PK_UserLogs...';


GO
ALTER TABLE [dbo].[UserLogs]
    ADD CONSTRAINT [PK_UserLogs] PRIMARY KEY CLUSTERED ([UserLogID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating On column: ApplicationId...';


GO
ALTER TABLE [dbo].[aspnet_Applications]
    ADD DEFAULT (newid()) FOR [ApplicationId];


GO
PRINT N'Creating On column: PasswordFormat...';


GO
ALTER TABLE [dbo].[aspnet_Membership]
    ADD DEFAULT ((0)) FOR [PasswordFormat];


GO
PRINT N'Creating On column: PathId...';


GO
ALTER TABLE [dbo].[aspnet_Paths]
    ADD DEFAULT (newid()) FOR [PathId];


GO
PRINT N'Creating On column: Id...';


GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
    ADD DEFAULT (newid()) FOR [Id];


GO
PRINT N'Creating On column: RoleId...';


GO
ALTER TABLE [dbo].[aspnet_Roles]
    ADD DEFAULT (newid()) FOR [RoleId];


GO
PRINT N'Creating On column: UserId...';


GO
ALTER TABLE [dbo].[aspnet_Users]
    ADD DEFAULT (newid()) FOR [UserId];


GO
PRINT N'Creating On column: MobileAlias...';


GO
ALTER TABLE [dbo].[aspnet_Users]
    ADD DEFAULT (NULL) FOR [MobileAlias];


GO
PRINT N'Creating On column: IsAnonymous...';


GO
ALTER TABLE [dbo].[aspnet_Users]
    ADD DEFAULT ((0)) FOR [IsAnonymous];


GO
PRINT N'Creating DF_GenusTypes_GenusTypeLakeID...';


GO
ALTER TABLE [dbo].[GenusTypes]
    ADD CONSTRAINT [DF_GenusTypes_GenusTypeLakeID] DEFAULT ((1)) FOR [GenusTypeLakeID];


GO
PRINT N'Creating DF_Locales_LocaleLakeID...';


GO
ALTER TABLE [dbo].[Locales]
    ADD CONSTRAINT [DF_Locales_LocaleLakeID] DEFAULT ((1)) FOR [LocaleLakeID];


GO
PRINT N'Creating FK_Articles_Authors...';


GO
ALTER TABLE [dbo].[Articles] WITH NOCHECK
    ADD CONSTRAINT [FK_Articles_Authors] FOREIGN KEY ([ArticleAuthorID]) REFERENCES [dbo].[Authors] ([AuthorID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Me__Appli__793DFFAF...';


GO
ALTER TABLE [dbo].[aspnet_Membership] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Me__Appli__793DFFAF] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Me__UserI__7A3223E8...';


GO
ALTER TABLE [dbo].[aspnet_Membership] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Me__UserI__7A3223E8] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Pa__Appli__32767D0B...';


GO
ALTER TABLE [dbo].[aspnet_Paths] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Pa__Appli__32767D0B] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: aspnet_PersonalizationAllUsers...';


GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] WITH NOCHECK
    ADD FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: aspnet_PersonalizationPerUser...';


GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] WITH NOCHECK
    ADD FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Pe__UserI__40C49C62...';


GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Pe__UserI__40C49C62] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Pr__UserI__10216507...';


GO
ALTER TABLE [dbo].[aspnet_Profile] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Pr__UserI__10216507] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Ro__Appli__1B9317B3...';


GO
ALTER TABLE [dbo].[aspnet_Roles] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Ro__Appli__1B9317B3] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Us__Appli__65370702...';


GO
ALTER TABLE [dbo].[aspnet_Users] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Us__Appli__65370702] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: aspnet_UsersInRoles...';


GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] WITH NOCHECK
    ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK__aspnet_Us__UserI__214BF109...';


GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] WITH NOCHECK
    ADD CONSTRAINT [FK__aspnet_Us__UserI__214BF109] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_Fish_Genus...';


GO
ALTER TABLE [dbo].[Fish] WITH NOCHECK
    ADD CONSTRAINT [FK_Fish_Genus] FOREIGN KEY ([FishGenusID]) REFERENCES [dbo].[Genus] ([GenusID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_Fish_Locales...';


GO
ALTER TABLE [dbo].[Fish] WITH NOCHECK
    ADD CONSTRAINT [FK_Fish_Locales] FOREIGN KEY ([FishLocaleID]) REFERENCES [dbo].[Locales] ([LocaleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FishArticles_Articles...';


GO
ALTER TABLE [dbo].[FishArticles] WITH NOCHECK
    ADD CONSTRAINT [FK_FishArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FishPhotos_Fish...';


GO
ALTER TABLE [dbo].[FishPhotos] WITH NOCHECK
    ADD CONSTRAINT [FK_FishPhotos_Fish] FOREIGN KEY ([FishID]) REFERENCES [dbo].[Fish] ([FishID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FishPhotos_Photos...';


GO
ALTER TABLE [dbo].[FishPhotos] WITH NOCHECK
    ADD CONSTRAINT [FK_FishPhotos_Photos] FOREIGN KEY ([PhotoID]) REFERENCES [dbo].[Photos] ([PhotoID]) ON DELETE CASCADE ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_Genus_GenusTypes...';


GO
ALTER TABLE [dbo].[Genus] WITH NOCHECK
    ADD CONSTRAINT [FK_Genus_GenusTypes] FOREIGN KEY ([GenusGenusTypeID]) REFERENCES [dbo].[GenusTypes] ([GenusTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_GenusArticles_Articles...';


GO
ALTER TABLE [dbo].[GenusArticles] WITH NOCHECK
    ADD CONSTRAINT [FK_GenusArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_GenusTypes_Lakes...';


GO
ALTER TABLE [dbo].[GenusTypes] WITH NOCHECK
    ADD CONSTRAINT [FK_GenusTypes_Lakes] FOREIGN KEY ([GenusTypeLakeID]) REFERENCES [dbo].[Lakes] ([LakeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_LocaleArticles_Articles...';


GO
ALTER TABLE [dbo].[LocaleArticles] WITH NOCHECK
    ADD CONSTRAINT [FK_LocaleArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_Locales_Lakes...';


GO
ALTER TABLE [dbo].[Locales] WITH NOCHECK
    ADD CONSTRAINT [FK_Locales_Lakes] FOREIGN KEY ([LocaleLakeID]) REFERENCES [dbo].[Lakes] ([LakeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_SpeciesArticles_Articles...';


GO
ALTER TABLE [dbo].[SpeciesArticles] WITH NOCHECK
    ADD CONSTRAINT [FK_SpeciesArticles_Articles] FOREIGN KEY ([ArticleID]) REFERENCES [dbo].[Articles] ([ArticleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating [dbo].[aspnet_AnyDataInTables]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE [dbo].aspnet_AnyDataInTables
    @TablesToCheck int
AS
BEGIN
    -- Check Membership table if (@TablesToCheck & 1) is set
    IF ((@TablesToCheck & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Membership))
        BEGIN
            SELECT N'aspnet_Membership'
            RETURN
        END
    END

    -- Check aspnet_Roles table if (@TablesToCheck & 2) is set
    IF ((@TablesToCheck & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Roles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 RoleId FROM dbo.aspnet_Roles))
        BEGIN
            SELECT N'aspnet_Roles'
            RETURN
        END
    END

    -- Check aspnet_Profile table if (@TablesToCheck & 4) is set
    IF ((@TablesToCheck & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Profile))
        BEGIN
            SELECT N'aspnet_Profile'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 8) is set
    IF ((@TablesToCheck & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_PersonalizationPerUser))
        BEGIN
            SELECT N'aspnet_PersonalizationPerUser'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 16) is set
    IF ((@TablesToCheck & 16) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'aspnet_WebEvent_LogEvent') AND (type = 'P'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 * FROM dbo.aspnet_WebEvent_Events))
        BEGIN
            SELECT N'aspnet_WebEvent_Events'
            RETURN
        END
    END

    -- Check aspnet_Users table if (@TablesToCheck & 1,2,4 & 8) are all set
    IF ((@TablesToCheck & 1) <> 0 AND
        (@TablesToCheck & 2) <> 0 AND
        (@TablesToCheck & 4) <> 0 AND
        (@TablesToCheck & 8) <> 0 AND
        (@TablesToCheck & 32) <> 0 AND
        (@TablesToCheck & 128) <> 0 AND
        (@TablesToCheck & 256) <> 0 AND
        (@TablesToCheck & 512) <> 0 AND
        (@TablesToCheck & 1024) <> 0)
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Users))
        BEGIN
            SELECT N'aspnet_Users'
            RETURN
        END
        IF (EXISTS(SELECT TOP 1 ApplicationId FROM dbo.aspnet_Applications))
        BEGIN
            SELECT N'aspnet_Applications'
            RETURN
        END
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Applications_CreateApplication]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_Applications_CreateApplication
    @ApplicationName      nvarchar(256),
    @ApplicationId        uniqueidentifier OUTPUT
AS
BEGIN
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName

    IF(@ApplicationId IS NULL)
    BEGIN
        DECLARE @TranStarted   bit
        SET @TranStarted = 0

        IF( @@TRANCOUNT = 0 )
        BEGIN
	        BEGIN TRANSACTION
	        SET @TranStarted = 1
        END
        ELSE
    	    SET @TranStarted = 0

        SELECT  @ApplicationId = ApplicationId
        FROM dbo.aspnet_Applications WITH (UPDLOCK, HOLDLOCK)
        WHERE LOWER(@ApplicationName) = LoweredApplicationName

        IF(@ApplicationId IS NULL)
        BEGIN
            SELECT  @ApplicationId = NEWID()
            INSERT  dbo.aspnet_Applications (ApplicationId, ApplicationName, LoweredApplicationName)
            VALUES  (@ApplicationId, @ApplicationName, LOWER(@ApplicationName))
        END


        IF( @TranStarted = 1 )
        BEGIN
            IF(@@ERROR = 0)
            BEGIN
	        SET @TranStarted = 0
	        COMMIT TRANSACTION
            END
            ELSE
            BEGIN
                SET @TranStarted = 0
                ROLLBACK TRANSACTION
            END
        END
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_CheckSchemaVersion]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_CheckSchemaVersion
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    IF (EXISTS( SELECT  *
                FROM    dbo.aspnet_SchemaVersions
                WHERE   Feature = LOWER( @Feature ) AND
                        CompatibleSchemaVersion = @CompatibleSchemaVersion ))
        RETURN 0

    RETURN 1
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_ChangePasswordQuestionAndAnswer
    @ApplicationName       nvarchar(256),
    @UserName              nvarchar(256),
    @NewPasswordQuestion   nvarchar(256),
    @NewPasswordAnswer     nvarchar(128)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Membership m, dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId
    IF (@UserId IS NULL)
    BEGIN
        RETURN(1)
    END

    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion, PasswordAnswer = @NewPasswordAnswer
    WHERE  UserId=@UserId
    RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_FindUsersByEmail]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_FindUsersByEmail
    @ApplicationName       nvarchar(256),
    @EmailToMatch          nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    IF( @EmailToMatch IS NULL )
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.Email IS NULL
            ORDER BY m.LoweredEmail
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
            ORDER BY m.LoweredEmail

    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_FindUsersByName]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_FindUsersByName
    @ApplicationName       nvarchar(256),
    @UserNameToMatch       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT u.UserId
        FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND u.LoweredUserName LIKE LOWER(@UserNameToMatch)
        ORDER BY u.UserName


    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetAllUsers]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetAllUsers
    @ApplicationName       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0


    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT u.UserId
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u
    WHERE  u.ApplicationId = @ApplicationId AND u.UserId = m.UserId
    ORDER BY u.UserName

    SELECT @TotalRecords = @@ROWCOUNT

    SELECT u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName
    RETURN @TotalRecords
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetNumberOfUsersOnline]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetNumberOfUsersOnline
    @ApplicationName            nvarchar(256),
    @MinutesSinceLastInActive   int,
    @CurrentTimeUtc             datetime
AS
BEGIN
    DECLARE @DateActive datetime
    SELECT  @DateActive = DATEADD(minute,  -(@MinutesSinceLastInActive), @CurrentTimeUtc)

    DECLARE @NumOnline int
    SELECT  @NumOnline = COUNT(*)
    FROM    dbo.aspnet_Users u(NOLOCK),
            dbo.aspnet_Applications a(NOLOCK),
            dbo.aspnet_Membership m(NOLOCK)
    WHERE   u.ApplicationId = a.ApplicationId                  AND
            LastActivityDate > @DateActive                     AND
            a.LoweredApplicationName = LOWER(@ApplicationName) AND
            u.UserId = m.UserId
    RETURN(@NumOnline)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetPassword]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetPassword
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @PasswordAnswer                 nvarchar(128) = NULL
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @PasswordFormat                         int
    DECLARE @Password                               nvarchar(128)
    DECLARE @passAns                                nvarchar(128)
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @Password = m.Password,
            @passAns = m.PasswordAnswer,
            @PasswordFormat = m.PasswordFormat,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    IF ( NOT( @PasswordAnswer IS NULL ) )
    BEGIN
        IF( ( @passAns IS NULL ) OR ( LOWER( @passAns ) <> LOWER( @PasswordAnswer ) ) )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
        ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    IF( @ErrorCode = 0 )
        SELECT @Password, @PasswordFormat

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetPasswordWithFormat]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetPasswordWithFormat
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @UpdateLastLoginActivityDate    bit,
    @CurrentTimeUtc                 datetime
AS
BEGIN
    DECLARE @IsLockedOut                        bit
    DECLARE @UserId                             uniqueidentifier
    DECLARE @Password                           nvarchar(128)
    DECLARE @PasswordSalt                       nvarchar(128)
    DECLARE @PasswordFormat                     int
    DECLARE @FailedPasswordAttemptCount         int
    DECLARE @FailedPasswordAnswerAttemptCount   int
    DECLARE @IsApproved                         bit
    DECLARE @LastActivityDate                   datetime
    DECLARE @LastLoginDate                      datetime

    SELECT  @UserId          = NULL

    SELECT  @UserId = u.UserId, @IsLockedOut = m.IsLockedOut, @Password=Password, @PasswordFormat=PasswordFormat,
            @PasswordSalt=PasswordSalt, @FailedPasswordAttemptCount=FailedPasswordAttemptCount,
		    @FailedPasswordAnswerAttemptCount=FailedPasswordAnswerAttemptCount, @IsApproved=IsApproved,
            @LastActivityDate = LastActivityDate, @LastLoginDate = LastLoginDate
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF (@UserId IS NULL)
        RETURN 1

    IF (@IsLockedOut = 1)
        RETURN 99

    SELECT   @Password, @PasswordFormat, @PasswordSalt, @FailedPasswordAttemptCount,
             @FailedPasswordAnswerAttemptCount, @IsApproved, @LastLoginDate, @LastActivityDate

    IF (@UpdateLastLoginActivityDate = 1 AND @IsApproved = 1)
    BEGIN
        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @CurrentTimeUtc
        WHERE   UserId = @UserId

        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @CurrentTimeUtc
        WHERE   @UserId = UserId
    END


    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetUserByEmail]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetUserByEmail
    @ApplicationName  nvarchar(256),
    @Email            nvarchar(256)
AS
BEGIN
    IF( @Email IS NULL )
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                m.LoweredEmail IS NULL
    ELSE
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                LOWER(@Email) = m.LoweredEmail

    IF (@@rowcount = 0)
        RETURN(1)
    RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetUserByName]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetUserByName
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier

    IF (@UpdateLastActivity = 1)
    BEGIN
        -- select user ID from aspnet_users table
        SELECT TOP 1 @UserId = u.UserId
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1

        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        WHERE    @UserId = UserId

        SELECT m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut, m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  @UserId = u.UserId AND u.UserId = m.UserId 
    END
    ELSE
    BEGIN
        SELECT TOP 1 m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut,m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1
    END

    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_GetUserByUserId]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_GetUserByUserId
    @UserId               uniqueidentifier,
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    IF ( @UpdateLastActivity = 1 )
    BEGIN
        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        FROM     dbo.aspnet_Users
        WHERE    @UserId = UserId

        IF ( @@ROWCOUNT = 0 ) -- User ID not found
            RETURN -1
    END

    SELECT  m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate, m.LastLoginDate, u.LastActivityDate,
            m.LastPasswordChangedDate, u.UserName, m.IsLockedOut,
            m.LastLockoutDate
    FROM    dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   @UserId = u.UserId AND u.UserId = m.UserId

    IF ( @@ROWCOUNT = 0 ) -- User ID not found
       RETURN -1

    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_ResetPassword]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_ResetPassword
    @ApplicationName             nvarchar(256),
    @UserName                    nvarchar(256),
    @NewPassword                 nvarchar(128),
    @MaxInvalidPasswordAttempts  int,
    @PasswordAttemptWindow       int,
    @PasswordSalt                nvarchar(128),
    @CurrentTimeUtc              datetime,
    @PasswordFormat              int = 0,
    @PasswordAnswer              nvarchar(128) = NULL
AS
BEGIN
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @UserId                                 uniqueidentifier
    SET     @UserId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    SELECT @IsLockedOut = IsLockedOut,
           @LastLockoutDate = LastLockoutDate,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = FailedPasswordAnswerAttemptWindowStart
    FROM dbo.aspnet_Membership WITH ( UPDLOCK )
    WHERE @UserId = UserId

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Membership
    SET    Password = @NewPassword,
           LastPasswordChangedDate = @CurrentTimeUtc,
           PasswordFormat = @PasswordFormat,
           PasswordSalt = @PasswordSalt
    WHERE  @UserId = UserId AND
           ( ( @PasswordAnswer IS NULL ) OR ( LOWER( PasswordAnswer ) = LOWER( @PasswordAnswer ) ) )

    IF ( @@ROWCOUNT = 0 )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
    ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

    IF( NOT ( @PasswordAnswer IS NULL ) )
    BEGIN
        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_SetPassword]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_SetPassword
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @NewPassword      nvarchar(128),
    @PasswordSalt     nvarchar(128),
    @CurrentTimeUtc   datetime,
    @PasswordFormat   int = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    UPDATE dbo.aspnet_Membership
    SET Password = @NewPassword, PasswordFormat = @PasswordFormat, PasswordSalt = @PasswordSalt,
        LastPasswordChangedDate = @CurrentTimeUtc
    WHERE @UserId = UserId
    RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_UnlockUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_UnlockUser
    @ApplicationName                         nvarchar(256),
    @UserName                                nvarchar(256)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
        RETURN 1

    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = 0,
        FailedPasswordAttemptCount = 0,
        FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        FailedPasswordAnswerAttemptCount = 0,
        FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        LastLockoutDate = CONVERT( datetime, '17540101', 112 )
    WHERE @UserId = UserId

    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_UpdateUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_UpdateUser
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @Email                nvarchar(256),
    @Comment              ntext,
    @IsApproved           bit,
    @LastLoginDate        datetime,
    @LastActivityDate     datetime,
    @UniqueEmail          int,
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId, @ApplicationId = a.ApplicationId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership WITH (UPDLOCK, HOLDLOCK)
                    WHERE ApplicationId = @ApplicationId  AND @UserId <> UserId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            RETURN(7)
        END
    END

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET
         LastActivityDate = @LastActivityDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET
         Email            = @Email,
         LoweredEmail     = LOWER(@Email),
         Comment          = @Comment,
         IsApproved       = @IsApproved,
         LastLoginDate    = @LastLoginDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN -1
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_UpdateUserInfo]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_UpdateUserInfo
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @IsPasswordCorrect              bit,
    @UpdateLastLoginActivityDate    bit,
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @LastLoginDate                  datetime,
    @LastActivityDate               datetime
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @IsApproved                             bit
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @IsApproved = m.IsApproved,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        GOTO Cleanup
    END

    IF( @IsPasswordCorrect = 0 )
    BEGIN
        IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart ) )
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = 1
        END
        ELSE
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1
        END

        BEGIN
            IF( @FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts )
            BEGIN
                SET @IsLockedOut = 1
                SET @LastLockoutDate = @CurrentTimeUtc
            END
        END
    END
    ELSE
    BEGIN
        IF( @FailedPasswordAttemptCount > 0 OR @FailedPasswordAnswerAttemptCount > 0 )
        BEGIN
            SET @FailedPasswordAttemptCount = 0
            SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @FailedPasswordAnswerAttemptCount = 0
            SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )
        END
    END

    IF( @UpdateLastLoginActivityDate = 1 )
    BEGIN
        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @LastActivityDate
        WHERE   @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END

        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @LastLoginDate
        WHERE   UserId = @UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END


    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
        FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
        FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
        FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
        FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE @UserId = UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Paths_CreatePath]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Paths_CreatePath
    @ApplicationId UNIQUEIDENTIFIER,
    @Path           NVARCHAR(256),
    @PathId         UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    BEGIN TRANSACTION
    IF (NOT EXISTS(SELECT * FROM dbo.aspnet_Paths WHERE LoweredPath = LOWER(@Path) AND ApplicationId = @ApplicationId))
    BEGIN
        INSERT dbo.aspnet_Paths (ApplicationId, Path, LoweredPath) VALUES (@ApplicationId, @Path, LOWER(@Path))
    END
    COMMIT TRANSACTION
    SELECT @PathId = PathId FROM dbo.aspnet_Paths WHERE LOWER(@Path) = LoweredPath AND ApplicationId = @ApplicationId
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Personalization_GetApplicationId]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Personalization_GetApplicationId (
    @ApplicationName NVARCHAR(256),
    @ApplicationId UNIQUEIDENTIFIER OUT)
AS
BEGIN
    SELECT @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAdministration_DeleteAllState]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAdministration_DeleteAllState (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Count int OUT)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        IF (@AllUsersScope = 1)
            DELETE FROM aspnet_PersonalizationAllUsers
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)
        ELSE
            DELETE FROM aspnet_PersonalizationPerUser
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)

        SELECT @Count = @@ROWCOUNT
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAdministration_FindState]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAdministration_FindState (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @PageIndex              INT,
    @PageSize               INT,
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound INT
    DECLARE @PageUpperBound INT
    DECLARE @TotalRecords   INT
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table to store the selected results
    CREATE TABLE #PageIndex (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ItemId UNIQUEIDENTIFIER
    )

    IF (@AllUsersScope = 1)
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT Paths.PathId
        FROM dbo.aspnet_Paths Paths,
             ((SELECT Paths.PathId
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND AllUsers.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT DISTINCT Paths.PathId
               FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND PerUser.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path,
               SharedDataPerPath.LastUpdatedDate,
               SharedDataPerPath.SharedDataLength,
               UserDataPerPath.UserDataLength,
               UserDataPerPath.UserCount
        FROM dbo.aspnet_Paths Paths,
             ((SELECT PageIndex.ItemId AS PathId,
                      AllUsers.LastUpdatedDate AS LastUpdatedDate,
                      DATALENGTH(AllUsers.PageSettings) AS SharedDataLength
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, #PageIndex PageIndex
               WHERE AllUsers.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT PageIndex.ItemId AS PathId,
                      SUM(DATALENGTH(PerUser.PageSettings)) AS UserDataLength,
                      COUNT(*) AS UserCount
               FROM aspnet_PersonalizationPerUser PerUser, #PageIndex PageIndex
               WHERE PerUser.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
               GROUP BY PageIndex.ItemId
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC
    END
    ELSE
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT PerUser.Id
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
        WHERE Paths.ApplicationId = @ApplicationId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
              AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
        ORDER BY Paths.Path ASC, Users.UserName ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path, PerUser.LastUpdatedDate, DATALENGTH(PerUser.PageSettings), Users.UserName, Users.LastActivityDate
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths, #PageIndex PageIndex
        WHERE PerUser.Id = PageIndex.ItemId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
        ORDER BY Paths.Path ASC, Users.UserName ASC
    END

    RETURN @TotalRecords
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAdministration_GetCountOfState]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAdministration_GetCountOfState (
    @Count int OUT,
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN

    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
        IF (@AllUsersScope = 1)
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND AllUsers.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
        ELSE
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND PerUser.UserId = Users.UserId
                  AND PerUser.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
                  AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
                  AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAdministration_ResetSharedState]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAdministration_ResetSharedState (
    @Count int OUT,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationAllUsers
        WHERE PathId IN
            (SELECT AllUsers.PathId
             FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
             WHERE Paths.ApplicationId = @ApplicationId
                   AND AllUsers.PathId = Paths.PathId
                   AND Paths.LoweredPath = LOWER(@Path))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAdministration_ResetUserState]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAdministration_ResetUserState (
    @Count                  int                 OUT,
    @ApplicationName        NVARCHAR(256),
    @InactiveSinceDate      DATETIME            = NULL,
    @UserName               NVARCHAR(256)       = NULL,
    @Path                   NVARCHAR(256)       = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser
        WHERE Id IN (SELECT PerUser.Id
                     FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
                     WHERE Paths.ApplicationId = @ApplicationId
                           AND PerUser.UserId = Users.UserId
                           AND PerUser.PathId = Paths.PathId
                           AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
                           AND (@UserName IS NULL OR Users.LoweredUserName = LOWER(@UserName))
                           AND (@Path IS NULL OR Paths.LoweredPath = LOWER(@Path)))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAllUsers_GetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationAllUsers p WHERE p.PathId = @PathId
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAllUsers_ResetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    DELETE FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId
    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationAllUsers_SetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationAllUsers SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationAllUsers(PathId, PageSettings, LastUpdatedDate) VALUES (@PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser_GetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationPerUser_GetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationPerUser p WHERE p.PathId = @PathId AND p.UserId = @UserId
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationPerUser_ResetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE PathId = @PathId AND UserId = @UserId
    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_DeleteInactiveProfiles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_DeleteInactiveProfiles
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT  0
        RETURN
    END

    DELETE
    FROM    dbo.aspnet_Profile
    WHERE   UserId IN
            (   SELECT  UserId
                FROM    dbo.aspnet_Users u
                WHERE   ApplicationId = @ApplicationId
                        AND (LastActivityDate <= @InactiveSinceDate)
                        AND (
                                (@ProfileAuthOptions = 2)
                             OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                             OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                            )
            )

    SELECT  @@ROWCOUNT
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_GetNumberOfInactiveProfiles
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT 0
        RETURN
    END

    SELECT  COUNT(*)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
    WHERE   ApplicationId = @ApplicationId
        AND u.UserId = p.UserId
        AND (LastActivityDate <= @InactiveSinceDate)
        AND (
                (@ProfileAuthOptions = 2)
                OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
            )
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_GetProfiles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_GetProfiles
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @PageIndex              int,
    @PageSize               int,
    @UserNameToMatch        nvarchar(256) = NULL,
    @InactiveSinceDate      datetime      = NULL
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT  u.UserId
        FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
        WHERE   ApplicationId = @ApplicationId
            AND u.UserId = p.UserId
            AND (@InactiveSinceDate IS NULL OR LastActivityDate <= @InactiveSinceDate)
            AND (     (@ProfileAuthOptions = 2)
                   OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                   OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                 )
            AND (@UserNameToMatch IS NULL OR LoweredUserName LIKE LOWER(@UserNameToMatch))
        ORDER BY UserName

    SELECT  u.UserName, u.IsAnonymous, u.LastActivityDate, p.LastUpdatedDate,
            DATALENGTH(p.PropertyNames) + DATALENGTH(p.PropertyValuesString) + DATALENGTH(p.PropertyValuesBinary)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p, #PageIndexForUsers i
    WHERE   u.UserId = p.UserId AND p.UserId = i.UserId AND i.IndexId >= @PageLowerBound AND i.IndexId <= @PageUpperBound

    SELECT COUNT(*)
    FROM   #PageIndexForUsers

    DROP TABLE #PageIndexForUsers
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_GetProperties]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_GetProperties
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)

    IF (@UserId IS NULL)
        RETURN
    SELECT TOP 1 PropertyNames, PropertyValuesString, PropertyValuesBinary
    FROM         dbo.aspnet_Profile
    WHERE        UserId = @UserId

    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    END
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_RegisterSchemaVersion]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_RegisterSchemaVersion
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128),
    @IsCurrentVersion          bit,
    @RemoveIncompatibleSchema  bit
AS
BEGIN
    IF( @RemoveIncompatibleSchema = 1 )
    BEGIN
        DELETE FROM dbo.aspnet_SchemaVersions WHERE Feature = LOWER( @Feature )
    END
    ELSE
    BEGIN
        IF( @IsCurrentVersion = 1 )
        BEGIN
            UPDATE dbo.aspnet_SchemaVersions
            SET IsCurrentVersion = 0
            WHERE Feature = LOWER( @Feature )
        END
    END

    INSERT  dbo.aspnet_SchemaVersions( Feature, CompatibleSchemaVersion, IsCurrentVersion )
    VALUES( LOWER( @Feature ), @CompatibleSchemaVersion, @IsCurrentVersion )
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Roles_CreateRole]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Roles_CreateRole
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS(SELECT RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId))
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    INSERT INTO dbo.aspnet_Roles
                (ApplicationId, RoleName, LoweredRoleName)
         VALUES (@ApplicationId, @RoleName, LOWER(@RoleName))

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Roles_DeleteRole]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Roles_DeleteRole
    @ApplicationName            nvarchar(256),
    @RoleName                   nvarchar(256),
    @DeleteOnlyIfRoleIsEmpty    bit
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    DECLARE @RoleId   uniqueidentifier
    SELECT  @RoleId = NULL
    SELECT  @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
    BEGIN
        SELECT @ErrorCode = 1
        GOTO Cleanup
    END
    IF (@DeleteOnlyIfRoleIsEmpty <> 0)
    BEGIN
        IF (EXISTS (SELECT RoleId FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId))
        BEGIN
            SELECT @ErrorCode = 2
            GOTO Cleanup
        END
    END


    DELETE FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DELETE FROM dbo.aspnet_Roles WHERE @RoleId = RoleId  AND ApplicationId = @ApplicationId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Roles_GetAllRoles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Roles_GetAllRoles (
    @ApplicationName           nvarchar(256))
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN
    SELECT RoleName
    FROM   dbo.aspnet_Roles WHERE ApplicationId = @ApplicationId
    ORDER BY RoleName
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Roles_RoleExists]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Roles_RoleExists
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(0)
    IF (EXISTS (SELECT RoleName FROM dbo.aspnet_Roles WHERE LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId ))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Setup_RemoveAllRoleMembers]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_Setup_RemoveAllRoleMembers
    @name   sysname
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers
    (
        Group_name      sysname,
        Group_id        smallint,
        Users_in_group  sysname,
        User_id         smallint
    )

    INSERT INTO #aspnet_RoleMembers
    EXEC sp_helpuser @name

    DECLARE @user_id smallint
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT User_id FROM #aspnet_RoleMembers

    OPEN c1

    FETCH c1 INTO @user_id
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + ''''
        EXEC (@cmd)
        FETCH c1 INTO @user_id
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Setup_RestorePermissions]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_Setup_RestorePermissions
    @name   sysname
AS
BEGIN
    DECLARE @object sysname
    DECLARE @protectType char(10)
    DECLARE @action varchar(60)
    DECLARE @grantee sysname
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT Object, ProtectType, [Action], Grantee FROM #aspnet_Permissions where Object = @name

    OPEN c1

    FETCH c1 INTO @object, @protectType, @action, @grantee
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']'
        EXEC (@cmd)
        FETCH c1 INTO @object, @protectType, @action, @grantee
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UnRegisterSchemaVersion]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_UnRegisterSchemaVersion
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    DELETE FROM dbo.aspnet_SchemaVersions
        WHERE   Feature = LOWER(@Feature) AND @CompatibleSchemaVersion = CompatibleSchemaVersion
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Users_CreateUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE [dbo].aspnet_Users_CreateUser
    @ApplicationId    uniqueidentifier,
    @UserName         nvarchar(256),
    @IsUserAnonymous  bit,
    @LastActivityDate DATETIME,
    @UserId           uniqueidentifier OUTPUT
AS
BEGIN
    IF( @UserId IS NULL )
        SELECT @UserId = NEWID()
    ELSE
    BEGIN
        IF( EXISTS( SELECT UserId FROM dbo.aspnet_Users
                    WHERE @UserId = UserId ) )
            RETURN -1
    END

    INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
    VALUES (@ApplicationId, @UserId, @UserName, LOWER(@UserName), @IsUserAnonymous, @LastActivityDate)

    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Users_DeleteUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE [dbo].aspnet_Users_DeleteUser
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @TablesToDeleteFrom int,
    @NumTablesDeletedFrom int OUTPUT
AS
BEGIN
    DECLARE @UserId               uniqueidentifier
    SELECT  @UserId               = NULL
    SELECT  @NumTablesDeletedFrom = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    DECLARE @ErrorCode   int
    DECLARE @RowCount    int

    SET @ErrorCode = 0
    SET @RowCount  = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   u.LoweredUserName       = LOWER(@UserName)
        AND u.ApplicationId         = a.ApplicationId
        AND LOWER(@ApplicationName) = a.LoweredApplicationName

    IF (@UserId IS NULL)
    BEGIN
        GOTO Cleanup
    END

    -- Delete from Membership table if (@TablesToDeleteFrom & 1) is set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        DELETE FROM dbo.aspnet_Membership WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
               @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_UsersInRoles table if (@TablesToDeleteFrom & 2) is set
    IF ((@TablesToDeleteFrom & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_UsersInRoles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Profile table if (@TablesToDeleteFrom & 4) is set
    IF ((@TablesToDeleteFrom & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_Profile WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_PersonalizationPerUser table if (@TablesToDeleteFrom & 8) is set
    IF ((@TablesToDeleteFrom & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Users table if (@TablesToDeleteFrom & 1,2,4 & 8) are all set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (@TablesToDeleteFrom & 2) <> 0 AND
        (@TablesToDeleteFrom & 4) <> 0 AND
        (@TablesToDeleteFrom & 8) <> 0 AND
        (EXISTS (SELECT UserId FROM dbo.aspnet_Users WHERE @UserId = UserId)))
    BEGIN
        DELETE FROM dbo.aspnet_Users WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:
    SET @NumTablesDeletedFrom = 0

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
	    ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_AddUsersToRoles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_AddUsersToRoles
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000),
	@CurrentTimeUtc   datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)
	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames	table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles	table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers	table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num		int
	DECLARE @Pos		int
	DECLARE @NextPos	int
	DECLARE @Name		nvarchar(256)

	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		SELECT TOP 1 Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END

	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1

	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		DELETE FROM @tbNames
		WHERE LOWER(Name) IN (SELECT LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE au.UserId = u.UserId)

		INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
		  SELECT @AppId, NEWID(), Name, LOWER(Name), 0, @CurrentTimeUtc
		  FROM   @tbNames

		INSERT INTO @tbUsers
		  SELECT  UserId
		  FROM	dbo.aspnet_Users au, @tbNames t
		  WHERE   LOWER(t.Name) = au.LoweredUserName AND au.ApplicationId = @AppId
	END

	IF (EXISTS (SELECT * FROM dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr WHERE tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId))
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr, aspnet_Users u, aspnet_Roles r
		WHERE		u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
	SELECT UserId, RoleId
	FROM @tbUsers, @tbRoles

	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_FindUsersInRole]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_FindUsersInRole
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256),
    @UserNameToMatch  nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId AND LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName
    RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_GetRolesForUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_GetRolesForUser
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(1)

    SELECT r.RoleName
    FROM   dbo.aspnet_Roles r, dbo.aspnet_UsersInRoles ur
    WHERE  r.RoleId = ur.RoleId AND r.ApplicationId = @ApplicationId AND ur.UserId = @UserId
    ORDER BY r.RoleName
    RETURN (0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_GetUsersInRoles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_GetUsersInRoles
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName
    RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_IsUserInRole]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_IsUserInRole
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(2)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    DECLARE @RoleId uniqueidentifier
    SELECT  @RoleId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(2)

    SELECT  @RoleId = RoleId
    FROM    dbo.aspnet_Roles
    WHERE   LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
        RETURN(3)

    IF (EXISTS( SELECT * FROM dbo.aspnet_UsersInRoles WHERE  UserId = @UserId AND RoleId = @RoleId))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_UsersInRoles_RemoveUsersFromRoles
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames  table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles  table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers  table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num	  int
	DECLARE @Pos	  int
	DECLARE @NextPos  int
	DECLARE @Name	  nvarchar(256)
	DECLARE @CountAll int
	DECLARE @CountU	  int
	DECLARE @CountR	  int


	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId
	SELECT @CountR = @@ROWCOUNT

	IF (@CountR <> @Num)
	BEGIN
		SELECT TOP 1 N'', Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END


	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1


	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	SELECT @CountU = @@ROWCOUNT
	IF (@CountU <> @Num)
	BEGIN
		SELECT TOP 1 Name, N''
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE u.UserId = au.UserId)

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(1)
	END

	SELECT  @CountAll = COUNT(*)
	FROM	dbo.aspnet_UsersInRoles ur, @tbUsers u, @tbRoles r
	WHERE   ur.UserId = u.UserId AND ur.RoleId = r.RoleId

	IF (@CountAll <> @CountU * @CountR)
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 @tbUsers tu, @tbRoles tr, dbo.aspnet_Users u, dbo.aspnet_Roles r
		WHERE		 u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND
					 tu.UserId NOT IN (SELECT ur.UserId FROM dbo.aspnet_UsersInRoles ur WHERE ur.RoleId = tr.RoleId) AND
					 tr.RoleId NOT IN (SELECT ur.RoleId FROM dbo.aspnet_UsersInRoles ur WHERE ur.UserId = tu.UserId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	DELETE FROM dbo.aspnet_UsersInRoles
	WHERE UserId IN (SELECT UserId FROM @tbUsers)
	  AND RoleId IN (SELECT RoleId FROM @tbRoles)
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_WebEvent_LogEvent]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_WebEvent_LogEvent
        @EventId         char(32),
        @EventTimeUtc    datetime,
        @EventTime       datetime,
        @EventType       nvarchar(256),
        @EventSequence   decimal(19,0),
        @EventOccurrence decimal(19,0),
        @EventCode       int,
        @EventDetailCode int,
        @Message         nvarchar(1024),
        @ApplicationPath nvarchar(256),
        @ApplicationVirtualPath nvarchar(256),
        @MachineName    nvarchar(256),
        @RequestUrl      nvarchar(1024),
        @ExceptionType   nvarchar(256),
        @Details         ntext
AS
BEGIN
    INSERT
        dbo.aspnet_WebEvent_Events
        (
            EventId,
            EventTimeUtc,
            EventTime,
            EventType,
            EventSequence,
            EventOccurrence,
            EventCode,
            EventDetailCode,
            Message,
            ApplicationPath,
            ApplicationVirtualPath,
            MachineName,
            RequestUrl,
            ExceptionType,
            Details
        )
    VALUES
    (
        @EventId,
        @EventTimeUtc,
        @EventTime,
        @EventType,
        @EventSequence,
        @EventOccurrence,
        @EventCode,
        @EventDetailCode,
        @Message,
        @ApplicationPath,
        @ApplicationVirtualPath,
        @MachineName,
        @RequestUrl,
        @ExceptionType,
        @Details
    )
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Membership_CreateUser]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_Membership_CreateUser
    @ApplicationName                        nvarchar(256),
    @UserName                               nvarchar(256),
    @Password                               nvarchar(128),
    @PasswordSalt                           nvarchar(128),
    @Email                                  nvarchar(256),
    @PasswordQuestion                       nvarchar(256),
    @PasswordAnswer                         nvarchar(128),
    @IsApproved                             bit,
    @CurrentTimeUtc                         datetime,
    @CreateDate                             datetime = NULL,
    @UniqueEmail                            int      = 0,
    @PasswordFormat                         int      = 0,
    @UserId                                 uniqueidentifier OUTPUT
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @NewUserId uniqueidentifier
    SELECT @NewUserId = NULL

    DECLARE @IsLockedOut bit
    SET @IsLockedOut = 0

    DECLARE @LastLockoutDate  datetime
    SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAttemptCount int
    SET @FailedPasswordAttemptCount = 0

    DECLARE @FailedPasswordAttemptWindowStart  datetime
    SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAnswerAttemptCount int
    SET @FailedPasswordAnswerAttemptCount = 0

    DECLARE @FailedPasswordAnswerAttemptWindowStart  datetime
    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @NewUserCreated bit
    DECLARE @ReturnValue   int
    SET @ReturnValue = 0

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    SET @CreateDate = @CurrentTimeUtc

    SELECT  @NewUserId = UserId FROM dbo.aspnet_Users WHERE LOWER(@UserName) = LoweredUserName AND @ApplicationId = ApplicationId
    IF ( @NewUserId IS NULL )
    BEGIN
        SET @NewUserId = @UserId
        EXEC @ReturnValue = dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CreateDate, @NewUserId OUTPUT
        SET @NewUserCreated = 1
    END
    ELSE
    BEGIN
        SET @NewUserCreated = 0
        IF( @NewUserId <> @UserId AND @UserId IS NOT NULL )
        BEGIN
            SET @ErrorCode = 6
            GOTO Cleanup
        END
    END

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @ReturnValue = -1 )
    BEGIN
        SET @ErrorCode = 10
        GOTO Cleanup
    END

    IF ( EXISTS ( SELECT UserId
                  FROM   dbo.aspnet_Membership
                  WHERE  @NewUserId = UserId ) )
    BEGIN
        SET @ErrorCode = 6
        GOTO Cleanup
    END

    SET @UserId = @NewUserId

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE ApplicationId = @ApplicationId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            SET @ErrorCode = 7
            GOTO Cleanup
        END
    END

    IF (@NewUserCreated = 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate = @CreateDate
        WHERE  @UserId = UserId
        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    INSERT INTO dbo.aspnet_Membership
                ( ApplicationId,
                  UserId,
                  Password,
                  PasswordSalt,
                  Email,
                  LoweredEmail,
                  PasswordQuestion,
                  PasswordAnswer,
                  PasswordFormat,
                  IsApproved,
                  IsLockedOut,
                  CreateDate,
                  LastLoginDate,
                  LastPasswordChangedDate,
                  LastLockoutDate,
                  FailedPasswordAttemptCount,
                  FailedPasswordAttemptWindowStart,
                  FailedPasswordAnswerAttemptCount,
                  FailedPasswordAnswerAttemptWindowStart )
         VALUES ( @ApplicationId,
                  @UserId,
                  @Password,
                  @PasswordSalt,
                  @Email,
                  LOWER(@Email),
                  @PasswordQuestion,
                  @PasswordAnswer,
                  @PasswordFormat,
                  @IsApproved,
                  @IsLockedOut,
                  @CreateDate,
                  @CreateDate,
                  @CreateDate,
                  @LastLockoutDate,
                  @FailedPasswordAttemptCount,
                  @FailedPasswordAttemptWindowStart,
                  @FailedPasswordAnswerAttemptCount,
                  @FailedPasswordAnswerAttemptWindowStart )

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser_SetPageSettings]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE dbo.aspnet_PersonalizationPerUser_SetPageSettings (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationPerUser WHERE UserId = @UserId AND PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationPerUser SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE UserId = @UserId AND PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationPerUser(UserId, PathId, PageSettings, LastUpdatedDate) VALUES (@UserId, @PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_DeleteProfiles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_DeleteProfiles
    @ApplicationName        nvarchar(256),
    @UserNames              nvarchar(4000)
AS
BEGIN
    DECLARE @UserName     nvarchar(256)
    DECLARE @CurrentPos   int
    DECLARE @NextPos      int
    DECLARE @NumDeleted   int
    DECLARE @DeletedUser  int
    DECLARE @TranStarted  bit
    DECLARE @ErrorCode    int

    SET @ErrorCode = 0
    SET @CurrentPos = 1
    SET @NumDeleted = 0
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    WHILE (@CurrentPos <= LEN(@UserNames))
    BEGIN
        SELECT @NextPos = CHARINDEX(N',', @UserNames,  @CurrentPos)
        IF (@NextPos = 0 OR @NextPos IS NULL)
            SELECT @NextPos = LEN(@UserNames) + 1

        SELECT @UserName = SUBSTRING(@UserNames, @CurrentPos, @NextPos - @CurrentPos)
        SELECT @CurrentPos = @NextPos+1

        IF (LEN(@UserName) > 0)
        BEGIN
            SELECT @DeletedUser = 0
            EXEC dbo.aspnet_Users_DeleteUser @ApplicationName, @UserName, 4, @DeletedUser OUTPUT
            IF( @@ERROR <> 0 )
            BEGIN
                SET @ErrorCode = -1
                GOTO Cleanup
            END
            IF (@DeletedUser <> 0)
                SELECT @NumDeleted = @NumDeleted + 1
        END
    END
    SELECT @NumDeleted
    IF (@TranStarted = 1)
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END
    SET @TranStarted = 0

    RETURN 0

Cleanup:
    IF (@TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END
    RETURN @ErrorCode
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[aspnet_Profile_SetProperties]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

CREATE PROCEDURE dbo.aspnet_Profile_SetProperties
    @ApplicationName        nvarchar(256),
    @PropertyNames          ntext,
    @PropertyValuesString   ntext,
    @PropertyValuesBinary   image,
    @UserName               nvarchar(256),
    @IsUserAnonymous        bit,
    @CurrentTimeUtc         datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
       BEGIN TRANSACTION
       SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DECLARE @UserId uniqueidentifier
    DECLARE @LastActivityDate datetime
    SELECT  @UserId = NULL
    SELECT  @LastActivityDate = @CurrentTimeUtc

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, @IsUserAnonymous, @LastActivityDate, @UserId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Users
    SET    LastActivityDate=@CurrentTimeUtc
    WHERE  UserId = @UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS( SELECT *
               FROM   dbo.aspnet_Profile
               WHERE  UserId = @UserId))
        UPDATE dbo.aspnet_Profile
        SET    PropertyNames=@PropertyNames, PropertyValuesString = @PropertyValuesString,
               PropertyValuesBinary = @PropertyValuesBinary, LastUpdatedDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    ELSE
        INSERT INTO dbo.aspnet_Profile(UserId, PropertyNames, PropertyValuesString, PropertyValuesBinary, LastUpdatedDate)
             VALUES (@UserId, @PropertyNames, @PropertyValuesString, @PropertyValuesBinary, @CurrentTimeUtc)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[CountSpeciesFish]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION CountSpeciesFish
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FishCount int

	-- Add the T-SQL statements to compute the return value here
	SELECT @FishCount =  COUNT(*)
	FROM         Fish INNER JOIN
						  Species ON Fish.FishSpeciesID = Species.SpeciesID
	WHERE     (Species.SpeciesID = 2)

	-- Return the result of the function
	RETURN @FishCount

END
GO
PRINT N'Creating [dbo].[CountSpeciesPhotos]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CountSpeciesPhotos]
(
	-- Add the parameters for the function here
	@SpeciesID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PhotoCount int
	
	SELECT @PhotoCount = COUNT(*) 
	FROM         Fish INNER JOIN
                      FishPhotos ON Fish.FishID = FishPhotos.FishID INNER JOIN
                      Species ON Fish.FishSpeciesID = Species.SpeciesID
	WHERE SpeciesID = @SpeciesID

	-- Return the result of the function
	RETURN @PhotoCount

END
GO
PRINT N'Creating [dbo].[SpeciesHasFish]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION SpeciesHasFish
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SpeciesHasFish bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @SpeciesHasFish = (CONVERT([bit],case when dbo.CountSpeciesFish(@SpeciesId)>(0) then (1) else (0) end,0))

	-- Return the result of the function
	RETURN @SpeciesHasFish

END
GO
PRINT N'Creating [dbo].[SpeciesHasPhoto]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION SpeciesHasPhoto
(
	-- Add the parameters for the function here
	@SpeciesId int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HasPhotos bit

	-- Add the T-SQL statements to compute the return value here
	SELECT @HasPhotos = (CONVERT([bit],case when dbo.CountSpeciesPhotos(@SpeciesID)>(0) then (1) else (0) end,0))
	-- Return the result of the function
	RETURN @HasPhotos
END
GO
PRINT N'Creating [dbo].[Species]...';


GO
CREATE TABLE [dbo].[Species] (
    [SpeciesID]            INT             IDENTITY (1, 1) NOT NULL,
    [SpeciesName]          NVARCHAR (255)  NOT NULL,
    [SpeciesGenusID]       INT             NOT NULL,
    [SpeciesDescribed]     BIT             NOT NULL,
    [SpeciesHasPhotos]     AS              ([dbo].[SpeciesHasPhoto]([SpeciesID])),
    [SpeciesHasFish]       AS              ([dbo].[SpeciesHasFish]([SpeciesID])),
    [SpeciesDescription]   NVARCHAR (4000) NULL,
    [SpeciesMinSize]       INT             NOT NULL,
    [SpeciesMaxSize]       INT             NOT NULL,
    [SpeciesTemperamentID] INT             NOT NULL
);


GO
PRINT N'Creating PK_Species...';


GO
ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [PK_Species] PRIMARY KEY CLUSTERED ([SpeciesID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating FK_Species_Genus...';


GO
ALTER TABLE [dbo].[Species] WITH NOCHECK
    ADD CONSTRAINT [FK_Species_Genus] FOREIGN KEY ([SpeciesGenusID]) REFERENCES [dbo].[Genus] ([GenusID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_Species_Temperaments...';


GO
ALTER TABLE [dbo].[Species] WITH NOCHECK
    ADD CONSTRAINT [FK_Species_Temperaments] FOREIGN KEY ([SpeciesTemperamentID]) REFERENCES [dbo].[Temperaments] ([TemperamentID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating DF_Species_SpeciesMaxLength...';


GO
ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesMaxLength] DEFAULT ((0)) FOR [SpeciesMaxSize];


GO
PRINT N'Creating DF_Species_SpeciesMinLength...';


GO
ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesMinLength] DEFAULT ((0)) FOR [SpeciesMinSize];


GO
PRINT N'Creating DF_Species_SpeciesTemperament...';


GO
ALTER TABLE [dbo].[Species]
    ADD CONSTRAINT [DF_Species_SpeciesTemperament] DEFAULT ((1)) FOR [SpeciesTemperamentID];


GO
PRINT N'Creating FK_Fish_Species...';


GO
ALTER TABLE [dbo].[Fish] WITH NOCHECK
    ADD CONSTRAINT [FK_Fish_Species] FOREIGN KEY ([FishSpeciesID]) REFERENCES [dbo].[Species] ([SpeciesID]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating [dbo].[vw_aspnet_Applications]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_MembershipUsers]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_Profiles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_Roles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_Users]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_UsersInRoles]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_WebPartState_Paths]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_WebPartState_Shared]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[vw_aspnet_WebPartState_User]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
-- Refactoring step to update target server with deployed transaction logs
CREATE TABLE  [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
GO
sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
GO

GO
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Drop constraints from [dbo].[Species]
ALTER TABLE [dbo].[Species] DROP CONSTRAINT [FK_Species_Genus]
ALTER TABLE [dbo].[Species] DROP CONSTRAINT [FK_Species_Temperaments]

-- Drop constraints from [dbo].[Locales]
ALTER TABLE [dbo].[Locales] DROP CONSTRAINT [FK_Locales_Lakes]

-- Drop constraints from [dbo].[GenusTypes]
ALTER TABLE [dbo].[GenusTypes] DROP CONSTRAINT [FK_GenusTypes_Lakes]

-- Drop constraints from [dbo].[Genus]
ALTER TABLE [dbo].[Genus] DROP CONSTRAINT [FK_Genus_GenusTypes]

-- Drop constraints from [dbo].[FishPhotos]
ALTER TABLE [dbo].[FishPhotos] DROP CONSTRAINT [FK_FishPhotos_Fish]
ALTER TABLE [dbo].[FishPhotos] DROP CONSTRAINT [FK_FishPhotos_Photos]

-- Drop constraints from [dbo].[Fish]
ALTER TABLE [dbo].[Fish] DROP CONSTRAINT [FK_Fish_Genus]
ALTER TABLE [dbo].[Fish] DROP CONSTRAINT [FK_Fish_Locales]
ALTER TABLE [dbo].[Fish] DROP CONSTRAINT [FK_Fish_Species]

-- Drop constraints from [dbo].[aspnet_Users]
ALTER TABLE [dbo].[aspnet_Users] DROP CONSTRAINT [FK__aspnet_Us__Appli__65370702]

-- Drop constraints from [dbo].[aspnet_Membership]
ALTER TABLE [dbo].[aspnet_Membership] DROP CONSTRAINT [FK__aspnet_Me__Appli__793DFFAF]
ALTER TABLE [dbo].[aspnet_Membership] DROP CONSTRAINT [FK__aspnet_Me__UserI__7A3223E8]

-- Add 6 rows to [dbo].[aspnet_SchemaVersions]
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'common', N'1', 1)
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'health monitoring', N'1', 1)
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'membership', N'1', 1)
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'personalization', N'1', 1)
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'profile', N'1', 1)
INSERT INTO [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'role manager', N'1', 1)

-- Add 3 rows to [dbo].[Lakes]
SET IDENTITY_INSERT [dbo].[Lakes] ON
INSERT INTO [dbo].[Lakes] ([LakeID], [LakeName]) VALUES (1, N'Malawi')
INSERT INTO [dbo].[Lakes] ([LakeID], [LakeName]) VALUES (2, N'Tanganyika')
INSERT INTO [dbo].[Lakes] ([LakeID], [LakeName]) VALUES (3, N'Victoria')
SET IDENTITY_INSERT [dbo].[Lakes] OFF

-- Add 164 rows to [dbo].[Photos]
SET IDENTITY_INSERT [dbo].[Photos] ON
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (117, N'5845698000', NULL, NULL, N'http://farm4.static.flickr.com/3042/5845698000_e1a9ac960f_b.jpg', N'http://farm4.static.flickr.com/3042/5845698000_e1a9ac960f.jpg', N'http://farm4.static.flickr.com/3042/5845698000_e1a9ac960f_m.jpg', N'http://farm4.static.flickr.com/3042/5845698000_e1a9ac960f_t.jpg', N'http://farm4.static.flickr.com/3042/5845698000_e1a9ac960f_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (118, N'5845185291', NULL, NULL, N'http://farm3.static.flickr.com/2594/5845185291_26e85149c2_b.jpg', N'http://farm3.static.flickr.com/2594/5845185291_26e85149c2.jpg', N'http://farm3.static.flickr.com/2594/5845185291_26e85149c2_m.jpg', N'http://farm3.static.flickr.com/2594/5845185291_26e85149c2_t.jpg', N'http://farm3.static.flickr.com/2594/5845185291_26e85149c2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (119, N'5845738390', NULL, NULL, N'http://farm4.static.flickr.com/3347/5845738390_39686d966b_b.jpg', N'http://farm4.static.flickr.com/3347/5845738390_39686d966b.jpg', N'http://farm4.static.flickr.com/3347/5845738390_39686d966b_m.jpg', N'http://farm4.static.flickr.com/3347/5845738390_39686d966b_t.jpg', N'http://farm4.static.flickr.com/3347/5845738390_39686d966b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (120, N'5845188957', NULL, NULL, N'http://farm3.static.flickr.com/2507/5845188957_abc437d3c6_b.jpg', N'http://farm3.static.flickr.com/2507/5845188957_abc437d3c6.jpg', N'http://farm3.static.flickr.com/2507/5845188957_abc437d3c6_m.jpg', N'http://farm3.static.flickr.com/2507/5845188957_abc437d3c6_t.jpg', N'http://farm3.static.flickr.com/2507/5845188957_abc437d3c6_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (121, N'5845189873', NULL, NULL, N'http://farm6.static.flickr.com/5158/5845189873_263f195b88_b.jpg', N'http://farm6.static.flickr.com/5158/5845189873_263f195b88.jpg', N'http://farm6.static.flickr.com/5158/5845189873_263f195b88_m.jpg', N'http://farm6.static.flickr.com/5158/5845189873_263f195b88_t.jpg', N'http://farm6.static.flickr.com/5158/5845189873_263f195b88_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (122, N'5845742772', NULL, NULL, N'http://farm6.static.flickr.com/5068/5845742772_629ab9438b_b.jpg', N'http://farm6.static.flickr.com/5068/5845742772_629ab9438b.jpg', N'http://farm6.static.flickr.com/5068/5845742772_629ab9438b_m.jpg', N'http://farm6.static.flickr.com/5068/5845742772_629ab9438b_t.jpg', N'http://farm6.static.flickr.com/5068/5845742772_629ab9438b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (123, N'5845197497', NULL, NULL, N'http://farm4.static.flickr.com/3092/5845197497_be1921a80a_b.jpg', N'http://farm4.static.flickr.com/3092/5845197497_be1921a80a.jpg', N'http://farm4.static.flickr.com/3092/5845197497_be1921a80a_m.jpg', N'http://farm4.static.flickr.com/3092/5845197497_be1921a80a_t.jpg', N'http://farm4.static.flickr.com/3092/5845197497_be1921a80a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (126, N'5845223679', NULL, NULL, N'http://farm4.static.flickr.com/3540/5845223679_3fcaff1ec8_b.jpg', N'http://farm4.static.flickr.com/3540/5845223679_3fcaff1ec8.jpg', N'http://farm4.static.flickr.com/3540/5845223679_3fcaff1ec8_m.jpg', N'http://farm4.static.flickr.com/3540/5845223679_3fcaff1ec8_t.jpg', N'http://farm4.static.flickr.com/3540/5845223679_3fcaff1ec8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (127, N'5845778456', NULL, NULL, N'http://farm4.static.flickr.com/3139/5845778456_04b662049b_b.jpg', N'http://farm4.static.flickr.com/3139/5845778456_04b662049b.jpg', N'http://farm4.static.flickr.com/3139/5845778456_04b662049b_m.jpg', N'http://farm4.static.flickr.com/3139/5845778456_04b662049b_t.jpg', N'http://farm4.static.flickr.com/3139/5845778456_04b662049b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (128, N'5845227321', NULL, NULL, N'http://farm3.static.flickr.com/2606/5845227321_df707d8e67_b.jpg', N'http://farm3.static.flickr.com/2606/5845227321_df707d8e67.jpg', N'http://farm3.static.flickr.com/2606/5845227321_df707d8e67_m.jpg', N'http://farm3.static.flickr.com/2606/5845227321_df707d8e67_t.jpg', N'http://farm3.static.flickr.com/2606/5845227321_df707d8e67_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (129, N'5845228287', NULL, NULL, N'http://farm6.static.flickr.com/5111/5845228287_e28e12a26a_b.jpg', N'http://farm6.static.flickr.com/5111/5845228287_e28e12a26a.jpg', N'http://farm6.static.flickr.com/5111/5845228287_e28e12a26a_m.jpg', N'http://farm6.static.flickr.com/5111/5845228287_e28e12a26a_t.jpg', N'http://farm6.static.flickr.com/5111/5845228287_e28e12a26a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (130, N'5845236153', NULL, NULL, N'http://farm3.static.flickr.com/2447/5845236153_048fb1a6e5_b.jpg', N'http://farm3.static.flickr.com/2447/5845236153_048fb1a6e5.jpg', N'http://farm3.static.flickr.com/2447/5845236153_048fb1a6e5_m.jpg', N'http://farm3.static.flickr.com/2447/5845236153_048fb1a6e5_t.jpg', N'http://farm3.static.flickr.com/2447/5845236153_048fb1a6e5_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (131, N'5845237101', NULL, NULL, N'http://farm6.static.flickr.com/5159/5845237101_a955b42269_b.jpg', N'http://farm6.static.flickr.com/5159/5845237101_a955b42269.jpg', N'http://farm6.static.flickr.com/5159/5845237101_a955b42269_m.jpg', N'http://farm6.static.flickr.com/5159/5845237101_a955b42269_t.jpg', N'http://farm6.static.flickr.com/5159/5845237101_a955b42269_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (132, N'5845818298', NULL, NULL, N'http://farm4.static.flickr.com/3420/5845818298_6d6d9f0c7b_b.jpg', N'http://farm4.static.flickr.com/3420/5845818298_6d6d9f0c7b.jpg', N'http://farm4.static.flickr.com/3420/5845818298_6d6d9f0c7b_m.jpg', N'http://farm4.static.flickr.com/3420/5845818298_6d6d9f0c7b_t.jpg', N'http://farm4.static.flickr.com/3420/5845818298_6d6d9f0c7b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (133, N'5845267515', NULL, NULL, N'http://farm3.static.flickr.com/2596/5845267515_eb90bdecb5_b.jpg', N'http://farm3.static.flickr.com/2596/5845267515_eb90bdecb5.jpg', N'http://farm3.static.flickr.com/2596/5845267515_eb90bdecb5_m.jpg', N'http://farm3.static.flickr.com/2596/5845267515_eb90bdecb5_t.jpg', N'http://farm3.static.flickr.com/2596/5845267515_eb90bdecb5_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (134, N'5845841072', NULL, NULL, N'http://farm4.static.flickr.com/3487/5845841072_e347e83cd3_b.jpg', N'http://farm4.static.flickr.com/3487/5845841072_e347e83cd3.jpg', N'http://farm4.static.flickr.com/3487/5845841072_e347e83cd3_m.jpg', N'http://farm4.static.flickr.com/3487/5845841072_e347e83cd3_t.jpg', N'http://farm4.static.flickr.com/3487/5845841072_e347e83cd3_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (137, N'5845297695', NULL, NULL, N'http://farm3.static.flickr.com/2521/5845297695_dd76afa36e_b.jpg', N'http://farm3.static.flickr.com/2521/5845297695_dd76afa36e.jpg', N'http://farm3.static.flickr.com/2521/5845297695_dd76afa36e_m.jpg', N'http://farm3.static.flickr.com/2521/5845297695_dd76afa36e_t.jpg', N'http://farm3.static.flickr.com/2521/5845297695_dd76afa36e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (138, N'5845861430', NULL, NULL, N'http://farm4.static.flickr.com/3581/5845861430_e74a46bcbc_b.jpg', N'http://farm4.static.flickr.com/3581/5845861430_e74a46bcbc.jpg', N'http://farm4.static.flickr.com/3581/5845861430_e74a46bcbc_m.jpg', N'http://farm4.static.flickr.com/3581/5845861430_e74a46bcbc_t.jpg', N'http://farm4.static.flickr.com/3581/5845861430_e74a46bcbc_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (139, N'5845867988', NULL, NULL, N'http://farm4.static.flickr.com/3494/5845867988_36fb66b1a0_b.jpg', N'http://farm4.static.flickr.com/3494/5845867988_36fb66b1a0.jpg', N'http://farm4.static.flickr.com/3494/5845867988_36fb66b1a0_m.jpg', N'http://farm4.static.flickr.com/3494/5845867988_36fb66b1a0_t.jpg', N'http://farm4.static.flickr.com/3494/5845867988_36fb66b1a0_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (140, N'5845877116', NULL, NULL, N'http://farm3.static.flickr.com/2592/5845877116_1166096f20_b.jpg', N'http://farm3.static.flickr.com/2592/5845877116_1166096f20.jpg', N'http://farm3.static.flickr.com/2592/5845877116_1166096f20_m.jpg', N'http://farm3.static.flickr.com/2592/5845877116_1166096f20_t.jpg', N'http://farm3.static.flickr.com/2592/5845877116_1166096f20_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (141, N'5845326877', NULL, NULL, N'http://farm6.static.flickr.com/5069/5845326877_b340499836_b.jpg', N'http://farm6.static.flickr.com/5069/5845326877_b340499836.jpg', N'http://farm6.static.flickr.com/5069/5845326877_b340499836_m.jpg', N'http://farm6.static.flickr.com/5069/5845326877_b340499836_t.jpg', N'http://farm6.static.flickr.com/5069/5845326877_b340499836_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (142, N'5845333031', NULL, NULL, N'http://farm6.static.flickr.com/5143/5845333031_107990f2c1_b.jpg', N'http://farm6.static.flickr.com/5143/5845333031_107990f2c1.jpg', N'http://farm6.static.flickr.com/5143/5845333031_107990f2c1_m.jpg', N'http://farm6.static.flickr.com/5143/5845333031_107990f2c1_t.jpg', N'http://farm6.static.flickr.com/5143/5845333031_107990f2c1_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (143, N'5845886524', NULL, NULL, N'http://farm4.static.flickr.com/3274/5845886524_816e21f4a7_b.jpg', N'http://farm4.static.flickr.com/3274/5845886524_816e21f4a7.jpg', N'http://farm4.static.flickr.com/3274/5845886524_816e21f4a7_m.jpg', N'http://farm4.static.flickr.com/3274/5845886524_816e21f4a7_t.jpg', N'http://farm4.static.flickr.com/3274/5845886524_816e21f4a7_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (144, N'5845897140', NULL, NULL, N'http://farm3.static.flickr.com/2590/5845897140_be1db8432d_b.jpg', N'http://farm3.static.flickr.com/2590/5845897140_be1db8432d.jpg', N'http://farm3.static.flickr.com/2590/5845897140_be1db8432d_m.jpg', N'http://farm3.static.flickr.com/2590/5845897140_be1db8432d_t.jpg', N'http://farm3.static.flickr.com/2590/5845897140_be1db8432d_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (145, N'5845537847', NULL, NULL, N'http://farm4.static.flickr.com/3151/5845537847_1ddf88589f_b.jpg', N'http://farm4.static.flickr.com/3151/5845537847_1ddf88589f.jpg', N'http://farm4.static.flickr.com/3151/5845537847_1ddf88589f_m.jpg', N'http://farm4.static.flickr.com/3151/5845537847_1ddf88589f_t.jpg', N'http://farm4.static.flickr.com/3151/5845537847_1ddf88589f_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (147, N'5845592387', NULL, NULL, N'http://farm4.static.flickr.com/3025/5845592387_8c568cc359_b.jpg', N'http://farm4.static.flickr.com/3025/5845592387_8c568cc359.jpg', N'http://farm4.static.flickr.com/3025/5845592387_8c568cc359_m.jpg', N'http://farm4.static.flickr.com/3025/5845592387_8c568cc359_t.jpg', N'http://farm4.static.flickr.com/3025/5845592387_8c568cc359_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (148, N'5846145888', NULL, NULL, N'http://farm6.static.flickr.com/5030/5846145888_73d9c9ebb6_b.jpg', N'http://farm6.static.flickr.com/5030/5846145888_73d9c9ebb6.jpg', N'http://farm6.static.flickr.com/5030/5846145888_73d9c9ebb6_m.jpg', N'http://farm6.static.flickr.com/5030/5846145888_73d9c9ebb6_t.jpg', N'http://farm6.static.flickr.com/5030/5846145888_73d9c9ebb6_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (149, N'5846148440', NULL, NULL, N'http://farm4.static.flickr.com/3300/5846148440_07850d696c_b.jpg', N'http://farm4.static.flickr.com/3300/5846148440_07850d696c.jpg', N'http://farm4.static.flickr.com/3300/5846148440_07850d696c_m.jpg', N'http://farm4.static.flickr.com/3300/5846148440_07850d696c_t.jpg', N'http://farm4.static.flickr.com/3300/5846148440_07850d696c_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (150, N'5845598511', NULL, NULL, N'http://farm4.static.flickr.com/3388/5845598511_67c860f6a1_b.jpg', N'http://farm4.static.flickr.com/3388/5845598511_67c860f6a1.jpg', N'http://farm4.static.flickr.com/3388/5845598511_67c860f6a1_m.jpg', N'http://farm4.static.flickr.com/3388/5845598511_67c860f6a1_t.jpg', N'http://farm4.static.flickr.com/3388/5845598511_67c860f6a1_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (151, N'5846151922', NULL, NULL, N'http://farm6.static.flickr.com/5038/5846151922_0b839dc5bd_b.jpg', N'http://farm6.static.flickr.com/5038/5846151922_0b839dc5bd.jpg', N'http://farm6.static.flickr.com/5038/5846151922_0b839dc5bd_m.jpg', N'http://farm6.static.flickr.com/5038/5846151922_0b839dc5bd_t.jpg', N'http://farm6.static.flickr.com/5038/5846151922_0b839dc5bd_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (152, N'5846154476', NULL, NULL, N'http://farm4.static.flickr.com/3108/5846154476_485e7f4620_b.jpg', N'http://farm4.static.flickr.com/3108/5846154476_485e7f4620.jpg', N'http://farm4.static.flickr.com/3108/5846154476_485e7f4620_m.jpg', N'http://farm4.static.flickr.com/3108/5846154476_485e7f4620_t.jpg', N'http://farm4.static.flickr.com/3108/5846154476_485e7f4620_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (153, N'5846157282', NULL, NULL, N'http://farm3.static.flickr.com/2751/5846157282_e976aaf9ec_b.jpg', N'http://farm3.static.flickr.com/2751/5846157282_e976aaf9ec.jpg', N'http://farm3.static.flickr.com/2751/5846157282_e976aaf9ec_m.jpg', N'http://farm3.static.flickr.com/2751/5846157282_e976aaf9ec_t.jpg', N'http://farm3.static.flickr.com/2751/5846157282_e976aaf9ec_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (154, N'5845607497', NULL, NULL, N'http://farm4.static.flickr.com/3061/5845607497_099965c1c3_b.jpg', N'http://farm4.static.flickr.com/3061/5845607497_099965c1c3.jpg', N'http://farm4.static.flickr.com/3061/5845607497_099965c1c3_m.jpg', N'http://farm4.static.flickr.com/3061/5845607497_099965c1c3_t.jpg', N'http://farm4.static.flickr.com/3061/5845607497_099965c1c3_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (155, N'5845608493', NULL, NULL, N'http://farm3.static.flickr.com/2444/5845608493_4d26c903b2_b.jpg', N'http://farm3.static.flickr.com/2444/5845608493_4d26c903b2.jpg', N'http://farm3.static.flickr.com/2444/5845608493_4d26c903b2_m.jpg', N'http://farm3.static.flickr.com/2444/5845608493_4d26c903b2_t.jpg', N'http://farm3.static.flickr.com/2444/5845608493_4d26c903b2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (156, N'5846504538', NULL, NULL, N'http://farm4.static.flickr.com/3448/5846504538_2004e1b34b_b.jpg', N'http://farm4.static.flickr.com/3448/5846504538_2004e1b34b.jpg', N'http://farm4.static.flickr.com/3448/5846504538_2004e1b34b_m.jpg', N'http://farm4.static.flickr.com/3448/5846504538_2004e1b34b_t.jpg', N'http://farm4.static.flickr.com/3448/5846504538_2004e1b34b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (157, N'5846507710', NULL, NULL, N'http://farm4.static.flickr.com/3178/5846507710_8165e5e6f7_b.jpg', N'http://farm4.static.flickr.com/3178/5846507710_8165e5e6f7.jpg', N'http://farm4.static.flickr.com/3178/5846507710_8165e5e6f7_m.jpg', N'http://farm4.static.flickr.com/3178/5846507710_8165e5e6f7_t.jpg', N'http://farm4.static.flickr.com/3178/5846507710_8165e5e6f7_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (158, N'5846508568', NULL, NULL, N'http://farm4.static.flickr.com/3511/5846508568_1d5ea6513a_b.jpg', N'http://farm4.static.flickr.com/3511/5846508568_1d5ea6513a.jpg', N'http://farm4.static.flickr.com/3511/5846508568_1d5ea6513a_m.jpg', N'http://farm4.static.flickr.com/3511/5846508568_1d5ea6513a_t.jpg', N'http://farm4.static.flickr.com/3511/5846508568_1d5ea6513a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (159, N'5846525286', NULL, NULL, N'http://farm3.static.flickr.com/2498/5846525286_705b274337_b.jpg', N'http://farm3.static.flickr.com/2498/5846525286_705b274337.jpg', N'http://farm3.static.flickr.com/2498/5846525286_705b274337_m.jpg', N'http://farm3.static.flickr.com/2498/5846525286_705b274337_t.jpg', N'http://farm3.static.flickr.com/2498/5846525286_705b274337_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (160, N'5845979063', NULL, NULL, N'http://farm4.static.flickr.com/3123/5845979063_0074b6b28a_b.jpg', N'http://farm4.static.flickr.com/3123/5845979063_0074b6b28a.jpg', N'http://farm4.static.flickr.com/3123/5845979063_0074b6b28a_m.jpg', N'http://farm4.static.flickr.com/3123/5845979063_0074b6b28a_t.jpg', N'http://farm4.static.flickr.com/3123/5845979063_0074b6b28a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (161, N'5845986037', NULL, NULL, N'http://farm6.static.flickr.com/5159/5845986037_05568df82a_b.jpg', N'http://farm6.static.flickr.com/5159/5845986037_05568df82a.jpg', N'http://farm6.static.flickr.com/5159/5845986037_05568df82a_m.jpg', N'http://farm6.static.flickr.com/5159/5845986037_05568df82a_t.jpg', N'http://farm6.static.flickr.com/5159/5845986037_05568df82a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (163, N'5853040332', NULL, NULL, N'http://farm4.static.flickr.com/3117/5853040332_ba64cb3d83_b.jpg', N'http://farm4.static.flickr.com/3117/5853040332_ba64cb3d83.jpg', N'http://farm4.static.flickr.com/3117/5853040332_ba64cb3d83_m.jpg', N'http://farm4.static.flickr.com/3117/5853040332_ba64cb3d83_t.jpg', N'http://farm4.static.flickr.com/3117/5853040332_ba64cb3d83_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (164, N'5853041150', NULL, NULL, N'http://farm3.static.flickr.com/2761/5853041150_1dcf94d720_b.jpg', N'http://farm3.static.flickr.com/2761/5853041150_1dcf94d720.jpg', N'http://farm3.static.flickr.com/2761/5853041150_1dcf94d720_m.jpg', N'http://farm3.static.flickr.com/2761/5853041150_1dcf94d720_t.jpg', N'http://farm3.static.flickr.com/2761/5853041150_1dcf94d720_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (165, N'5852488495', NULL, NULL, N'http://farm3.static.flickr.com/2760/5852488495_fc96e4d943_b.jpg', N'http://farm3.static.flickr.com/2760/5852488495_fc96e4d943.jpg', N'http://farm3.static.flickr.com/2760/5852488495_fc96e4d943_m.jpg', N'http://farm3.static.flickr.com/2760/5852488495_fc96e4d943_t.jpg', N'http://farm3.static.flickr.com/2760/5852488495_fc96e4d943_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (166, N'5852492823', NULL, NULL, N'http://farm6.static.flickr.com/5038/5852492823_4af5869681_b.jpg', N'http://farm6.static.flickr.com/5038/5852492823_4af5869681.jpg', N'http://farm6.static.flickr.com/5038/5852492823_4af5869681_m.jpg', N'http://farm6.static.flickr.com/5038/5852492823_4af5869681_t.jpg', N'http://farm6.static.flickr.com/5038/5852492823_4af5869681_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (171, N'5852527165', NULL, NULL, N'http://farm3.static.flickr.com/2676/5852527165_9fde1cd2e2_b.jpg', N'http://farm3.static.flickr.com/2676/5852527165_9fde1cd2e2.jpg', N'http://farm3.static.flickr.com/2676/5852527165_9fde1cd2e2_m.jpg', N'http://farm3.static.flickr.com/2676/5852527165_9fde1cd2e2_t.jpg', N'http://farm3.static.flickr.com/2676/5852527165_9fde1cd2e2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (173, N'5880013691', NULL, NULL, N'http://farm6.static.flickr.com/5068/5880013691_f19a8e0a81_b.jpg', N'http://farm6.static.flickr.com/5068/5880013691_f19a8e0a81.jpg', N'http://farm6.static.flickr.com/5068/5880013691_f19a8e0a81_m.jpg', N'http://farm6.static.flickr.com/5068/5880013691_f19a8e0a81_t.jpg', N'http://farm6.static.flickr.com/5068/5880013691_f19a8e0a81_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (175, N'5880580810', NULL, NULL, N'http://farm6.static.flickr.com/5263/5880580810_3707d368dd_b.jpg', N'http://farm6.static.flickr.com/5263/5880580810_3707d368dd.jpg', N'http://farm6.static.flickr.com/5263/5880580810_3707d368dd_m.jpg', N'http://farm6.static.flickr.com/5263/5880580810_3707d368dd_t.jpg', N'http://farm6.static.flickr.com/5263/5880580810_3707d368dd_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (176, N'5880019065', NULL, NULL, N'http://farm7.static.flickr.com/6022/5880019065_218a657be3_b.jpg', N'http://farm7.static.flickr.com/6022/5880019065_218a657be3.jpg', N'http://farm7.static.flickr.com/6022/5880019065_218a657be3_m.jpg', N'http://farm7.static.flickr.com/6022/5880019065_218a657be3_t.jpg', N'http://farm7.static.flickr.com/6022/5880019065_218a657be3_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (177, N'5880589350', NULL, NULL, N'http://farm6.static.flickr.com/5039/5880589350_973088f95a_b.jpg', N'http://farm6.static.flickr.com/5039/5880589350_973088f95a.jpg', N'http://farm6.static.flickr.com/5039/5880589350_973088f95a_m.jpg', N'http://farm6.static.flickr.com/5039/5880589350_973088f95a_t.jpg', N'http://farm6.static.flickr.com/5039/5880589350_973088f95a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (178, N'5880591616', NULL, NULL, N'http://farm6.static.flickr.com/5316/5880591616_b9fa971586_b.jpg', N'http://farm6.static.flickr.com/5316/5880591616_b9fa971586.jpg', N'http://farm6.static.flickr.com/5316/5880591616_b9fa971586_m.jpg', N'http://farm6.static.flickr.com/5316/5880591616_b9fa971586_t.jpg', N'http://farm6.static.flickr.com/5316/5880591616_b9fa971586_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (180, N'5880032397', NULL, NULL, N'http://farm6.static.flickr.com/5151/5880032397_5e044e51f6_b.jpg', N'http://farm6.static.flickr.com/5151/5880032397_5e044e51f6.jpg', N'http://farm6.static.flickr.com/5151/5880032397_5e044e51f6_m.jpg', N'http://farm6.static.flickr.com/5151/5880032397_5e044e51f6_t.jpg', N'http://farm6.static.flickr.com/5151/5880032397_5e044e51f6_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (181, N'5880037867', NULL, NULL, N'http://farm6.static.flickr.com/5310/5880037867_6b6a775665_b.jpg', N'http://farm6.static.flickr.com/5310/5880037867_6b6a775665.jpg', N'http://farm6.static.flickr.com/5310/5880037867_6b6a775665_m.jpg', N'http://farm6.static.flickr.com/5310/5880037867_6b6a775665_t.jpg', N'http://farm6.static.flickr.com/5310/5880037867_6b6a775665_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (182, N'5880602860', NULL, NULL, N'http://farm7.static.flickr.com/6024/5880602860_4b845de021_b.jpg', N'http://farm7.static.flickr.com/6024/5880602860_4b845de021.jpg', N'http://farm7.static.flickr.com/6024/5880602860_4b845de021_m.jpg', N'http://farm7.static.flickr.com/6024/5880602860_4b845de021_t.jpg', N'http://farm7.static.flickr.com/6024/5880602860_4b845de021_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (183, N'5880604332', NULL, NULL, N'http://farm7.static.flickr.com/6041/5880604332_51c3403501_b.jpg', N'http://farm7.static.flickr.com/6041/5880604332_51c3403501.jpg', N'http://farm7.static.flickr.com/6041/5880604332_51c3403501_m.jpg', N'http://farm7.static.flickr.com/6041/5880604332_51c3403501_t.jpg', N'http://farm7.static.flickr.com/6041/5880604332_51c3403501_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (184, N'5880606764', NULL, NULL, N'http://farm6.static.flickr.com/5032/5880606764_c2880eee18_b.jpg', N'http://farm6.static.flickr.com/5032/5880606764_c2880eee18.jpg', N'http://farm6.static.flickr.com/5032/5880606764_c2880eee18_m.jpg', N'http://farm6.static.flickr.com/5032/5880606764_c2880eee18_t.jpg', N'http://farm6.static.flickr.com/5032/5880606764_c2880eee18_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (185, N'5880046883', NULL, NULL, N'http://farm6.static.flickr.com/5230/5880046883_0576ea50bf_b.jpg', N'http://farm6.static.flickr.com/5230/5880046883_0576ea50bf.jpg', N'http://farm6.static.flickr.com/5230/5880046883_0576ea50bf_m.jpg', N'http://farm6.static.flickr.com/5230/5880046883_0576ea50bf_t.jpg', N'http://farm6.static.flickr.com/5230/5880046883_0576ea50bf_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (187, N'5880056313', NULL, NULL, N'http://farm7.static.flickr.com/6042/5880056313_4d6061c47d_b.jpg', N'http://farm7.static.flickr.com/6042/5880056313_4d6061c47d.jpg', N'http://farm7.static.flickr.com/6042/5880056313_4d6061c47d_m.jpg', N'http://farm7.static.flickr.com/6042/5880056313_4d6061c47d_t.jpg', N'http://farm7.static.flickr.com/6042/5880056313_4d6061c47d_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (188, N'5880622812', NULL, NULL, N'http://farm7.static.flickr.com/6001/5880622812_2485746cfe_b.jpg', N'http://farm7.static.flickr.com/6001/5880622812_2485746cfe.jpg', N'http://farm7.static.flickr.com/6001/5880622812_2485746cfe_m.jpg', N'http://farm7.static.flickr.com/6001/5880622812_2485746cfe_t.jpg', N'http://farm7.static.flickr.com/6001/5880622812_2485746cfe_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (189, N'5880198523', NULL, NULL, N'http://farm6.static.flickr.com/5317/5880198523_b345c9048c_b.jpg', N'http://farm6.static.flickr.com/5317/5880198523_b345c9048c.jpg', N'http://farm6.static.flickr.com/5317/5880198523_b345c9048c_m.jpg', N'http://farm6.static.flickr.com/5317/5880198523_b345c9048c_t.jpg', N'http://farm6.static.flickr.com/5317/5880198523_b345c9048c_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (191, N'5958146726', NULL, NULL, N'http://farm7.static.flickr.com/6004/5958146726_e74d93d388_b.jpg', N'http://farm7.static.flickr.com/6004/5958146726_e74d93d388.jpg', N'http://farm7.static.flickr.com/6004/5958146726_e74d93d388_m.jpg', N'http://farm7.static.flickr.com/6004/5958146726_e74d93d388_t.jpg', N'http://farm7.static.flickr.com/6004/5958146726_e74d93d388_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (192, N'5958163184', NULL, NULL, N'http://farm7.static.flickr.com/6027/5958163184_52b2be3c60_b.jpg', N'http://farm7.static.flickr.com/6027/5958163184_52b2be3c60.jpg', N'http://farm7.static.flickr.com/6027/5958163184_52b2be3c60_m.jpg', N'http://farm7.static.flickr.com/6027/5958163184_52b2be3c60_t.jpg', N'http://farm7.static.flickr.com/6027/5958163184_52b2be3c60_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (193, N'5958199696', NULL, NULL, N'http://farm7.static.flickr.com/6018/5958199696_207fc49e9e_b.jpg', N'http://farm7.static.flickr.com/6018/5958199696_207fc49e9e.jpg', N'http://farm7.static.flickr.com/6018/5958199696_207fc49e9e_m.jpg', N'http://farm7.static.flickr.com/6018/5958199696_207fc49e9e_t.jpg', N'http://farm7.static.flickr.com/6018/5958199696_207fc49e9e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (195, N'5957663201', NULL, NULL, N'http://farm7.static.flickr.com/6015/5957663201_04529aab99_b.jpg', N'http://farm7.static.flickr.com/6015/5957663201_04529aab99.jpg', N'http://farm7.static.flickr.com/6015/5957663201_04529aab99_m.jpg', N'http://farm7.static.flickr.com/6015/5957663201_04529aab99_t.jpg', N'http://farm7.static.flickr.com/6015/5957663201_04529aab99_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (198, N'5957702621', NULL, NULL, N'http://farm7.static.flickr.com/6014/5957702621_8c44cc147e_b.jpg', N'http://farm7.static.flickr.com/6014/5957702621_8c44cc147e.jpg', N'http://farm7.static.flickr.com/6014/5957702621_8c44cc147e_m.jpg', N'http://farm7.static.flickr.com/6014/5957702621_8c44cc147e_t.jpg', N'http://farm7.static.flickr.com/6014/5957702621_8c44cc147e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (199, N'5957703323', NULL, NULL, N'http://farm7.static.flickr.com/6142/5957703323_aff1ec0aac_b.jpg', N'http://farm7.static.flickr.com/6142/5957703323_aff1ec0aac.jpg', N'http://farm7.static.flickr.com/6142/5957703323_aff1ec0aac_m.jpg', N'http://farm7.static.flickr.com/6142/5957703323_aff1ec0aac_t.jpg', N'http://farm7.static.flickr.com/6142/5957703323_aff1ec0aac_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (200, N'5958265098', NULL, NULL, N'http://farm7.static.flickr.com/6018/5958265098_daecbbf92c_b.jpg', N'http://farm7.static.flickr.com/6018/5958265098_daecbbf92c.jpg', N'http://farm7.static.flickr.com/6018/5958265098_daecbbf92c_m.jpg', N'http://farm7.static.flickr.com/6018/5958265098_daecbbf92c_t.jpg', N'http://farm7.static.flickr.com/6018/5958265098_daecbbf92c_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (201, N'5957713073', NULL, NULL, N'http://farm7.static.flickr.com/6141/5957713073_85ee316435_b.jpg', N'http://farm7.static.flickr.com/6141/5957713073_85ee316435.jpg', N'http://farm7.static.flickr.com/6141/5957713073_85ee316435_m.jpg', N'http://farm7.static.flickr.com/6141/5957713073_85ee316435_t.jpg', N'http://farm7.static.flickr.com/6141/5957713073_85ee316435_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (202, N'5957908449', NULL, NULL, N'http://farm7.static.flickr.com/6124/5957908449_e20b799aed_b.jpg', N'http://farm7.static.flickr.com/6124/5957908449_e20b799aed.jpg', N'http://farm7.static.flickr.com/6124/5957908449_e20b799aed_m.jpg', N'http://farm7.static.flickr.com/6124/5957908449_e20b799aed_t.jpg', N'http://farm7.static.flickr.com/6124/5957908449_e20b799aed_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (203, N'5959073606', NULL, NULL, N'http://farm7.static.flickr.com/6003/5959073606_8eda2c96f2_b.jpg', N'http://farm7.static.flickr.com/6003/5959073606_8eda2c96f2.jpg', N'http://farm7.static.flickr.com/6003/5959073606_8eda2c96f2_m.jpg', N'http://farm7.static.flickr.com/6003/5959073606_8eda2c96f2_t.jpg', N'http://farm7.static.flickr.com/6003/5959073606_8eda2c96f2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (204, N'5958551211', NULL, NULL, N'http://farm7.static.flickr.com/6137/5958551211_07e03a1932_b.jpg', N'http://farm7.static.flickr.com/6137/5958551211_07e03a1932.jpg', N'http://farm7.static.flickr.com/6137/5958551211_07e03a1932_m.jpg', N'http://farm7.static.flickr.com/6137/5958551211_07e03a1932_t.jpg', N'http://farm7.static.flickr.com/6137/5958551211_07e03a1932_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (205, N'5959112390', NULL, NULL, N'http://farm7.static.flickr.com/6145/5959112390_0c7a022c87_b.jpg', N'http://farm7.static.flickr.com/6145/5959112390_0c7a022c87.jpg', N'http://farm7.static.flickr.com/6145/5959112390_0c7a022c87_m.jpg', N'http://farm7.static.flickr.com/6145/5959112390_0c7a022c87_t.jpg', N'http://farm7.static.flickr.com/6145/5959112390_0c7a022c87_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (207, N'5959116014', NULL, NULL, N'http://farm7.static.flickr.com/6006/5959116014_5c5cfa381e_b.jpg', N'http://farm7.static.flickr.com/6006/5959116014_5c5cfa381e.jpg', N'http://farm7.static.flickr.com/6006/5959116014_5c5cfa381e_m.jpg', N'http://farm7.static.flickr.com/6006/5959116014_5c5cfa381e_t.jpg', N'http://farm7.static.flickr.com/6006/5959116014_5c5cfa381e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (208, N'5959117992', NULL, NULL, N'http://farm7.static.flickr.com/6003/5959117992_3c8ef501cb_b.jpg', N'http://farm7.static.flickr.com/6003/5959117992_3c8ef501cb.jpg', N'http://farm7.static.flickr.com/6003/5959117992_3c8ef501cb_m.jpg', N'http://farm7.static.flickr.com/6003/5959117992_3c8ef501cb_t.jpg', N'http://farm7.static.flickr.com/6003/5959117992_3c8ef501cb_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (209, N'5958560801', NULL, NULL, N'http://farm7.static.flickr.com/6126/5958560801_d612d53324_b.jpg', N'http://farm7.static.flickr.com/6126/5958560801_d612d53324.jpg', N'http://farm7.static.flickr.com/6126/5958560801_d612d53324_m.jpg', N'http://farm7.static.flickr.com/6126/5958560801_d612d53324_t.jpg', N'http://farm7.static.flickr.com/6126/5958560801_d612d53324_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (210, N'5959119650', NULL, NULL, N'http://farm7.static.flickr.com/6147/5959119650_5c5af7eb95_b.jpg', N'http://farm7.static.flickr.com/6147/5959119650_5c5af7eb95.jpg', N'http://farm7.static.flickr.com/6147/5959119650_5c5af7eb95_m.jpg', N'http://farm7.static.flickr.com/6147/5959119650_5c5af7eb95_t.jpg', N'http://farm7.static.flickr.com/6147/5959119650_5c5af7eb95_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (212, N'5961590793', NULL, NULL, N'http://farm7.static.flickr.com/6018/5961590793_57c9f4a9ef_b.jpg', N'http://farm7.static.flickr.com/6018/5961590793_57c9f4a9ef.jpg', N'http://farm7.static.flickr.com/6018/5961590793_57c9f4a9ef_m.jpg', N'http://farm7.static.flickr.com/6018/5961590793_57c9f4a9ef_t.jpg', N'http://farm7.static.flickr.com/6018/5961590793_57c9f4a9ef_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (213, N'5961591811', NULL, NULL, N'http://farm7.static.flickr.com/6147/5961591811_9d0d9be6bd_b.jpg', N'http://farm7.static.flickr.com/6147/5961591811_9d0d9be6bd.jpg', N'http://farm7.static.flickr.com/6147/5961591811_9d0d9be6bd_m.jpg', N'http://farm7.static.flickr.com/6147/5961591811_9d0d9be6bd_t.jpg', N'http://farm7.static.flickr.com/6147/5961591811_9d0d9be6bd_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (217, N'5964196098', NULL, NULL, N'http://farm7.static.flickr.com/6014/5964196098_cb36a39644_b.jpg', N'http://farm7.static.flickr.com/6014/5964196098_cb36a39644.jpg', N'http://farm7.static.flickr.com/6014/5964196098_cb36a39644_m.jpg', N'http://farm7.static.flickr.com/6014/5964196098_cb36a39644_t.jpg', N'http://farm7.static.flickr.com/6014/5964196098_cb36a39644_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (218, N'5963638501', NULL, NULL, N'http://farm7.static.flickr.com/6028/5963638501_293b8e07be_b.jpg', N'http://farm7.static.flickr.com/6028/5963638501_293b8e07be.jpg', N'http://farm7.static.flickr.com/6028/5963638501_293b8e07be_m.jpg', N'http://farm7.static.flickr.com/6028/5963638501_293b8e07be_t.jpg', N'http://farm7.static.flickr.com/6028/5963638501_293b8e07be_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (219, N'5964197026', NULL, NULL, N'http://farm7.static.flickr.com/6001/5964197026_2a3f4d2fc5_b.jpg', N'http://farm7.static.flickr.com/6001/5964197026_2a3f4d2fc5.jpg', N'http://farm7.static.flickr.com/6001/5964197026_2a3f4d2fc5_m.jpg', N'http://farm7.static.flickr.com/6001/5964197026_2a3f4d2fc5_t.jpg', N'http://farm7.static.flickr.com/6001/5964197026_2a3f4d2fc5_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (222, N'5963643269', NULL, NULL, N'http://farm7.static.flickr.com/6132/5963643269_aec3b137d8_b.jpg', N'http://farm7.static.flickr.com/6132/5963643269_aec3b137d8.jpg', N'http://farm7.static.flickr.com/6132/5963643269_aec3b137d8_m.jpg', N'http://farm7.static.flickr.com/6132/5963643269_aec3b137d8_t.jpg', N'http://farm7.static.flickr.com/6132/5963643269_aec3b137d8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (224, N'5963644429', NULL, NULL, N'http://farm7.static.flickr.com/6144/5963644429_c57543d8d9_b.jpg', N'http://farm7.static.flickr.com/6144/5963644429_c57543d8d9.jpg', N'http://farm7.static.flickr.com/6144/5963644429_c57543d8d9_m.jpg', N'http://farm7.static.flickr.com/6144/5963644429_c57543d8d9_t.jpg', N'http://farm7.static.flickr.com/6144/5963644429_c57543d8d9_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (225, N'5963644959', NULL, NULL, N'http://farm7.static.flickr.com/6020/5963644959_eee97e243e_b.jpg', N'http://farm7.static.flickr.com/6020/5963644959_eee97e243e.jpg', N'http://farm7.static.flickr.com/6020/5963644959_eee97e243e_m.jpg', N'http://farm7.static.flickr.com/6020/5963644959_eee97e243e_t.jpg', N'http://farm7.static.flickr.com/6020/5963644959_eee97e243e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (226, N'5963650341', NULL, NULL, N'http://farm7.static.flickr.com/6001/5963650341_ec5f85e5e8_b.jpg', N'http://farm7.static.flickr.com/6001/5963650341_ec5f85e5e8.jpg', N'http://farm7.static.flickr.com/6001/5963650341_ec5f85e5e8_m.jpg', N'http://farm7.static.flickr.com/6001/5963650341_ec5f85e5e8_t.jpg', N'http://farm7.static.flickr.com/6001/5963650341_ec5f85e5e8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (227, N'5963650893', NULL, NULL, N'http://farm7.static.flickr.com/6030/5963650893_a2ee283794_b.jpg', N'http://farm7.static.flickr.com/6030/5963650893_a2ee283794.jpg', N'http://farm7.static.flickr.com/6030/5963650893_a2ee283794_m.jpg', N'http://farm7.static.flickr.com/6030/5963650893_a2ee283794_t.jpg', N'http://farm7.static.flickr.com/6030/5963650893_a2ee283794_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (228, N'5964209646', NULL, NULL, N'http://farm7.static.flickr.com/6010/5964209646_26169f4424_b.jpg', N'http://farm7.static.flickr.com/6010/5964209646_26169f4424.jpg', N'http://farm7.static.flickr.com/6010/5964209646_26169f4424_m.jpg', N'http://farm7.static.flickr.com/6010/5964209646_26169f4424_t.jpg', N'http://farm7.static.flickr.com/6010/5964209646_26169f4424_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (229, N'5963656475', NULL, NULL, N'http://farm7.static.flickr.com/6029/5963656475_e22d8d2397_b.jpg', N'http://farm7.static.flickr.com/6029/5963656475_e22d8d2397.jpg', N'http://farm7.static.flickr.com/6029/5963656475_e22d8d2397_m.jpg', N'http://farm7.static.flickr.com/6029/5963656475_e22d8d2397_t.jpg', N'http://farm7.static.flickr.com/6029/5963656475_e22d8d2397_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (230, N'5964215344', NULL, NULL, N'http://farm7.static.flickr.com/6149/5964215344_7f0d248e96_b.jpg', N'http://farm7.static.flickr.com/6149/5964215344_7f0d248e96.jpg', N'http://farm7.static.flickr.com/6149/5964215344_7f0d248e96_m.jpg', N'http://farm7.static.flickr.com/6149/5964215344_7f0d248e96_t.jpg', N'http://farm7.static.flickr.com/6149/5964215344_7f0d248e96_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (231, N'5963658775', NULL, NULL, N'http://farm7.static.flickr.com/6149/5963658775_40c155dfcb_b.jpg', N'http://farm7.static.flickr.com/6149/5963658775_40c155dfcb.jpg', N'http://farm7.static.flickr.com/6149/5963658775_40c155dfcb_m.jpg', N'http://farm7.static.flickr.com/6149/5963658775_40c155dfcb_t.jpg', N'http://farm7.static.flickr.com/6149/5963658775_40c155dfcb_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (232, N'5964218572', NULL, NULL, N'http://farm7.static.flickr.com/6018/5964218572_7869176f0d_b.jpg', N'http://farm7.static.flickr.com/6018/5964218572_7869176f0d.jpg', N'http://farm7.static.flickr.com/6018/5964218572_7869176f0d_m.jpg', N'http://farm7.static.flickr.com/6018/5964218572_7869176f0d_t.jpg', N'http://farm7.static.flickr.com/6018/5964218572_7869176f0d_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (233, N'5964219312', NULL, NULL, N'http://farm7.static.flickr.com/6127/5964219312_50933bd22e_b.jpg', N'http://farm7.static.flickr.com/6127/5964219312_50933bd22e.jpg', N'http://farm7.static.flickr.com/6127/5964219312_50933bd22e_m.jpg', N'http://farm7.static.flickr.com/6127/5964219312_50933bd22e_t.jpg', N'http://farm7.static.flickr.com/6127/5964219312_50933bd22e_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (234, N'5964220098', NULL, NULL, N'http://farm7.static.flickr.com/6149/5964220098_52031f4295_b.jpg', N'http://farm7.static.flickr.com/6149/5964220098_52031f4295.jpg', N'http://farm7.static.flickr.com/6149/5964220098_52031f4295_m.jpg', N'http://farm7.static.flickr.com/6149/5964220098_52031f4295_t.jpg', N'http://farm7.static.flickr.com/6149/5964220098_52031f4295_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (235, N'5964221984', NULL, NULL, N'http://farm7.static.flickr.com/6030/5964221984_d83753be45_b.jpg', N'http://farm7.static.flickr.com/6030/5964221984_d83753be45.jpg', N'http://farm7.static.flickr.com/6030/5964221984_d83753be45_m.jpg', N'http://farm7.static.flickr.com/6030/5964221984_d83753be45_t.jpg', N'http://farm7.static.flickr.com/6030/5964221984_d83753be45_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (236, N'5964226158', NULL, NULL, N'http://farm7.static.flickr.com/6030/5964226158_d2c2a53cb0_b.jpg', N'http://farm7.static.flickr.com/6030/5964226158_d2c2a53cb0.jpg', N'http://farm7.static.flickr.com/6030/5964226158_d2c2a53cb0_m.jpg', N'http://farm7.static.flickr.com/6030/5964226158_d2c2a53cb0_t.jpg', N'http://farm7.static.flickr.com/6030/5964226158_d2c2a53cb0_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (237, N'5963672987', NULL, NULL, N'http://farm7.static.flickr.com/6145/5963672987_5e2979de1b_b.jpg', N'http://farm7.static.flickr.com/6145/5963672987_5e2979de1b.jpg', N'http://farm7.static.flickr.com/6145/5963672987_5e2979de1b_m.jpg', N'http://farm7.static.flickr.com/6145/5963672987_5e2979de1b_t.jpg', N'http://farm7.static.flickr.com/6145/5963672987_5e2979de1b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (238, N'5964232266', NULL, NULL, N'http://farm7.static.flickr.com/6006/5964232266_41bf3b5a83_b.jpg', N'http://farm7.static.flickr.com/6006/5964232266_41bf3b5a83.jpg', N'http://farm7.static.flickr.com/6006/5964232266_41bf3b5a83_m.jpg', N'http://farm7.static.flickr.com/6006/5964232266_41bf3b5a83_t.jpg', N'http://farm7.static.flickr.com/6006/5964232266_41bf3b5a83_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (239, N'5963676743', NULL, NULL, N'http://farm7.static.flickr.com/6139/5963676743_8698eeb325_b.jpg', N'http://farm7.static.flickr.com/6139/5963676743_8698eeb325.jpg', N'http://farm7.static.flickr.com/6139/5963676743_8698eeb325_m.jpg', N'http://farm7.static.flickr.com/6139/5963676743_8698eeb325_t.jpg', N'http://farm7.static.flickr.com/6139/5963676743_8698eeb325_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (240, N'5964235778', NULL, NULL, N'http://farm7.static.flickr.com/6133/5964235778_38ae352afc_b.jpg', N'http://farm7.static.flickr.com/6133/5964235778_38ae352afc.jpg', N'http://farm7.static.flickr.com/6133/5964235778_38ae352afc_m.jpg', N'http://farm7.static.flickr.com/6133/5964235778_38ae352afc_t.jpg', N'http://farm7.static.flickr.com/6133/5964235778_38ae352afc_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (241, N'5964238300', NULL, NULL, N'http://farm7.static.flickr.com/6008/5964238300_ca2d6a2c11_b.jpg', N'http://farm7.static.flickr.com/6008/5964238300_ca2d6a2c11.jpg', N'http://farm7.static.flickr.com/6008/5964238300_ca2d6a2c11_m.jpg', N'http://farm7.static.flickr.com/6008/5964238300_ca2d6a2c11_t.jpg', N'http://farm7.static.flickr.com/6008/5964238300_ca2d6a2c11_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (242, N'5964239332', NULL, NULL, N'http://farm7.static.flickr.com/6007/5964239332_1fcf54f947_b.jpg', N'http://farm7.static.flickr.com/6007/5964239332_1fcf54f947.jpg', N'http://farm7.static.flickr.com/6007/5964239332_1fcf54f947_m.jpg', N'http://farm7.static.flickr.com/6007/5964239332_1fcf54f947_t.jpg', N'http://farm7.static.flickr.com/6007/5964239332_1fcf54f947_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (244, N'5963683967', NULL, NULL, N'http://farm7.static.flickr.com/6020/5963683967_b6d1157423_b.jpg', N'http://farm7.static.flickr.com/6020/5963683967_b6d1157423.jpg', N'http://farm7.static.flickr.com/6020/5963683967_b6d1157423_m.jpg', N'http://farm7.static.flickr.com/6020/5963683967_b6d1157423_t.jpg', N'http://farm7.static.flickr.com/6020/5963683967_b6d1157423_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (245, N'5963684535', NULL, NULL, N'http://farm7.static.flickr.com/6150/5963684535_f9fa5f0f04_b.jpg', N'http://farm7.static.flickr.com/6150/5963684535_f9fa5f0f04.jpg', N'http://farm7.static.flickr.com/6150/5963684535_f9fa5f0f04_m.jpg', N'http://farm7.static.flickr.com/6150/5963684535_f9fa5f0f04_t.jpg', N'http://farm7.static.flickr.com/6150/5963684535_f9fa5f0f04_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (246, N'5963685139', NULL, NULL, N'http://farm7.static.flickr.com/6130/5963685139_57938edbe4_b.jpg', N'http://farm7.static.flickr.com/6130/5963685139_57938edbe4.jpg', N'http://farm7.static.flickr.com/6130/5963685139_57938edbe4_m.jpg', N'http://farm7.static.flickr.com/6130/5963685139_57938edbe4_t.jpg', N'http://farm7.static.flickr.com/6130/5963685139_57938edbe4_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (248, N'5963723407', NULL, NULL, N'http://farm7.static.flickr.com/6025/5963723407_f01dd8abbb_b.jpg', N'http://farm7.static.flickr.com/6025/5963723407_f01dd8abbb.jpg', N'http://farm7.static.flickr.com/6025/5963723407_f01dd8abbb_m.jpg', N'http://farm7.static.flickr.com/6025/5963723407_f01dd8abbb_t.jpg', N'http://farm7.static.flickr.com/6025/5963723407_f01dd8abbb_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (249, N'5963723955', NULL, NULL, N'http://farm7.static.flickr.com/6130/5963723955_e82b0f0199_b.jpg', N'http://farm7.static.flickr.com/6130/5963723955_e82b0f0199.jpg', N'http://farm7.static.flickr.com/6130/5963723955_e82b0f0199_m.jpg', N'http://farm7.static.flickr.com/6130/5963723955_e82b0f0199_t.jpg', N'http://farm7.static.flickr.com/6130/5963723955_e82b0f0199_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (250, N'5963724525', NULL, NULL, N'http://farm7.static.flickr.com/6146/5963724525_10c735d5d2_b.jpg', N'http://farm7.static.flickr.com/6146/5963724525_10c735d5d2.jpg', N'http://farm7.static.flickr.com/6146/5963724525_10c735d5d2_m.jpg', N'http://farm7.static.flickr.com/6146/5963724525_10c735d5d2_t.jpg', N'http://farm7.static.flickr.com/6146/5963724525_10c735d5d2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (251, N'5964283890', NULL, NULL, N'http://farm7.static.flickr.com/6121/5964283890_4b54bffce8_b.jpg', N'http://farm7.static.flickr.com/6121/5964283890_4b54bffce8.jpg', N'http://farm7.static.flickr.com/6121/5964283890_4b54bffce8_m.jpg', N'http://farm7.static.flickr.com/6121/5964283890_4b54bffce8_t.jpg', N'http://farm7.static.flickr.com/6121/5964283890_4b54bffce8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (252, N'5963727263', NULL, NULL, N'http://farm7.static.flickr.com/6017/5963727263_e968743856_b.jpg', N'http://farm7.static.flickr.com/6017/5963727263_e968743856.jpg', N'http://farm7.static.flickr.com/6017/5963727263_e968743856_m.jpg', N'http://farm7.static.flickr.com/6017/5963727263_e968743856_t.jpg', N'http://farm7.static.flickr.com/6017/5963727263_e968743856_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (253, N'5963729165', NULL, NULL, N'http://farm7.static.flickr.com/6146/5963729165_0f81e9ca68_b.jpg', N'http://farm7.static.flickr.com/6146/5963729165_0f81e9ca68.jpg', N'http://farm7.static.flickr.com/6146/5963729165_0f81e9ca68_m.jpg', N'http://farm7.static.flickr.com/6146/5963729165_0f81e9ca68_t.jpg', N'http://farm7.static.flickr.com/6146/5963729165_0f81e9ca68_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (254, N'5963729811', NULL, NULL, N'http://farm7.static.flickr.com/6144/5963729811_519c598f02_b.jpg', N'http://farm7.static.flickr.com/6144/5963729811_519c598f02.jpg', N'http://farm7.static.flickr.com/6144/5963729811_519c598f02_m.jpg', N'http://farm7.static.flickr.com/6144/5963729811_519c598f02_t.jpg', N'http://farm7.static.flickr.com/6144/5963729811_519c598f02_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (255, N'5963731635', NULL, NULL, N'http://farm7.static.flickr.com/6016/5963731635_58254c1bb5_b.jpg', N'http://farm7.static.flickr.com/6016/5963731635_58254c1bb5.jpg', N'http://farm7.static.flickr.com/6016/5963731635_58254c1bb5_m.jpg', N'http://farm7.static.flickr.com/6016/5963731635_58254c1bb5_t.jpg', N'http://farm7.static.flickr.com/6016/5963731635_58254c1bb5_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (256, N'5963732259', NULL, NULL, N'http://farm7.static.flickr.com/6142/5963732259_b1f7c82656_b.jpg', N'http://farm7.static.flickr.com/6142/5963732259_b1f7c82656.jpg', N'http://farm7.static.flickr.com/6142/5963732259_b1f7c82656_m.jpg', N'http://farm7.static.flickr.com/6142/5963732259_b1f7c82656_t.jpg', N'http://farm7.static.flickr.com/6142/5963732259_b1f7c82656_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (257, N'5963732785', NULL, NULL, N'http://farm7.static.flickr.com/6004/5963732785_da9d782587_b.jpg', N'http://farm7.static.flickr.com/6004/5963732785_da9d782587.jpg', N'http://farm7.static.flickr.com/6004/5963732785_da9d782587_m.jpg', N'http://farm7.static.flickr.com/6004/5963732785_da9d782587_t.jpg', N'http://farm7.static.flickr.com/6004/5963732785_da9d782587_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (258, N'5963733331', NULL, NULL, N'http://farm7.static.flickr.com/6008/5963733331_850aeb4d10_b.jpg', N'http://farm7.static.flickr.com/6008/5963733331_850aeb4d10.jpg', N'http://farm7.static.flickr.com/6008/5963733331_850aeb4d10_m.jpg', N'http://farm7.static.flickr.com/6008/5963733331_850aeb4d10_t.jpg', N'http://farm7.static.flickr.com/6008/5963733331_850aeb4d10_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (259, N'5963734073', NULL, NULL, N'http://farm7.static.flickr.com/6028/5963734073_9ddf5cc9f8_b.jpg', N'http://farm7.static.flickr.com/6028/5963734073_9ddf5cc9f8.jpg', N'http://farm7.static.flickr.com/6028/5963734073_9ddf5cc9f8_m.jpg', N'http://farm7.static.flickr.com/6028/5963734073_9ddf5cc9f8_t.jpg', N'http://farm7.static.flickr.com/6028/5963734073_9ddf5cc9f8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (260, N'5964292204', NULL, NULL, N'http://farm7.static.flickr.com/6017/5964292204_0e12b8d330_b.jpg', N'http://farm7.static.flickr.com/6017/5964292204_0e12b8d330.jpg', N'http://farm7.static.flickr.com/6017/5964292204_0e12b8d330_m.jpg', N'http://farm7.static.flickr.com/6017/5964292204_0e12b8d330_t.jpg', N'http://farm7.static.flickr.com/6017/5964292204_0e12b8d330_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (261, N'5963736659', NULL, NULL, N'http://farm7.static.flickr.com/6004/5963736659_1be088e8b8_b.jpg', N'http://farm7.static.flickr.com/6004/5963736659_1be088e8b8.jpg', N'http://farm7.static.flickr.com/6004/5963736659_1be088e8b8_m.jpg', N'http://farm7.static.flickr.com/6004/5963736659_1be088e8b8_t.jpg', N'http://farm7.static.flickr.com/6004/5963736659_1be088e8b8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (262, N'5964294980', NULL, NULL, N'http://farm7.static.flickr.com/6003/5964294980_4515ecfa11_b.jpg', N'http://farm7.static.flickr.com/6003/5964294980_4515ecfa11.jpg', N'http://farm7.static.flickr.com/6003/5964294980_4515ecfa11_m.jpg', N'http://farm7.static.flickr.com/6003/5964294980_4515ecfa11_t.jpg', N'http://farm7.static.flickr.com/6003/5964294980_4515ecfa11_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (263, N'5964299780', NULL, NULL, N'http://farm7.static.flickr.com/6001/5964299780_2c24c86461_b.jpg', N'http://farm7.static.flickr.com/6001/5964299780_2c24c86461.jpg', N'http://farm7.static.flickr.com/6001/5964299780_2c24c86461_m.jpg', N'http://farm7.static.flickr.com/6001/5964299780_2c24c86461_t.jpg', N'http://farm7.static.flickr.com/6001/5964299780_2c24c86461_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (264, N'5964302974', NULL, NULL, N'http://farm7.static.flickr.com/6012/5964302974_640ae9f92f_b.jpg', N'http://farm7.static.flickr.com/6012/5964302974_640ae9f92f.jpg', N'http://farm7.static.flickr.com/6012/5964302974_640ae9f92f_m.jpg', N'http://farm7.static.flickr.com/6012/5964302974_640ae9f92f_t.jpg', N'http://farm7.static.flickr.com/6012/5964302974_640ae9f92f_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (268, N'5963763763', NULL, NULL, N'http://farm7.static.flickr.com/6132/5963763763_666d5058bc_b.jpg', N'http://farm7.static.flickr.com/6132/5963763763_666d5058bc.jpg', N'http://farm7.static.flickr.com/6132/5963763763_666d5058bc_m.jpg', N'http://farm7.static.flickr.com/6132/5963763763_666d5058bc_t.jpg', N'http://farm7.static.flickr.com/6132/5963763763_666d5058bc_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (269, N'5964322434', NULL, NULL, N'http://farm7.static.flickr.com/6018/5964322434_c161d5ebee_b.jpg', N'http://farm7.static.flickr.com/6018/5964322434_c161d5ebee.jpg', N'http://farm7.static.flickr.com/6018/5964322434_c161d5ebee_m.jpg', N'http://farm7.static.flickr.com/6018/5964322434_c161d5ebee_t.jpg', N'http://farm7.static.flickr.com/6018/5964322434_c161d5ebee_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (270, N'5963764987', NULL, NULL, N'http://farm7.static.flickr.com/6139/5963764987_021d04c5a8_b.jpg', N'http://farm7.static.flickr.com/6139/5963764987_021d04c5a8.jpg', N'http://farm7.static.flickr.com/6139/5963764987_021d04c5a8_m.jpg', N'http://farm7.static.flickr.com/6139/5963764987_021d04c5a8_t.jpg', N'http://farm7.static.flickr.com/6139/5963764987_021d04c5a8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (271, N'5964323656', NULL, NULL, N'http://farm7.static.flickr.com/6138/5964323656_14cd73867b_b.jpg', N'http://farm7.static.flickr.com/6138/5964323656_14cd73867b.jpg', N'http://farm7.static.flickr.com/6138/5964323656_14cd73867b_m.jpg', N'http://farm7.static.flickr.com/6138/5964323656_14cd73867b_t.jpg', N'http://farm7.static.flickr.com/6138/5964323656_14cd73867b_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (272, N'5964324518', NULL, NULL, N'http://farm7.static.flickr.com/6148/5964324518_c1d69d13ba_b.jpg', N'http://farm7.static.flickr.com/6148/5964324518_c1d69d13ba.jpg', N'http://farm7.static.flickr.com/6148/5964324518_c1d69d13ba_m.jpg', N'http://farm7.static.flickr.com/6148/5964324518_c1d69d13ba_t.jpg', N'http://farm7.static.flickr.com/6148/5964324518_c1d69d13ba_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (273, N'5964325330', NULL, NULL, N'http://farm7.static.flickr.com/6014/5964325330_936ac7e8de_b.jpg', N'http://farm7.static.flickr.com/6014/5964325330_936ac7e8de.jpg', N'http://farm7.static.flickr.com/6014/5964325330_936ac7e8de_m.jpg', N'http://farm7.static.flickr.com/6014/5964325330_936ac7e8de_t.jpg', N'http://farm7.static.flickr.com/6014/5964325330_936ac7e8de_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (274, N'5963768333', NULL, NULL, N'http://farm7.static.flickr.com/6123/5963768333_3a57cda553_b.jpg', N'http://farm7.static.flickr.com/6123/5963768333_3a57cda553.jpg', N'http://farm7.static.flickr.com/6123/5963768333_3a57cda553_m.jpg', N'http://farm7.static.flickr.com/6123/5963768333_3a57cda553_t.jpg', N'http://farm7.static.flickr.com/6123/5963768333_3a57cda553_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (275, N'5963769595', NULL, NULL, N'http://farm7.static.flickr.com/6133/5963769595_b007b6e7e9_b.jpg', N'http://farm7.static.flickr.com/6133/5963769595_b007b6e7e9.jpg', N'http://farm7.static.flickr.com/6133/5963769595_b007b6e7e9_m.jpg', N'http://farm7.static.flickr.com/6133/5963769595_b007b6e7e9_t.jpg', N'http://farm7.static.flickr.com/6133/5963769595_b007b6e7e9_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (276, N'5963770377', NULL, NULL, N'http://farm7.static.flickr.com/6023/5963770377_a879eed720_b.jpg', N'http://farm7.static.flickr.com/6023/5963770377_a879eed720.jpg', N'http://farm7.static.flickr.com/6023/5963770377_a879eed720_m.jpg', N'http://farm7.static.flickr.com/6023/5963770377_a879eed720_t.jpg', N'http://farm7.static.flickr.com/6023/5963770377_a879eed720_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (277, N'5965075730', NULL, NULL, N'http://farm7.static.flickr.com/6127/5965075730_5e5de18d6d_b.jpg', N'http://farm7.static.flickr.com/6127/5965075730_5e5de18d6d.jpg', N'http://farm7.static.flickr.com/6127/5965075730_5e5de18d6d_m.jpg', N'http://farm7.static.flickr.com/6127/5965075730_5e5de18d6d_t.jpg', N'http://farm7.static.flickr.com/6127/5965075730_5e5de18d6d_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (278, N'5965257938', NULL, NULL, N'http://farm7.static.flickr.com/6130/5965257938_f6e00ae363_b.jpg', N'http://farm7.static.flickr.com/6130/5965257938_f6e00ae363.jpg', N'http://farm7.static.flickr.com/6130/5965257938_f6e00ae363_m.jpg', N'http://farm7.static.flickr.com/6130/5965257938_f6e00ae363_t.jpg', N'http://farm7.static.flickr.com/6130/5965257938_f6e00ae363_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (279, N'5964708101', NULL, NULL, N'http://farm7.static.flickr.com/6013/5964708101_d1d487eebf_b.jpg', N'http://farm7.static.flickr.com/6013/5964708101_d1d487eebf.jpg', N'http://farm7.static.flickr.com/6013/5964708101_d1d487eebf_m.jpg', N'http://farm7.static.flickr.com/6013/5964708101_d1d487eebf_t.jpg', N'http://farm7.static.flickr.com/6013/5964708101_d1d487eebf_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (280, N'5965264748', NULL, NULL, N'http://farm7.static.flickr.com/6026/5965264748_9394ea7d0a_b.jpg', N'http://farm7.static.flickr.com/6026/5965264748_9394ea7d0a.jpg', N'http://farm7.static.flickr.com/6026/5965264748_9394ea7d0a_m.jpg', N'http://farm7.static.flickr.com/6026/5965264748_9394ea7d0a_t.jpg', N'http://farm7.static.flickr.com/6026/5965264748_9394ea7d0a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (281, N'5964709565', NULL, NULL, N'http://farm7.static.flickr.com/6020/5964709565_81d4e07538_b.jpg', N'http://farm7.static.flickr.com/6020/5964709565_81d4e07538.jpg', N'http://farm7.static.flickr.com/6020/5964709565_81d4e07538_m.jpg', N'http://farm7.static.flickr.com/6020/5964709565_81d4e07538_t.jpg', N'http://farm7.static.flickr.com/6020/5964709565_81d4e07538_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (282, N'5965271868', NULL, NULL, N'http://farm7.static.flickr.com/6007/5965271868_f0af7b2af9_b.jpg', N'http://farm7.static.flickr.com/6007/5965271868_f0af7b2af9.jpg', N'http://farm7.static.flickr.com/6007/5965271868_f0af7b2af9_m.jpg', N'http://farm7.static.flickr.com/6007/5965271868_f0af7b2af9_t.jpg', N'http://farm7.static.flickr.com/6007/5965271868_f0af7b2af9_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (283, N'5965277532', NULL, NULL, N'http://farm7.static.flickr.com/6017/5965277532_ff55b48433_b.jpg', N'http://farm7.static.flickr.com/6017/5965277532_ff55b48433.jpg', N'http://farm7.static.flickr.com/6017/5965277532_ff55b48433_m.jpg', N'http://farm7.static.flickr.com/6017/5965277532_ff55b48433_t.jpg', N'http://farm7.static.flickr.com/6017/5965277532_ff55b48433_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (284, N'5975057567', NULL, NULL, N'http://farm7.static.flickr.com/6006/5975057567_bf0c078f31_b.jpg', N'http://farm7.static.flickr.com/6006/5975057567_bf0c078f31.jpg', N'http://farm7.static.flickr.com/6006/5975057567_bf0c078f31_m.jpg', N'http://farm7.static.flickr.com/6006/5975057567_bf0c078f31_t.jpg', N'http://farm7.static.flickr.com/6006/5975057567_bf0c078f31_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (285, N'5975058747', NULL, NULL, N'http://farm7.static.flickr.com/6141/5975058747_4e7203e7a4_b.jpg', N'http://farm7.static.flickr.com/6141/5975058747_4e7203e7a4.jpg', N'http://farm7.static.flickr.com/6141/5975058747_4e7203e7a4_m.jpg', N'http://farm7.static.flickr.com/6141/5975058747_4e7203e7a4_t.jpg', N'http://farm7.static.flickr.com/6141/5975058747_4e7203e7a4_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (286, N'5975097261', NULL, NULL, N'http://farm7.static.flickr.com/6127/5975097261_a37aa3bf62_b.jpg', N'http://farm7.static.flickr.com/6127/5975097261_a37aa3bf62.jpg', N'http://farm7.static.flickr.com/6127/5975097261_a37aa3bf62_m.jpg', N'http://farm7.static.flickr.com/6127/5975097261_a37aa3bf62_t.jpg', N'http://farm7.static.flickr.com/6127/5975097261_a37aa3bf62_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (287, N'5975673794', NULL, NULL, N'http://farm7.static.flickr.com/6135/5975673794_e48d500bba_b.jpg', N'http://farm7.static.flickr.com/6135/5975673794_e48d500bba.jpg', N'http://farm7.static.flickr.com/6135/5975673794_e48d500bba_m.jpg', N'http://farm7.static.flickr.com/6135/5975673794_e48d500bba_t.jpg', N'http://farm7.static.flickr.com/6135/5975673794_e48d500bba_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (288, N'5975684044', NULL, NULL, N'http://farm7.static.flickr.com/6006/5975684044_9c04646408_b.jpg', N'http://farm7.static.flickr.com/6006/5975684044_9c04646408.jpg', N'http://farm7.static.flickr.com/6006/5975684044_9c04646408_m.jpg', N'http://farm7.static.flickr.com/6006/5975684044_9c04646408_t.jpg', N'http://farm7.static.flickr.com/6006/5975684044_9c04646408_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (289, N'5975127431', NULL, NULL, N'http://farm7.static.flickr.com/6022/5975127431_ce312c7739_b.jpg', N'http://farm7.static.flickr.com/6022/5975127431_ce312c7739.jpg', N'http://farm7.static.flickr.com/6022/5975127431_ce312c7739_m.jpg', N'http://farm7.static.flickr.com/6022/5975127431_ce312c7739_t.jpg', N'http://farm7.static.flickr.com/6022/5975127431_ce312c7739_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (299, N'5978444952', NULL, NULL, N'http://farm7.static.flickr.com/6030/5978444952_0daa1ebf36_b.jpg', N'http://farm7.static.flickr.com/6030/5978444952_0daa1ebf36.jpg', N'http://farm7.static.flickr.com/6030/5978444952_0daa1ebf36_m.jpg', N'http://farm7.static.flickr.com/6030/5978444952_0daa1ebf36_t.jpg', N'http://farm7.static.flickr.com/6030/5978444952_0daa1ebf36_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (300, N'5977887037', NULL, NULL, N'http://farm7.static.flickr.com/6021/5977887037_39f4e06522_b.jpg', N'http://farm7.static.flickr.com/6021/5977887037_39f4e06522.jpg', N'http://farm7.static.flickr.com/6021/5977887037_39f4e06522_m.jpg', N'http://farm7.static.flickr.com/6021/5977887037_39f4e06522_t.jpg', N'http://farm7.static.flickr.com/6021/5977887037_39f4e06522_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (301, N'5978447488', NULL, NULL, N'http://farm7.static.flickr.com/6146/5978447488_bb91b6742a_b.jpg', N'http://farm7.static.flickr.com/6146/5978447488_bb91b6742a.jpg', N'http://farm7.static.flickr.com/6146/5978447488_bb91b6742a_m.jpg', N'http://farm7.static.flickr.com/6146/5978447488_bb91b6742a_t.jpg', N'http://farm7.static.flickr.com/6146/5978447488_bb91b6742a_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (302, N'5978448894', NULL, NULL, N'http://farm7.static.flickr.com/6028/5978448894_6c47cd11d6_b.jpg', N'http://farm7.static.flickr.com/6028/5978448894_6c47cd11d6.jpg', N'http://farm7.static.flickr.com/6028/5978448894_6c47cd11d6_m.jpg', N'http://farm7.static.flickr.com/6028/5978448894_6c47cd11d6_t.jpg', N'http://farm7.static.flickr.com/6028/5978448894_6c47cd11d6_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (303, N'5978449714', NULL, NULL, N'http://farm7.static.flickr.com/6142/5978449714_3899e59f14_b.jpg', N'http://farm7.static.flickr.com/6142/5978449714_3899e59f14.jpg', N'http://farm7.static.flickr.com/6142/5978449714_3899e59f14_m.jpg', N'http://farm7.static.flickr.com/6142/5978449714_3899e59f14_t.jpg', N'http://farm7.static.flickr.com/6142/5978449714_3899e59f14_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (305, N'5977894435', NULL, NULL, N'http://farm7.static.flickr.com/6012/5977894435_f14d7a35eb_b.jpg', N'http://farm7.static.flickr.com/6012/5977894435_f14d7a35eb.jpg', N'http://farm7.static.flickr.com/6012/5977894435_f14d7a35eb_m.jpg', N'http://farm7.static.flickr.com/6012/5977894435_f14d7a35eb_t.jpg', N'http://farm7.static.flickr.com/6012/5977894435_f14d7a35eb_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (306, N'5981174889', NULL, NULL, N'http://farm7.static.flickr.com/6014/5981174889_2ee52c5c42_b.jpg', N'http://farm7.static.flickr.com/6014/5981174889_2ee52c5c42.jpg', N'http://farm7.static.flickr.com/6014/5981174889_2ee52c5c42_m.jpg', N'http://farm7.static.flickr.com/6014/5981174889_2ee52c5c42_t.jpg', N'http://farm7.static.flickr.com/6014/5981174889_2ee52c5c42_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (307, N'5981783122', NULL, NULL, N'http://farm7.static.flickr.com/6128/5981783122_100a080f82_b.jpg', N'http://farm7.static.flickr.com/6128/5981783122_100a080f82.jpg', N'http://farm7.static.flickr.com/6128/5981783122_100a080f82_m.jpg', N'http://farm7.static.flickr.com/6128/5981783122_100a080f82_t.jpg', N'http://farm7.static.flickr.com/6128/5981783122_100a080f82_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (309, N'5981293391', NULL, NULL, N'http://farm7.static.flickr.com/6122/5981293391_86a5d05e62_b.jpg', N'http://farm7.static.flickr.com/6122/5981293391_86a5d05e62.jpg', N'http://farm7.static.flickr.com/6122/5981293391_86a5d05e62_m.jpg', N'http://farm7.static.flickr.com/6122/5981293391_86a5d05e62_t.jpg', N'http://farm7.static.flickr.com/6122/5981293391_86a5d05e62_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (310, N'5981294117', NULL, NULL, N'http://farm7.static.flickr.com/6143/5981294117_11a4e2d0cc_b.jpg', N'http://farm7.static.flickr.com/6143/5981294117_11a4e2d0cc.jpg', N'http://farm7.static.flickr.com/6143/5981294117_11a4e2d0cc_m.jpg', N'http://farm7.static.flickr.com/6143/5981294117_11a4e2d0cc_t.jpg', N'http://farm7.static.flickr.com/6143/5981294117_11a4e2d0cc_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (311, N'5981855896', NULL, NULL, N'http://farm7.static.flickr.com/6024/5981855896_31d3846ff8_b.jpg', N'http://farm7.static.flickr.com/6024/5981855896_31d3846ff8.jpg', N'http://farm7.static.flickr.com/6024/5981855896_31d3846ff8_m.jpg', N'http://farm7.static.flickr.com/6024/5981855896_31d3846ff8_t.jpg', N'http://farm7.static.flickr.com/6024/5981855896_31d3846ff8_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (312, N'5981308685', NULL, NULL, N'http://farm7.static.flickr.com/6128/5981308685_d8eee37cd2_b.jpg', N'http://farm7.static.flickr.com/6128/5981308685_d8eee37cd2.jpg', N'http://farm7.static.flickr.com/6128/5981308685_d8eee37cd2_m.jpg', N'http://farm7.static.flickr.com/6128/5981308685_d8eee37cd2_t.jpg', N'http://farm7.static.flickr.com/6128/5981308685_d8eee37cd2_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (313, N'5981877394', NULL, NULL, N'http://farm7.static.flickr.com/6020/5981877394_ef54df4abd_b.jpg', N'http://farm7.static.flickr.com/6020/5981877394_ef54df4abd.jpg', N'http://farm7.static.flickr.com/6020/5981877394_ef54df4abd_m.jpg', N'http://farm7.static.flickr.com/6020/5981877394_ef54df4abd_t.jpg', N'http://farm7.static.flickr.com/6020/5981877394_ef54df4abd_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (315, N'5981330641', NULL, NULL, N'http://farm7.static.flickr.com/6003/5981330641_07ca0936ba_b.jpg', N'http://farm7.static.flickr.com/6003/5981330641_07ca0936ba.jpg', N'http://farm7.static.flickr.com/6003/5981330641_07ca0936ba_m.jpg', N'http://farm7.static.flickr.com/6003/5981330641_07ca0936ba_t.jpg', N'http://farm7.static.flickr.com/6003/5981330641_07ca0936ba_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (316, N'5981336447', NULL, NULL, N'http://farm7.static.flickr.com/6148/5981336447_223ac3bdcd_b.jpg', N'http://farm7.static.flickr.com/6148/5981336447_223ac3bdcd.jpg', N'http://farm7.static.flickr.com/6148/5981336447_223ac3bdcd_m.jpg', N'http://farm7.static.flickr.com/6148/5981336447_223ac3bdcd_t.jpg', N'http://farm7.static.flickr.com/6148/5981336447_223ac3bdcd_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (317, N'5981901006', NULL, NULL, N'http://farm7.static.flickr.com/6017/5981901006_6845481ed7_b.jpg', N'http://farm7.static.flickr.com/6017/5981901006_6845481ed7.jpg', N'http://farm7.static.flickr.com/6017/5981901006_6845481ed7_m.jpg', N'http://farm7.static.flickr.com/6017/5981901006_6845481ed7_t.jpg', N'http://farm7.static.flickr.com/6017/5981901006_6845481ed7_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (318, N'5981903788', NULL, NULL, N'http://farm7.static.flickr.com/6014/5981903788_d72bf94208_b.jpg', N'http://farm7.static.flickr.com/6014/5981903788_d72bf94208.jpg', N'http://farm7.static.flickr.com/6014/5981903788_d72bf94208_m.jpg', N'http://farm7.static.flickr.com/6014/5981903788_d72bf94208_t.jpg', N'http://farm7.static.flickr.com/6014/5981903788_d72bf94208_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (319, N'5981526679', NULL, NULL, N'http://farm7.static.flickr.com/6005/5981526679_ff186bfd40_b.jpg', N'http://farm7.static.flickr.com/6005/5981526679_ff186bfd40.jpg', N'http://farm7.static.flickr.com/6005/5981526679_ff186bfd40_m.jpg', N'http://farm7.static.flickr.com/6005/5981526679_ff186bfd40_t.jpg', N'http://farm7.static.flickr.com/6005/5981526679_ff186bfd40_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (320, N'5981527317', NULL, NULL, N'http://farm7.static.flickr.com/6018/5981527317_7aa8f242db_b.jpg', N'http://farm7.static.flickr.com/6018/5981527317_7aa8f242db.jpg', N'http://farm7.static.flickr.com/6018/5981527317_7aa8f242db_m.jpg', N'http://farm7.static.flickr.com/6018/5981527317_7aa8f242db_t.jpg', N'http://farm7.static.flickr.com/6018/5981527317_7aa8f242db_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (321, N'5982087582', NULL, NULL, N'http://farm7.static.flickr.com/6138/5982087582_fd19162299_b.jpg', N'http://farm7.static.flickr.com/6138/5982087582_fd19162299.jpg', N'http://farm7.static.flickr.com/6138/5982087582_fd19162299_m.jpg', N'http://farm7.static.flickr.com/6138/5982087582_fd19162299_t.jpg', N'http://farm7.static.flickr.com/6138/5982087582_fd19162299_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (322, N'5981528837', NULL, NULL, N'http://farm7.static.flickr.com/6144/5981528837_92157b8147_b.jpg', N'http://farm7.static.flickr.com/6144/5981528837_92157b8147.jpg', N'http://farm7.static.flickr.com/6144/5981528837_92157b8147_m.jpg', N'http://farm7.static.flickr.com/6144/5981528837_92157b8147_t.jpg', N'http://farm7.static.flickr.com/6144/5981528837_92157b8147_s.jpg')
INSERT INTO [dbo].[Photos] ([PhotoID], [PhotoFlickrID], [PhotoCaption], [PhotoSponsorID], [PhotoLargeUrl], [PhotoMediumUrl], [PhotoSmallUrl], [PhotoThumbnailUrl], [PhotoSquareThumbnailUrl]) VALUES (323, N'5988723110', NULL, NULL, N'http://farm7.static.flickr.com/6142/5988723110_9e5d6d07ef_b.jpg', N'http://farm7.static.flickr.com/6142/5988723110_9e5d6d07ef.jpg', N'http://farm7.static.flickr.com/6142/5988723110_9e5d6d07ef_m.jpg', N'http://farm7.static.flickr.com/6142/5988723110_9e5d6d07ef_t.jpg', N'http://farm7.static.flickr.com/6142/5988723110_9e5d6d07ef_s.jpg')
SET IDENTITY_INSERT [dbo].[Photos] OFF

-- Add 5 rows to [dbo].[Temperaments]
SET IDENTITY_INSERT [dbo].[Temperaments] ON
INSERT INTO [dbo].[Temperaments] ([TemperamentID], [TemperamentName], [TemperamentSeverity]) VALUES (1, N'Unknown', 0)
INSERT INTO [dbo].[Temperaments] ([TemperamentID], [TemperamentName], [TemperamentSeverity]) VALUES (2, N'Mild', 1)
INSERT INTO [dbo].[Temperaments] ([TemperamentID], [TemperamentName], [TemperamentSeverity]) VALUES (3, N'Slightly Agressive', 2)
INSERT INTO [dbo].[Temperaments] ([TemperamentID], [TemperamentName], [TemperamentSeverity]) VALUES (4, N'Agressive', 3)
INSERT INTO [dbo].[Temperaments] ([TemperamentID], [TemperamentName], [TemperamentSeverity]) VALUES (5, N'Very Agressive', 4)
SET IDENTITY_INSERT [dbo].[Temperaments] OFF

-- Add 1 row to [dbo].[aspnet_Applications]
INSERT INTO [dbo].[aspnet_Applications] ([ApplicationId], [ApplicationName], [LoweredApplicationName], [Description]) VALUES ('9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'/', N'/', NULL)

-- Add 3 rows to [dbo].[aspnet_Membership]
INSERT INTO [dbo].[aspnet_Membership] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [MobilePIN], [Email], [LoweredEmail], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [Comment]) VALUES ('443db369-3957-4eb3-bfeb-23f9822c0f16', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'nWa2H+pvaS4//lFQ1FGEhGyaHgw=', 1, N'BbOB2QWIk1I6hrezNsPygg==', NULL, N'harvey_b_27@hotmail.co.uk', N'harvey_b_27@hotmail.co.uk', NULL, NULL, 1, 0, '2011-07-20 13:19:55.000', '2011-09-13 16:36:07.533', '2011-07-20 13:19:55.000', '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', NULL)
INSERT INTO [dbo].[aspnet_Membership] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [MobilePIN], [Email], [LoweredEmail], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [Comment]) VALUES ('87d59d15-0390-42d5-b35d-81508a3a1ab9', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'toGEqLuTJnIDNeaFXYPIdpqPF7g=', 1, N'Z7V3+y0e0KuEdWZMCp9i2w==', NULL, N'dom.barker808@gmail.com', N'dom.barker808@gmail.com', NULL, NULL, 1, 0, '2011-07-27 16:00:51.000', '2011-07-31 13:59:24.770', '2011-07-27 16:00:51.000', '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', NULL)
INSERT INTO [dbo].[aspnet_Membership] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [MobilePIN], [Email], [LoweredEmail], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [Comment]) VALUES ('e1148fa3-638a-4393-84dc-a00c6f554cff', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'klTD2QWRB+0gWVB/K8uIjBPgth8=', 1, N'ssHSFhTxaadqFUkoSs19Fw==', NULL, N'dom.barker808@gmail.com', N'dom.barker808@gmail.com', NULL, NULL, 1, 0, '2011-07-20 13:15:10.000', '2011-09-17 16:34:50.953', '2011-07-20 13:15:10.000', '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', 0, '1754-01-01 00:00:00.000', NULL)

-- Add 3 rows to [dbo].[aspnet_Users]
INSERT INTO [dbo].[aspnet_Users] ([UserId], [ApplicationId], [UserName], [LoweredUserName], [MobileAlias], [IsAnonymous], [LastActivityDate]) VALUES ('443db369-3957-4eb3-bfeb-23f9822c0f16', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'harvey', N'harvey', NULL, 0, '2011-09-13 16:36:07.533')
INSERT INTO [dbo].[aspnet_Users] ([UserId], [ApplicationId], [UserName], [LoweredUserName], [MobileAlias], [IsAnonymous], [LastActivityDate]) VALUES ('87d59d15-0390-42d5-b35d-81508a3a1ab9', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'dawei', N'dawei', NULL, 0, '2011-07-31 13:59:24.770')
INSERT INTO [dbo].[aspnet_Users] ([UserId], [ApplicationId], [UserName], [LoweredUserName], [MobileAlias], [IsAnonymous], [LastActivityDate]) VALUES ('e1148fa3-638a-4393-84dc-a00c6f554cff', '9d1f468f-0cb2-4d65-bb1d-7834fddfc3ac', N'dom', N'dom', NULL, 0, '2011-09-17 16:34:50.953')

-- Add 424 rows to [dbo].[Fish]
SET IDENTITY_INSERT [dbo].[Fish] ON
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (1, 1, 12, 27, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (3, 1, 13, 30, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (4, 1, 13, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (5, 1, 13, 22, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (6, 1, 13, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (7, 1, 14, 95, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (8, 1, 15, 27, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (9, 1, 16, 171, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (10, 1, 16, 149, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (11, 1, 17, 27, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (12, 1, 17, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (13, 1, 18, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (14, 1, 18, 20, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (15, 1, 18, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (16, 1, 19, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (17, 1, 19, 144, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (18, 1, 19, 145, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (19, 1, 19, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (20, 1, 20, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (21, 1, 21, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (22, 1, 21, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (23, 1, 21, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (24, 1, 21, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (25, 1, 22, 18, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (26, 1, 22, 30, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (27, 1, 22, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (28, 1, 22, 112, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (29, 1, 24, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (30, 1, 24, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (31, 1, 26, 32, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (32, 1, 26, 120, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (33, 1, 26, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (34, 1, 27, 181, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (35, 1, 28, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (36, 1, 28, 109, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (37, 1, 28, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (38, 1, 29, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (39, 1, 30, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (40, 1, 30, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (41, 1, 31, 91, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (42, 1, 31, 137, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (43, 1, 31, 180, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (44, 1, 31, 64, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (45, 1, 31, 152, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (46, 1, 32, 74, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (47, 1, 32, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (48, 1, 32, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (49, 1, 32, 181, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (50, 1, 32, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (51, 1, 32, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (52, 1, 33, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (53, 1, 34, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (54, 1, 35, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (55, 1, 35, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (56, 1, 35, 31, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (57, 1, 36, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (58, 1, 37, 15, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (59, 1, 37, 33, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (60, 1, 37, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (61, 1, 37, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (62, 1, 37, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (63, 1, 38, 52, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (64, 1, 38, 80, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (65, 1, 38, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (66, 1, 40, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (67, 1, 41, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (68, 1, 42, 162, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (69, 1, 42, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (70, 1, 43, 150, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (71, 1, 44, 150, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (72, 1, 45, 172, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (73, 1, 46, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (74, 1, 47, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (75, 1, 48, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (76, 1, 49, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (77, 1, 50, 14, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (78, 1, 50, 50, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (79, 1, 50, 123, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (80, 1, 51, 120, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (81, 2, 52, 10, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (82, 2, 52, 63, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (83, 2, 52, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (84, 2, 52, 120, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (85, 2, 52, 159, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (86, 2, 52, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (87, 2, 52, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (88, 2, 53, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (89, 2, 54, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (90, 2, 55, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (91, 2, 56, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (92, 2, 57, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (93, 2, 57, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (94, 2, 58, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (95, 2, 58, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (96, 2, 59, 176, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (97, 2, 60, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (98, 2, 61, 111, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (99, 2, 62, 111, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (100, 2, 63, 55, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (101, 2, 64, 117, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (102, 2, 65, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (103, 2, 65, 117, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (104, 2, 66, 186, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (105, 2, 66, 128, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (106, 2, 67, 127, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (107, 3, 401, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (108, 3, 401, 22, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (109, 3, 401, 27, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (110, 3, 401, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (111, 3, 401, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (112, 3, 401, 56, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (113, 3, 401, 70, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (114, 3, 401, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (115, 3, 401, 98, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (116, 3, 401, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (117, 3, 401, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (118, 3, 401, 116, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (119, 3, 401, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (120, 3, 401, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (121, 3, 401, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (122, 3, 401, 196, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (123, 3, 402, 14, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (124, 3, 402, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (125, 3, 402, 18, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (126, 3, 402, 20, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (127, 3, 402, 30, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (128, 3, 402, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (129, 3, 402, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (130, 3, 402, 56, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (131, 3, 402, 70, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (132, 3, 402, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (133, 3, 402, 82, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (134, 3, 402, 96, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (135, 3, 402, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (136, 3, 402, 112, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (137, 3, 402, 128, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (138, 3, 402, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (139, 3, 402, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (140, 3, 402, 166, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (141, 3, 402, 164, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (142, 3, 402, 168, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (143, 3, 402, 175, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (144, 3, 402, 181, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (145, 3, 402, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (146, 3, 402, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (147, 3, 402, 186, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (148, 13, 401, 1, N'&lt;p&gt;&amp;#160;The males of this species are blue bodies with a contrasting orange dorsal fin. The same orange color is shown at the end of their tails, and on the pectoral and anal fins. The blue can become very light when trying to attract a female, whilst a sub-dom will be a deep blue color. Males show faint blue barring along the body. Females of this species are either brown or a pink OB form. The females show a similar orange color in the forum of tiny specs on the body, especially at the top of their dorsal fin.&lt;/p&gt;')
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (149, 4, 403, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (150, 4, 404, 72, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (151, 4, 404, 128, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (152, 4, 404, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (153, 4, 405, 170, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (154, 4, 406, 61, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (155, 4, 407, 115, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (156, 4, 408, 100, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (157, 4, 408, 196, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (159, 4, 410, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (160, 4, 411, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (161, 4, 411, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (162, 4, 411, 171, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (163, 4, 411, 14, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (164, 4, 412, 50, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (165, 4, 413, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (166, 4, 414, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (167, 4, 415, 20, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (168, 4, 420, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (169, 4, 416, 34, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (171, 4, 418, 170, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (172, 4, 419, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (173, 4, 421, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (174, 4, 421, 117, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (176, 4, 422, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (177, 4, 422, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (178, 4, 422, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (179, 4, 423, 16, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (180, 4, 424, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (181, 4, 424, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (182, 4, 424, 145, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (183, 4, 425, 145, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (184, 4, 425, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (185, 4, 425, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (186, 4, 426, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (187, 4, 427, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (188, 4, 428, 125, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (189, 4, 429, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (190, 4, 429, 123, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (191, 4, 430, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (192, 4, 431, 52, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (193, 4, 432, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (194, 4, 433, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (195, 4, 434, 15, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (196, 4, 434, 32, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (197, 4, 434, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (198, 4, 434, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (199, 4, 434, 120, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (200, 4, 435, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (201, 4, 435, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (202, 4, 436, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (203, 4, 437, 50, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (209, 10, 497, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (210, 10, 497, 100, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (212, 10, 497, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (213, 10, 498, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (214, 5, 438, 66, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (215, 5, 438, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (216, 5, 438, 109, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (217, 5, 438, 184, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (218, 5, 439, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (219, 5, 439, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (220, 5, 439, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (221, 5, 440, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (222, 5, 441, 20, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (223, 5, 441, 33, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (224, 5, 441, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (225, 5, 441, 91, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (226, 5, 441, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (227, 5, 441, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (228, 5, 441, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (229, 5, 441, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (230, 5, 442, 140, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (231, 5, 442, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (232, 5, 442, 98, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (233, 5, 443, 133, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (234, 5, 443, 92, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (235, 5, 444, 19, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (236, 5, 444, 30, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (237, 5, 444, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (238, 5, 444, 112, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (239, 5, 444, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (240, 5, 445, 11, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (241, 5, 445, 34, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (242, 5, 445, 36, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (243, 5, 445, 52, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (244, 5, 445, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (245, 5, 445, 57, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (246, 5, 445, 72, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (247, 5, 445, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (248, 5, 445, 77, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (249, 5, 445, 80, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (250, 5, 445, 82, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (251, 5, 445, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (252, 5, 445, 90, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (253, 5, 445, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (254, 5, 445, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (255, 5, 445, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (256, 5, 445, 110, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (257, 5, 445, 113, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (259, 5, 445, 156, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (260, 5, 445, 171, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (261, 5, 445, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (262, 5, 445, 190, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (263, 5, 446, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (264, 5, 446, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (265, 5, 446, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (266, 5, 447, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (267, 5, 447, 100, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (268, 5, 448, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (269, 5, 448, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (271, 5, 450, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (272, 5, 450, 162, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (273, 5, 451, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (274, 5, 452, 52, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (275, 5, 452, 80, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (276, 5, 452, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (277, 5, 454, 22, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (278, 5, 454, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (279, 5, 455, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (280, 5, 455, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (281, 5, 456, 30, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (282, 5, 456, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (283, 5, 456, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (284, 5, 456, 60, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (285, 5, 456, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (286, 5, 456, 79, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (287, 5, 456, 112, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (288, 5, 456, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (289, 5, 456, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (290, 5, 457, 84, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (291, 5, 458, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (292, 5, 459, 82, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (293, 5, 460, 84, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (294, 5, 461, 165, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (295, 5, 461, 166, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (296, 5, 461, 186, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (297, 5, 461, 190, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (298, 5, 462, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (299, 5, 465, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (300, 5, 466, 18, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (301, 5, 466, 84, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (302, 5, 467, 66, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (303, 5, 468, 171, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (304, 5, 468, 149, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (305, 5, 469, 34, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (306, 5, 470, 126, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (307, 5, 471, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (308, 5, 471, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (309, 5, 472, 25, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (310, 5, 472, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (311, 5, 472, 85, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (312, 5, 473, 31, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (313, 5, 473, 60, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (314, 5, 473, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (315, 5, 474, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (316, 5, 475, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (317, 5, 476, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (318, 5, 477, 15, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (319, 5, 477, 33, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (320, 5, 477, 70, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (321, 5, 477, 92, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (322, 5, 477, 96, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (323, 5, 477, 123, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (324, 5, 478, 11, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (325, 5, 478, 68, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (326, 5, 478, 71, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (327, 5, 478, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (328, 5, 478, 141, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (329, 5, 478, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (330, 5, 478, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (331, 5, 479, 104, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (332, 5, 479, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (333, 5, 479, 41, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (334, 5, 480, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (335, 5, 480, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (336, 7, 481, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (337, 7, 481, 31, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (338, 7, 482, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (339, 7, 483, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (340, 7, 483, 140, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (341, 7, 483, 185, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (342, 7, 483, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (343, 7, 483, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (344, 7, 484, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (345, 7, 485, 132, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (346, 7, 486, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (347, 7, 487, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (349, 7, 489, 99, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (350, 7, 489, 91, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (352, 7, 491, 165, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (353, 7, 492, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (354, 7, 492, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (355, 7, 492, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (356, 7, 492, 133, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (357, 7, 492, 109, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (358, 7, 493, 51, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (359, 7, 494, 84, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (360, 7, 494, 84, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (361, 11, 499, 27, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (362, 11, 499, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (363, 11, 499, 128, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (364, 11, 500, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (365, 11, 501, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (368, 11, 504, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (369, 11, 504, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (370, 11, 504, 145, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (371, 11, 504, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (372, 11, 505, 50, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (373, 11, 506, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (374, 11, 507, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (375, 11, 508, 174, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (376, 11, 509, 34, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (377, 11, 510, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (378, 11, 510, 143, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (379, 11, 510, 144, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (380, 11, 510, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (381, 11, 511, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (382, 11, 511, 189, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (383, 11, 511, 42, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (384, 6, 1, 15, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (386, 6, 1, 36, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (387, 6, 1, 39, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (388, 6, 1, 52, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (389, 6, 1, 60, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (390, 6, 1, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (391, 6, 1, 80, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (392, 6, 1, 83, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (393, 6, 1, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (394, 6, 1, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (395, 6, 1, 109, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (396, 6, 1, 129, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (397, 6, 1, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (398, 6, 2, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (399, 6, 3, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (400, 6, 4, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (401, 6, 4, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (402, 6, 6, 168, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (403, 6, 7, 50, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (404, 6, 8, 7, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (405, 6, 8, 71, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (406, 6, 8, 75, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (407, 6, 8, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (408, 6, 8, 94, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (409, 6, 8, 110, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (410, 6, 8, 177, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (411, 6, 9, 103, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (412, 6, 10, 123, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (413, 6, 10, 133, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (414, 6, 10, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (415, 6, 10, 160, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (416, 6, 11, 122, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (555, 1, 12, 29, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (556, 3, 402, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (557, 1, 31, 59, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (558, 5, 456, 105, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (559, 5, 456, 119, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (560, 15, 532, 12, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (561, 5, 456, 54, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (562, 5, 456, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (563, 30, 590, 65, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (564, 39, 689, 88, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (565, 5, 456, 172, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (566, 1, 39, 73, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (567, 38, 663, 123, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (568, 4, 431, 63, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (569, 6, 10, 86, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (570, 7, 726, 163, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (571, 7, 726, 134, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (572, 7, 726, 5, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (573, 7, 726, 100, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (574, 1, 39, 81, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (575, 1, 30, 144, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (577, 1, 727, 101, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (578, 6, 1, 57, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (579, 3, 402, 17, NULL)
INSERT INTO [dbo].[Fish] ([FishID], [FishGenusID], [FishSpeciesID], [FishLocaleID], [FishDescription]) VALUES (580, 2, 52, 188, NULL)
SET IDENTITY_INSERT [dbo].[Fish] OFF

-- Add 164 rows to [dbo].[FishPhotos]
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (117, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (118, 245)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (119, 245)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (120, 278)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (121, 278)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (122, 278)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (123, 7)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (126, 245)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (127, 347)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (128, 347)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (129, 347)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (130, 308)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (131, 308)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (132, 85)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (133, 86)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (134, 186)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (137, 320)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (138, 63)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (139, 254)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (140, 561)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (141, 308)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (142, 229)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (143, 229)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (144, 312)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (145, 312)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (147, 312)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (148, 312)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (149, 312)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (150, 403)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (151, 403)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (152, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (153, 30)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (154, 156)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (155, 156)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (156, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (157, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (158, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (159, 70)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (160, 156)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (161, 7)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (163, 562)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (164, 562)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (165, 562)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (166, 562)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (171, 563)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (173, 386)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (175, 131)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (176, 129)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (177, 329)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (178, 71)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (180, 173)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (181, 245)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (182, 561)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (183, 12)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (184, 34)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (185, 565)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (187, 566)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (188, 567)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (189, 229)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (191, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (192, 285)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (193, 21)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (195, 332)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (198, 322)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (199, 322)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (200, 322)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (201, 320)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (202, 285)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (203, 558)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (204, 403)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (205, 192)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (207, 306)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (208, 306)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (209, 215)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (210, 215)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (212, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (213, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (217, 388)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (218, 388)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (219, 388)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (222, 293)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (224, 293)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (225, 293)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (226, 321)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (227, 321)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (228, 321)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (229, 283)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (230, 283)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (231, 113)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (232, 168)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (233, 168)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (234, 168)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (235, 21)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (236, 569)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (237, 21)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (238, 416)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (239, 396)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (240, 306)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (241, 30)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (242, 30)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (244, 307)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (245, 307)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (246, 307)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (248, 126)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (249, 126)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (250, 126)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (251, 344)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (252, 344)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (253, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (254, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (255, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (256, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (257, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (258, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (259, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (260, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (261, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (262, 568)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (263, 413)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (264, 413)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (268, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (269, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (270, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (271, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (272, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (273, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (274, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (275, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (276, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (277, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (278, 416)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (279, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (280, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (281, 44)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (282, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (283, 322)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (284, 573)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (285, 573)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (286, 311)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (287, 574)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (288, 556)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (289, 66)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (299, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (300, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (301, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (302, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (303, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (305, 577)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (306, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (307, 148)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (309, 124)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (310, 124)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (311, 124)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (312, 124)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (313, 388)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (315, 186)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (316, 556)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (317, 220)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (318, 220)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (319, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (320, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (321, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (322, 326)
INSERT INTO [dbo].[FishPhotos] ([PhotoID], [FishID]) VALUES (323, 577)

-- Add 47 rows to [dbo].[Genus]
SET IDENTITY_INSERT [dbo].[Genus] ON
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (1, N'Pseudotropheus', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (2, N'Labidochromis', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (3, N'Labeotropheus', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (4, N'Tropheops', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (5, N'Metriaclima', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (6, N'Cynotilapia', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (7, N'Melanochromis', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (8, N'Cyathochromis', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (9, N'Genyochromis', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (10, N'Iodotropheus', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (11, N'Petrotilapia', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (12, N'Gephyrochromis', 1)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (13, N'Aristochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (14, N'Astatotilapia', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (15, N'Aulonocara', 2)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (16, N'Buccochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (17, N'Caprichromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (18, N'Champsochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (19, N'Cheilochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (20, N'Chilotilapia', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (21, N'Copadichromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (22, N'Ctenopharynx', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (23, N'Cyrtocara', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (24, N'Dimidiochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (25, N'Diplotaxodon', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (26, N'Exochochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (27, N'Fossorochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (28, N'Hemitaeniochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (29, N'Hemitilapia', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (30, N'Lethrinops', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (31, N'Lichnochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (32, N'Mchenga', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (33, N'Mylochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (34, N'Naevochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (35, N'Nimbochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (36, N'Nyassachromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (37, N'Otopharynx', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (38, N'Placidochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (39, N'Protomelas', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (40, N'Rhamphochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (41, N'Sciaenochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (42, N'Stigmatochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (43, N'Taeniochromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (44, N'Taeniolethrinops', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (45, N'Tramitichromis', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (46, N'Trematocranus', 3)
INSERT INTO [dbo].[Genus] ([GenusID], [GenusName], [GenusGenusTypeID]) VALUES (47, N'Tyrannochromis', 3)
SET IDENTITY_INSERT [dbo].[Genus] OFF

-- Add 4 rows to [dbo].[GenusTypes]
SET IDENTITY_INSERT [dbo].[GenusTypes] ON
INSERT INTO [dbo].[GenusTypes] ([GenusTypeID], [GenusTypeName], [GenusTypeLakeID], [GenusTypeDescription]) VALUES (1, N'Mbuna', 1, NULL)
INSERT INTO [dbo].[GenusTypes] ([GenusTypeID], [GenusTypeName], [GenusTypeLakeID], [GenusTypeDescription]) VALUES (2, N'Peacocks', 1, NULL)
INSERT INTO [dbo].[GenusTypes] ([GenusTypeID], [GenusTypeName], [GenusTypeLakeID], [GenusTypeDescription]) VALUES (3, N'Haps', 1, NULL)
INSERT INTO [dbo].[GenusTypes] ([GenusTypeID], [GenusTypeName], [GenusTypeLakeID], [GenusTypeDescription]) VALUES (4, N'Frontosa', 2, NULL)
SET IDENTITY_INSERT [dbo].[GenusTypes] OFF

-- Add 186 rows to [dbo].[Locales]
SET IDENTITY_INSERT [dbo].[Locales] ON
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (1, -12.4017905147, 34.1225681679, N'Bana', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (2, -11.9186729681, 34.178364907, N'Bandawe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (3, -13.3334465136, 34.7929329179, N'Baobab Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (4, -13.3640479192, 34.3063386327, N'Benga', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (5, -14.2487317863, 35.1447987757, N'Boadzulu Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (6, -12.7599448169, 34.2758305411, N'Bua Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (7, -10.1281741293, 34.5479192492, N'Cape Kaiser', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (8, -14.11260422, 34.8876987567, N'Cape Maclear', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (9, -11.3248739409, 34.2531670932, N'Cape Manulo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (10, -11.521181162, 34.2762125434, N'Chadagha', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (11, -10.9651027729, 34.2214745065, N'Charo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (12, -14.024244224, 34.8417305388, N'Chembe', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (13, -14.3042085666, 35.2483112193, N'Chemwezi Rocks', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (14, -10.3593937073, 34.2264828959, N'Chesese', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (15, -10.3655196181, 34.2400368209, N'Chewere', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (16, -13.1420408391, 34.3134136069, N'Chia Lagoon', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (17, -13.9571827535, 34.5565863388, N'Chidunga Rocks', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (18, -13.1511605675, 34.7962009864, N'Chiloelo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (19, -12.7278206837, 34.7901243558, N'Chilucha Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (20, -10.4329241466, 34.2548070157, N'Chilumba', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (21, -11.4580981034, 34.9340861086, N'Chimate', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (22, -13.7396230496, 35.037539077, N'Chimwalani Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (23, -11.1243457699, 34.2356402984, N'Chinkoole', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (24, -11.8480246922, 34.1751199215, N'Chinteche', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (25, -11.2055870891, 34.7371978828, N'Chinula', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (26, -13.0574952921, 34.7976674196, N'Chinuna', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (27, -13.8893422495, 34.9550576629, N'Chinyamwezi Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (29, -13.8399423478, 34.9569068703, N'Chinyankwazi Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (30, -13.5313861711, 34.8668440559, N'Chiofu Bay', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (31, -13.9911659471, 34.5192682801, N'Chipoka', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (32, -10.4635185515, 34.2772225775, N'Chirwa Island', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (33, -10.398017678, 34.2572180732, N'Chitande Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (34, -10.6092811963, 34.179652908, N'Chitimba Bay', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (35, -10.7090078948, 34.1871020112, N'Chiweta', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (36, -11.6025705801, 34.9630773778, N'Chiwindi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (37, -10.1116055051, 34.001581123, N'Chiwondo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (38, -11.6634743687, 34.3268391382, N'Chizi Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (39, -12.0181543078, 34.6220322597, N'Chizumulu Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (40, -12.6373995188, 34.7832674992, N'Chuanga', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (41, -11.3562373082, 34.8675131385, N'Chuwa', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (42, -12.138497327, 34.7578931344, N'Cobue', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (43, -14.3538799523, 35.1723071397, N'Crocodile Rocks', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (44, -13.4974176844, 34.4133707405, N'Domira Bay', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (45, -13.9811520013, 34.8320610103, N'Domwe Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (46, -12.5075479154, 34.1911748864, N'Dwangwa', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (48, -13.6553863951, 34.8570124242, N'Fort Maguire', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (50, -10.5115622327, 34.2273468098, N'Galireya Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (51, -13.5110441109, 34.8602775591, N'Gome', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (52, -11.5698839703, 34.958039889, N'Hai Reef', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (53, -14.0691642689, 34.9293136006, N'Harbour Island', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (54, -11.3064699375, 34.7549220882, N'Higga Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (55, -11.1487027974, 34.6468664909, N'Hongi Island', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (56, -10.8680545812, 34.2135097389, N'Hora Mhango', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (57, -9.54180862762, 34.0889272456, N'Ikombe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (58, -14.0001610732, 34.8485030631, N'Ilala Gap', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (59, -9.59514007633, 33.9544978352, N'Itungi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (60, -12.8919083964, 34.3145073516, N'Jalo Reef', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (61, -14.1246256274, 35.1819679406, N'Kadango', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (62, -10.1230719754, 34.5235351088, N'Kaiser Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (63, -10.9922240261, 34.2215053536, N'Kakusa', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (64, -13.7777864822, 34.6208975845, N'Kambiri Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (65, -11.9568009852, 34.1276695346, N'Kande Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (66, -12.1448640048, 34.7139991347, N'Kanjindo Rocks', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (67, -9.73500482017, 33.8907213954, N'Kaporo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (68, -9.93494308429, 33.9460702887, N'Karonga', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (69, -10.8086788685, 34.2092843297, N'Kasinda', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (70, -10.4560891497, 34.2856838465, N'Katale Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (71, -11.4826762222, 34.2806372117, N'Kawanga', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (72, -9.79259805043, 34.3420539381, N'Kirondo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (73, -12.0715086688, 34.7283787978, N'Likoma Island', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (74, -12.0135885072, 34.5858895062, N'Linganjala Reef', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (75, -11.3974944779, 34.2728632922, N'Lion''s Cove', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (76, -11.1538983477, 34.686648323, N'Lipingo', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (77, -11.099323583, 34.638587427, N'Liuli', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (78, -11.7171723, 34.9568178806, N'Liutche', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (79, -12.0394779408, 34.6205862924, N'Liwelo Bay', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (80, -11.8739762117, 34.9286369392, N'Londo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (81, -11.2897495871, 34.7797554999, N'Luhuchi Rocks', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (82, -11.9109870709, 34.8996039145, N'Lumbaulo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (83, -9.63133569508, 34.1817434622, N'Lumbila', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (84, -13.0795016389, 34.807441873, N'Lumessi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (85, -11.2280424888, 34.7366391507, N'Lundo Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (86, -10.7170940886, 34.65285643, N'Lundu', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (87, -10.0559952426, 33.9935698319, N'Lupembe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (88, -10.0724554867, 34.5411369243, N'Lupingu', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (89, -10.4473353576, 34.2677690987, N'Luromo', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (90, -10.4617659485, 34.5641085701, N'Lutara Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (91, -13.7915285066984, 34.9712342112728, N'Luwala Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (92, -10.4510760372, 34.2807366562, N'Luwino Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (93, -12.015639461, 34.6084383112, N'Machili Island', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (94, -10.3402825205, 34.5699316581, N'Magunga Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (95, -12.0477728487, 34.7597332716, N'Maingano', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (96, -10.4613742547, 34.2869919555, N'Maison Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (97, -10.385663662, 34.2458357519, N'Makambukira Bay', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (98, -13.7346824487, 34.8857069368, N'Makanjila Point', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (99, -13.7564571785, 34.8753540078, N'Makanjila Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (100, -14.3012527236, 35.1435335712, N'Makokola Reef', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (101, -9.94961817912, 34.4532929257, N'Makonde', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (102, -12.0386088407, 34.7288512342, N'Makulawe', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (103, -13.9016050549, 34.625266481, N'Maleri Island', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (104, -11.2761372446, 34.7875553747, N'Mamba Bay', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (105, -10.4976691375, 34.5888130501, N'Manda', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (107, -11.072576303, 34.6366662875, N'Mango', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (108, -14.4775229095, 35.2673225184, N'Mangochi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (109, -12.191003628, 34.6997193355, N'Mara Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (110, -11.2457354914, 34.251806535, N'Mara Rocks', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (111, -12.1093664917, 34.7263739514, N'Masimbwe Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (112, -13.5606208066, 34.8558293578, N'Masinje', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (113, -9.49473486677, 34.0318907735, N'Matema', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (114, -11.2871305369, 34.7859302656, N'Maunyuni Rocks', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (115, -14.1010314976, 34.9315031396, N'Mazinzi Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (116, -12.0393132708, 34.7468662554, N'Mbako Point', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (117, -11.2761372446, 34.7875553747, N'Mbamba Bay', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (118, -12.0668559103, 34.7489710467, N'Mbamba Island', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (119, -13.4412477156, 34.4879604371, N'Mbenji Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (120, -11.1806859494, 34.2191758075, N'Mbowe Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (121, -12.0773910825, 34.7477907363, N'Mbuzi Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (122, -12.2837007047, 34.7185981632, N'Mbweca', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (123, -10.2847824483, 34.1763038271, N'Mdoka', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (124, -12.8323105806, 34.7855601853, N'Meluluca', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (125, -12.0510268014, 34.6154129904, N'Membe Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (126, -12.0561011731284, 34.7523740468492, N'Membe Point', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (127, -13.4049407247, 34.870377324, N'Meponda', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (128, -12.6964947795, 34.8113973102, N'Metangula', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (129, -12.8878402243, 34.7458774374, N'Minos Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (130, -12.0103792651, 34.6144670913, N'Mkanila Bay', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (131, -11.0548211201, 34.2195891891, N'Mkondowe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (132, -14.0814809954, 34.9296216866, N'Monkey Bay', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (133, -10.4303667872, 34.2787661199, N'Mpanga Rocks', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (134, -14.1792366733, 35.0431918835, N'Mphande Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (135, -11.9146796944, 34.1859902777, N'Mphandikucha Island', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (136, -13.8811710756, 34.5896217329, N'Msala', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (137, -9.98029717716, 34.4830173985, N'Msisi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (138, -11.7859409491, 34.2365450465, N'Msuli Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (139, -10.1515146532, 34.0418643352, N'Mulale Lagoon', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (140, -13.9908037455, 34.7554303576, N'Mumbo Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (141, -11.6410858078, 34.3119547201, N'Mundola Point', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (142, -14.1217914153, 34.9399106914, N'Mwalawaqueeni Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (143, -13.918110169, 34.6433162785, N'Nakantenga Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (144, -13.7301071932, 34.6402097998, N'Namalenje Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (145, -13.8898643587, 34.610984361, N'Nankoma Island', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (146, -13.8825446374, 34.6104667661, N'Nankoma Reef', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (147, -13.6075164853, 34.854876168, N'Narungu', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (148, -12.0851893899, 34.7093101143, N'Ndomo Point', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (149, -10.6191852874, 34.6175968172, N'Ndumbi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (150, -12.0324006755, 34.7315690511, N'Ndumbi Rocks', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (152, -10.174308151, 34.0645617358, N'Ngara', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (154, -12.5242216067, 34.7204348799, N'Ngoo', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (155, -10.261758288, 34.5708770132, N'Ngwazi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (156, -10.8942896695, 34.6708324729, N'Njambe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (158, -9.58400246785, 34.1372156336, N'Nkanda', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (159, -11.1893121948, 34.7144768728, N'Nkhali', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (160, -11.6048427424, 34.3014323387, N'Nkhata Bay', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (161, -12.9268138652, 34.2997565054, N'Nkholakota', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (162, -13.3209991068, 34.3834126343, N'Nkhomo Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (163, -14.1766183036, 34.9995420176, N'Nkhudzi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (164, -12.986778199, 34.7649926833, N'Nkhungu Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (165, -12.9403765902, 34.7441376371, N'Nkhungu Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (166, -12.7687181254, 34.8039991572, N'N''kolongwe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (167, -14.3712790928, 35.1927536617, N'Nkopola', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (168, -13.6250701253, 34.856288181, N'Ntekete', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (169, -11.9747040631, 34.8952942188, N'Ntumba', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (170, -14.0394224752, 34.8218286579, N'Otter Point', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (171, -10.6702923489, 34.653746437, N'Pombo Rocks', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (172, -11.0854770212, 34.6370495035, N'Puulu', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (174, -11.1089376052, 34.2310647353, N'Ruarwe', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (175, -11.3054628052, 34.7712075894, N'Sambia Reef', 4, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (176, -12.0276144622, 34.6284033676, N'Same Bay', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (177, -11.7225251958, 34.3022357885, N'Sanga', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (178, -13.022098314, 34.3305681346, N'Sani', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (179, -10.7746071256, 34.204861822, N'Selewa', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (180, -13.7154705851, 34.6308699372, N'Senga Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (181, -11.9219239096, 34.6107808603, N'Taiwan Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (182, -12.5498295204, 34.7566587592, N'Tchia', 1, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (183, -14.0627205549, 34.9250068955, N'Thumbi East Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (184, -11.0217239856, 34.614587346, N'Thumbi Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (185, -14.0214849985, 34.8159190248, N'Thumbi West Island', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (186, -13.0027926073, 34.7769893707, N'Thundu', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (187, -14.040581293, 34.9107428251, N'Tsano Rock', 3, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (188, -12.3973814685, 34.7031004675, N'Tumbi Point', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (189, -11.5142143227, 34.931987637, N'Undu Reef', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (190, -11.658591531, 34.9682673985, N'Ungi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (191, -11.2207265118, 34.2105522965, N'Usisya', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (192, -10.2537389575, 34.1381970036, N'Vua', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (194, -11.6930445378, 34.9648035896, N'Wikihi', 2, 1, NULL)
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (196, -13.9670073168, 34.8166666685, N'Zimbawe Rocks', 2, 1, NULL)


INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (197, -3.660075,29.159088, N'Bemba (Pemba)', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (198, -6.013556,29.748573, N'Bulu Point', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (199, -4.538094,29.185181, N'Caramba', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (200, -8.5688,30.799484, N'Cape Chaitika', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (201, -8.398168,30.465002, N'Chimba', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (202, -8.331083,30.566711, N'Cape Chipimbi', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (203, -5.680388,29.886589, N'Halembe', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (204, -6.814626,30.377197, N'Ikola', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (205, -8.545035,30.623703, N'Ilangi', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (206, -5.549612,29.34989, N'Kabimba', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (207, -8.484852,30.481825, N'Cape Kachese', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (208, -8.61361,31.14624, N'Kalambo', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (209, -7.456943,30.214933, N'Kapampa', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (210, -6.0203,29.741707, N'Karilani Island', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (211, -8.760393,31.108475, N'Kasakalawe', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (212, -8.455054,31.129074, N'Kasanga', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (213, -6.50043,29.955381, N'Kibwesa', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (214, -8.691675,30.92514, N'Kiku', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (215, -4.088932,29.212646, N'Kiriza', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (216, -7.149949,30.489807, N'Cape Korongwe', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (217, -8.540621,30.730476, N'Linangu', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (218, -8.10465,30.550747, N'Livua', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (219, -6.244998,29.711838, N'Cape Luagala', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (220, -8.561586,30.730906, N'Lufubu', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (221, -7.885147,30.315399, N'Lunangwa', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (222, -8.033394,30.49118, N'Lupota', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (223, -5.202758,29.778786, N'Malagarasi', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (224, -5.335063,29.784279, N'Maswa', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (225, -7.058645,29.825134, N'Moba II', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (226, -8.217777,30.577354, N'Moliro', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (227, -7.099785,30.498562, N'Cape Mpimbwe', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (228, -8.753013,31.117058, N'Mpulungu', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (229, -6.966397,29.747147, N'Mtoto', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (230, -8.443677,31.144094, N'Muzi', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (231, -7.638944,30.655289, N'Namansi', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (232, -8.481541,30.683098, N'Cape Nangu', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (233, -8.549279,30.600185, N'Nkamba Bay', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (234, -6.449047,29.84436, N'Siyeswe', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (235, -4.991082,29.733124, N'Ujiji', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (236, -7.462113,30.564213, N'Ulwile', 1, 2, NULL)	
INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (237, -7.288914,30.16571, N'Zongwe', 1, 2, NULL)

INSERT INTO [dbo].[Locales] ([LocaleID], [LocaleLatitude], [LocaleLongitude], [LocaleName], [LocaleZoomLevel], [LocaleLakeID], [LocaleDescription]) VALUES (238, -7.149949,30.489807, N'Cape Korongwe', 1, 3, NULL)	




SET IDENTITY_INSERT [dbo].[Locales] OFF

-- Add 392 rows to [dbo].[Species]
SET IDENTITY_INSERT [dbo].[Species] ON
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (1, N'afra', 6, 1, NULL, 0, 0, 3)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (2, N'axelrodi', 6, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (3, N'pulpican', 6, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (4, N'black dorsal', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (5, N'chinyankwazi', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (6, N'dwarf', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (7, N'hara', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (8, N'lion', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (9, N'maleri Nakantenga', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (10, N'mbamba', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (11, N'mbweca Cobue', 6, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (12, N'ater', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (13, N'crabro', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (14, N'cyaneorhabdos', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (15, N'cyaneus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (16, N'demasoni', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (17, N'flavus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (18, N'fuscus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (19, N'galanos', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (20, N'heteropictus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (21, N'interruptus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (22, N'johanni', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (23, N'livingstonii', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (24, N'minutus', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (25, N'perileucos', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (26, N'perspicax', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (27, N'saulosi', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (28, N'socolofi', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (29, N'tursiops', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (30, N'williamsi', 1, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (31, N'acei', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (32, N'aggressive bars', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (33, N'aggressive grey', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (34, N'aggressive yellow fin', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (35, N'burrower', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (36, N'chinyankwazi', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (37, N'crabro blue', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (38, N'daktari', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (39, N'elongatus', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (40, N'kingsizei lupingu', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (41, N'kingsizei north', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (42, N'lime nkhomo', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (43, N'ndumbi gold', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (44, N'perspicax orange cap', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (45, N'perspicax tanzania', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (46, N'polit Lion''s Cove', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (47, N'polit tumbi', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (48, N'tiny', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (49, N'williamsi nkudzi', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (50, N'zebra long pelvic', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (51, N'zebra mbowe', 1, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (52, N'caeruleus', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (53, N'chisumulae', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (54, N'flavigulis', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (55, N'freibergi', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (56, N'gigas', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (57, N'maculicauda', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (58, N'pallidus', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (59, N'strigatus', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (60, N'textilis', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (61, N'zebroides', 2, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (62, N'gigas mara', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (63, N'hongi', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (64, N'mbamba', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (65, N'perlmutt', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (66, N'textilis blue', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (67, N'textilis cobalt', 2, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (401, N'fuelleborni', 3, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (402, N'trewavasae', 3, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (403, N'lucerna', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (404, N'macrophthalmus', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (405, N'microstoma', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (406, N'novemfasciatus', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (407, N'romandi', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (408, N'tropheops', 4, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (409, N'aurora', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (410, N'band', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (411, N'black', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (412, N'black hara', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (413, N'boadzulu', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (414, N'broad mouth', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (415, N'chilumba', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (416, N'chitimba', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (417, N'chinyamwezi', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (418, N'gold otter', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (419, N'gome yellow', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (420, N'gracilior nankumba', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (421, N'higga', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (422, N'lilac', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (423, N'lucerna brown chia', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (424, N'maleri blue', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (425, N'maleri yellow', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (426, N'mauve yellow', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (427, N'mbenji blue', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (428, N'membe', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (429, N'olive', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (430, N'red cheek', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (431, N'red fin', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (432, N'rust', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (433, N'sand', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (434, N'weed', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (435, N'yellow chin', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (436, N'yellow gular', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (437, N'yellow yellow', 4, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (438, N'aurora', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (439, N'barlowi', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (440, N'benetos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (441, N'callainos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (442, N'chrysomallos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (443, N'emmiltos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (444, N'estherae', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (445, N'fainzilberi', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (446, N'flavifemina', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (447, N'greshakei', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (448, N'hajomaylandi', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (449, N'lanisticola', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (450, N'lombardoi', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (451, N'mbenjii', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (452, N'phaeos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (453, N'pyrsonotos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (454, N'pyrsonotos', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (455, N'xanstomachus', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (456, N'zebra', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (457, N'aurora black tail', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (458, N'glaucus', 5, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (459, N'aurora lumbaulo', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (460, N'aurora yellow', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (461, N'black dorsal', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (462, N'blue reef', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (463, N'blue shine', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (464, N'deep water', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (465, N'dolphin', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (466, N'estherae blueface', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (467, N'flameback', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (468, N'hajomaylandi pombo', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (469, N'lanisticola north', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (470, N'membe deep', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (471, N'msobo', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (472, N'msobo heteropictus', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (473, N'patricki', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (474, N'patricki minos', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (475, N'zebra bevous', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (476, N'zebra blue', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (477, N'zebra chilumba', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (478, N'zebra gold', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (479, N'zebra slim', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (480, N'zebra yellow tail', 5, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (481, N'auratus', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (482, N'baliodigma', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (483, N'chipokae', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (484, N'dialeptos', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (485, N'heterochromis', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (486, N'joanjhonsonae', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (487, N'kaskazini', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (488, N'labrosus', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (489, N'lepidiadaptes', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (490, N'melanopterus', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (491, N'mossambiquensis', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (492, N'parallelus', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (493, N'simulans', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (494, N'wochepa', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (495, N'obliquidens', 8, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (496, N'mento', 9, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (497, N'sprengerae', 10, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (498, N'stuartgranti', 10, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (499, N'chrysos', 11, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (500, N'genalutea', 11, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (501, N'microgalana', 11, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (502, N'tridentiger', 11, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (503, N'chitande', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (504, N'fuscous', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (505, N'hara', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (506, N'orange pelvic', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (507, N'retrognathus', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (508, N'ruarwe', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (509, N'tridentiger chitimba', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (510, N'yellow chin', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (511, N'yellow ventral', 11, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (512, N'lawsi', 12, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (513, N'moorii', 12, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (514, N'zebroides', 12, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (515, N'christyi', 13, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (516, N'calliptera', 14, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (517, N'aquilonium', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (518, N'baenschi', 15, 1, N'&lt;p&gt;Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.&amp;#160;&lt;/p&gt;', 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (519, N'brevinidus', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (520, N'ethelwynnae', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (521, N'gertrudae', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (522, N'guentheri', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (523, N'hansbaenschi', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (524, N'hueseri', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (525, N'jacobfreibergi', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (526, N'koningsi', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (527, N'korneliae', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (528, N'maylandi', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (529, N'rostratum', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (530, N'saulosi', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (531, N'steveni', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (532, N'stuartgranti', 15, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (533, N'chitande', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (534, N'lwanda', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (535, N'pyramid', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (536, N'trematocranus', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (537, N'walteri', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (538, N'yellow collar', 15, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (539, N'atritaeniatus', 16, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (540, N'nototaenia', 16, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (541, N'rhoadesii', 16, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (542, N'spectabilis', 16, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (543, N'liemi', 17, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (544, N'orthognathus', 17, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (545, N'caeruleus', 18, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (546, N'spilorhynchus', 18, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (547, N'euchilus', 19, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (548, N'rhoadesii', 20, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (549, N'atripinnis', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (550, N'azureus', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (551, N'borleyi', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (552, N'chizumuluensis', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (553, N'chrysonotus', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (554, N'cyaneus', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (555, N'cyanocephalus', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (556, N'geertsi', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (557, N'jacksoni', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (558, N'mbenjii', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (559, N'melas', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (560, N'mloto', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (561, N'pleurostigma', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (562, N'pleurostigmoides', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (563, N'quadrimaculatus', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (564, N'trewavasae', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (565, N'verduyni', 21, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (566, N'azureus jalo', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (567, N'fire crest mloto', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (568, N'flavimanus', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (569, N'kawanga', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (570, N'kawanga no spot', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (571, N'maisoni', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (572, N'mloto reef Chilumba', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (573, N'virginalis chitande', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (574, N'virginalis gold', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (575, N'virginalis kajose', 21, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (576, N'intermedius', 22, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (577, N'nitidus', 22, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (578, N'pictus', 22, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (579, N'moorii', 23, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (580, N'compressiceps', 24, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (581, N'dimidiatus', 24, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (582, N'kiwinge', 24, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (583, N'strigatus', 24, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (584, N'limnothrissa', 25, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (585, N'anagenys', 26, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (586, N'rostratus', 27, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (587, N'spilopterus blue', 28, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (588, N'urotaenia yellow', 28, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (589, N'oxyrhynchus', 29, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (590, N'albus', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (591, N'auritus', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (592, N'furcifer', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (593, N'leptodon', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (594, N'lethrinus', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (595, N'macrochir', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (596, N'marginatus', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (597, N'oculatus', 30, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (598, N'auritus lion', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (599, N'black fin Tanzanie', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (600, N'longipinnis ntekete', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (601, N'mbasi creek', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (602, N'mdoka red', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (603, N'nyassae mbawa', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (604, N'orange top Nkhata Bay', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (605, N'red cap', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (606, N'yellow collar', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (607, N'acuticeps', 31, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (608, N'cyclicos', 32, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (609, N'eucinostomus', 32, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (610, N'flavimanus', 32, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (611, N'thinos', 32, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (612, N'anaphyrmus', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (613, N'epichorialis', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (614, N'ericotaenia', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (615, N'formosus', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (616, N'incola', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (617, N'labidodon', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (618, N'lateristriga', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (619, N'melanonotus', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (620, N'melanotaenia', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (621, N'mola', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (622, N'mollis', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (623, N'plagiotaenia', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (624, N'subocularis', 33, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (625, N'kande', 33, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (626, N'lateristriga', 33, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (627, N'chrysogaster', 34, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (628, N'fuscotaeniatus', 35, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (629, N'linni', 35, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (630, N'livingstonii', 35, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (631, N'polystigma', 35, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (632, N'venustus', 35, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (633, N'boadzulu', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (634, N'leuciscus', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (635, N'microcephalus', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (636, N'nigritaeniatus', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (637, N'prostoma', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (638, N'purpurans', 36, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (639, N'argyrosoma', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (640, N'auromarginatus', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (641, N'decorus', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (642, N'heterodon Tanzanie', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (643, N'lithobates', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (644, N'selenurus', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (645, N'tetraspilus', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (646, N'tetrastigma', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (647, N'walteri', 37, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (648, N'auromarginatus goldhead', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (649, N'auromarginatus jakuta', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (650, N'auromarginatus mara', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (651, N'auromarginatus margrette', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (652, N'caeruliceps Kanjindo Rocks', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (653, N'cave', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (654, N'golden blueface Ikombe', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (655, N'heterodon boadzulu', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (656, N'heterodon longnose', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (657, N'heterodon nankhumba', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (658, N'spots', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (659, N'torpedo blue', 37, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (660, N'electra', 38, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (661, N'johnstoni', 38, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (662, N'milomo', 38, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (663, N'phenochilus', 38, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (664, N'blue otter', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (665, N'electra blackfin Makonde', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (666, N'electra blue Mbamba Bay', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (667, N'electra boadzulu', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (668, N'electra mozambique', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (669, N'electra superior Mandalawi', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (670, N'green face Gome', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (671, N'jalo', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (672, N'johnstoni solo', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (673, N'phenochilus Tanzania', 38, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (674, N'annectens', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (675, N'fenestratus', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (676, N'insignis', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (677, N'kirkii', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (678, N'labridens', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (679, N'marginatus vuae', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (680, N'ornatus', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (681, N'pleurotaenia', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (682, N'similis', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (683, N'spilonotus', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (684, N'taeniolatus', 39, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (685, N'virgatus Gome', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (686, N'hertae', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (687, N'mbenji thick lips', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (688, N'spilonotus mozambique', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (689, N'spilonotus tanzania', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (690, N'steveni taiwan', 39, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (691, N'esox', 40, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (692, N'ferox', 40, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (693, N'acrophthalmus', 40, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (694, N'chia Lagoon', 40, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (695, N'ahli', 41, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (696, N'benthicola', 41, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (697, N'fryeri', 41, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (698, N'gracilis', 41, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (699, N'psammophilus', 41, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (700, N'nyassae', 41, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (701, N'modestus', 42, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (702, N'pholidophorus', 42, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (703, N'pleurospilus Mdoka', 42, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (704, N'woodi', 42, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (705, N'guttatus', 42, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (706, N'modestus eastern', 42, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (707, N'modestus makokola', 42, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (708, N'spilostichus type', 42, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (709, N'tolae', 42, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (710, N'holotaenia', 43, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (711, N'furcicauda', 44, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (712, N'laticeps', 44, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (713, N'praeorbitalis', 44, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (714, N'brevis', 45, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (715, N'intermedius', 45, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (716, N'lituris', 45, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (717, N'orange top', 45, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (718, N'purple', 45, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (719, N'microstoma', 46, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (720, N'placodon', 46, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (721, N'macrostoma', 47, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (722, N'nigriventer', 47, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (723, N'microstoma', 30, 0, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (726, N'vermivorus', 7, 1, NULL, 0, 0, 1)
INSERT INTO [dbo].[Species] ([SpeciesID], [SpeciesName], [SpeciesGenusID], [SpeciesDescribed], [SpeciesDescription], [SpeciesMinSize], [SpeciesMaxSize], [SpeciesTemperamentID]) VALUES (727, N'williamsi north', 1, 0, NULL, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[Species] OFF

-- Add constraints to [dbo].[Species]
ALTER TABLE [dbo].[Species] ADD CONSTRAINT [FK_Species_Genus] FOREIGN KEY ([SpeciesGenusID]) REFERENCES [dbo].[Genus] ([GenusID])
ALTER TABLE [dbo].[Species] ADD CONSTRAINT [FK_Species_Temperaments] FOREIGN KEY ([SpeciesTemperamentID]) REFERENCES [dbo].[Temperaments] ([TemperamentID])

-- Add constraints to [dbo].[Locales]
ALTER TABLE [dbo].[Locales] ADD CONSTRAINT [FK_Locales_Lakes] FOREIGN KEY ([LocaleLakeID]) REFERENCES [dbo].[Lakes] ([LakeID])

-- Add constraints to [dbo].[GenusTypes]
ALTER TABLE [dbo].[GenusTypes] ADD CONSTRAINT [FK_GenusTypes_Lakes] FOREIGN KEY ([GenusTypeLakeID]) REFERENCES [dbo].[Lakes] ([LakeID])

-- Add constraints to [dbo].[Genus]
ALTER TABLE [dbo].[Genus] ADD CONSTRAINT [FK_Genus_GenusTypes] FOREIGN KEY ([GenusGenusTypeID]) REFERENCES [dbo].[GenusTypes] ([GenusTypeID])

-- Add constraints to [dbo].[FishPhotos]
ALTER TABLE [dbo].[FishPhotos] ADD CONSTRAINT [FK_FishPhotos_Fish] FOREIGN KEY ([FishID]) REFERENCES [dbo].[Fish] ([FishID])
ALTER TABLE [dbo].[FishPhotos] ADD CONSTRAINT [FK_FishPhotos_Photos] FOREIGN KEY ([PhotoID]) REFERENCES [dbo].[Photos] ([PhotoID]) ON DELETE CASCADE

-- Add constraints to [dbo].[Fish]
ALTER TABLE [dbo].[Fish] ADD CONSTRAINT [FK_Fish_Genus] FOREIGN KEY ([FishGenusID]) REFERENCES [dbo].[Genus] ([GenusID])
ALTER TABLE [dbo].[Fish] ADD CONSTRAINT [FK_Fish_Locales] FOREIGN KEY ([FishLocaleID]) REFERENCES [dbo].[Locales] ([LocaleID])
ALTER TABLE [dbo].[Fish] ADD CONSTRAINT [FK_Fish_Species] FOREIGN KEY ([FishSpeciesID]) REFERENCES [dbo].[Species] ([SpeciesID])

-- Add constraints to [dbo].[aspnet_Users]
ALTER TABLE [dbo].[aspnet_Users] ADD CONSTRAINT [FK__aspnet_Us__Appli__65370702] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])

-- Add constraints to [dbo].[aspnet_Membership]
ALTER TABLE [dbo].[aspnet_Membership] ADD CONSTRAINT [FK__aspnet_Me__Appli__793DFFAF] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
ALTER TABLE [dbo].[aspnet_Membership] ADD CONSTRAINT [FK__aspnet_Me__UserI__7A3223E8] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])

COMMIT TRANSACTION
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Articles] WITH CHECK CHECK CONSTRAINT [FK_Articles_Authors];

ALTER TABLE [dbo].[aspnet_Membership] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Me__Appli__793DFFAF];

ALTER TABLE [dbo].[aspnet_Membership] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Me__UserI__7A3223E8];

ALTER TABLE [dbo].[aspnet_Paths] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Pa__Appli__32767D0B];

ALTER TABLE [dbo].[aspnet_Profile] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Pr__UserI__10216507];

ALTER TABLE [dbo].[aspnet_Roles] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Ro__Appli__1B9317B3];

ALTER TABLE [dbo].[aspnet_Users] WITH CHECK CHECK CONSTRAINT [FK__aspnet_Us__Appli__65370702];

ALTER TABLE [dbo].[Fish] WITH CHECK CHECK CONSTRAINT [FK_Fish_Genus];

ALTER TABLE [dbo].[Fish] WITH CHECK CHECK CONSTRAINT [FK_Fish_Locales];

ALTER TABLE [dbo].[FishArticles] WITH CHECK CHECK CONSTRAINT [FK_FishArticles_Articles];

ALTER TABLE [dbo].[FishPhotos] WITH CHECK CHECK CONSTRAINT [FK_FishPhotos_Fish];

ALTER TABLE [dbo].[FishPhotos] WITH CHECK CHECK CONSTRAINT [FK_FishPhotos_Photos];

ALTER TABLE [dbo].[Genus] WITH CHECK CHECK CONSTRAINT [FK_Genus_GenusTypes];

ALTER TABLE [dbo].[GenusArticles] WITH CHECK CHECK CONSTRAINT [FK_GenusArticles_Articles];

ALTER TABLE [dbo].[GenusTypes] WITH CHECK CHECK CONSTRAINT [FK_GenusTypes_Lakes];

ALTER TABLE [dbo].[LocaleArticles] WITH CHECK CHECK CONSTRAINT [FK_LocaleArticles_Articles];

ALTER TABLE [dbo].[Locales] WITH CHECK CHECK CONSTRAINT [FK_Locales_Lakes];

ALTER TABLE [dbo].[SpeciesArticles] WITH CHECK CHECK CONSTRAINT [FK_SpeciesArticles_Articles];

ALTER TABLE [dbo].[Species] WITH CHECK CHECK CONSTRAINT [FK_Species_Genus];

ALTER TABLE [dbo].[Species] WITH CHECK CHECK CONSTRAINT [FK_Species_Temperaments];

ALTER TABLE [dbo].[Fish] WITH CHECK CHECK CONSTRAINT [FK_Fish_Species];


GO
CREATE TABLE [#__checkStatus] (
    [Table]      NVARCHAR (270),
    [Constraint] NVARCHAR (270),
    [Where]      NVARCHAR (MAX)
);

SET NOCOUNT ON;


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[aspnet_PersonalizationAllUsers]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[aspnet_PersonalizationAllUsers]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[aspnet_PersonalizationPerUser]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[aspnet_PersonalizationPerUser]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[aspnet_UsersInRoles]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[aspnet_UsersInRoles]', 16, 127);
    END


GO
SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        DECLARE @VarDecimalSupported AS BIT;
        SELECT @VarDecimalSupported = 0;
        IF ((ServerProperty(N'EngineEdition') = 3)
            AND (((@@microsoftversion / power(2, 24) = 9)
                  AND (@@microsoftversion & 0xffff >= 3024))
                 OR ((@@microsoftversion / power(2, 24) = 10)
                     AND (@@microsoftversion & 0xffff >= 1600))))
            SELECT @VarDecimalSupported = 1;
        IF (@VarDecimalSupported > 0)
            BEGIN
                EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
            END
    END


GO
