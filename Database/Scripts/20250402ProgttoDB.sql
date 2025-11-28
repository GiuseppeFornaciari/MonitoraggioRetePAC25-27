USE [MonitoraggioPAC25-27]
GO

--CREATE TABLE [dbo].[Schede](
--	[IdScheda] [int] IDENTITY(1,1) NOT NULL,
--	[CodScheda] [nvarchar](10) NOT NULL,
--	[CodEnte] [int] NOT NULL,
--	[CodResponsabileScheda] [int] NOT NULL,
--	[Scheda] [nvarchar](255) NOT NULL, 
--	[DataMonitoraggio] [date] NOT NULL
-- CONSTRAINT [PK_Schede] PRIMARY KEY CLUSTERED 
--(
--	[IdScheda] ASC
--))

--CREATE TABLE [dbo].[Progetti](
--	[IdProgetto] [int] IDENTITY(1,1) NOT NULL,
--	[CodProgetto] [nvarchar](10) NOT NULL,
--	[Progetto] [nvarchar](255) NOT NULL, 
--	[CodResponsabileEnte] [int] NOT NULL,
--	[CodResponsabileMinistero] [int] NOT NULL,
--	[CheckInserimentoResponsabileEnte] [bit] NOT NULL,
--	[CheckInserimentoResponsabileMinistero] [bit] NOT NULL,
--	[NoteResponsabileEnte] [nvarchar](max) NULL,
--	[NoteResponsabileMinistero] [nvarchar](max) NULL
-- CONSTRAINT [PK_Progetti] PRIMARY KEY CLUSTERED 
--(
--	[IdProgetto] ASC
--))

--ALTER TABLE [dbo].[Progetti] ADD  DEFAULT ((0)) FOR [CheckInserimentoResponsabileEnte]
--ALTER TABLE [dbo].[Progetti] ADD  DEFAULT ((0)) FOR [CheckInserimentoResponsabileMinistero]
--GO

--CREATE TABLE [dbo].[Output](
--	[IdOutput] [int] IDENTITY(1,1) NOT NULL,
--	[CodTipoOutput] [nvarchar](3) NOT NULL,
--	[CodOutputCompleto] [nvarchar](10) NOT NULL,
--	[OutputProgrammato] [nvarchar](max) NOT NULL, 
--	[OutputRealizzato] [nvarchar](max) NOT NULL, 
--	[NumOputuptProgrammato] [int] NOT NULL,
--	[NumOputuptRealizzato] [int] NULL,
--	[OutputAllegato] [nvarchar](max) NULL,
--	[OutputLink] [nvarchar](max) NULL,
--	[NoteResponsabileEnte] [nvarchar](max) NULL,
--	[ParereResponsabileMinistero] [bit] NOT NULL,
--	[MotivazioneResponsabileMinistero] [nvarchar](max) NULL,
--	[Comunicazione] [bit] NOT NULL,
--	[CodTipoOutputNonProgrammato] [nvarchar](3) NULL
-- CONSTRAINT [PK_Output] PRIMARY KEY CLUSTERED 
--(
--	[IdOutput] ASC
--))

--ALTER TABLE [dbo].[Output] ADD  DEFAULT ((0)) FOR [ParereResponsabileMinistero]
--ALTER TABLE [dbo].[Output] ADD  DEFAULT ((0)) FOR [Comunicazione]



--INSERT INTO [MonitoraggioPAC25-27].[dbo].[AspNetUsers] ([Id]
--      ,[UserName]
--      ,[NormalizedUserName]
--      ,[Email]
--      ,[NormalizedEmail]
--      ,[EmailConfirmed]
--      ,[PasswordHash]
--      ,[SecurityStamp]
--      ,[ConcurrencyStamp]
--      ,[PhoneNumber]
--      ,[PhoneNumberConfirmed]
--      ,[TwoFactorEnabled]
--      ,[LockoutEnd]
--      ,[LockoutEnabled]
--      ,[AccessFailedCount])

--SELECT [Id]
--      ,[UserName]
--      ,UPPER([UserName]) as NormalizedUserName
--      ,[Email]
--	  ,UPPER(Email) as NormalizedEmail
--      ,[EmailConfirmed]
--      ,[PasswordHash]
--      ,[SecurityStamp]
--	  ,NEWID() as ConcurrencyStamp
--      ,[PhoneNumber]
--      ,[PhoneNumberConfirmed]
--      ,[TwoFactorEnabled]
--      ,[LockoutEndDateUtc] as LockoutEnd
--      ,[LockoutEnabled]
--      ,[AccessFailedCount]
--  FROM [MonitoraggioPAC].[dbo].[AspNetUsers]



SELECT NU.UserName,NUR.UserId,R.Name,R.Id
FROM AspNetUsers NU
INNER JOIN AspNetUserRoles NUR ON NU.Id=NUR.UserId
INNER JOIN AspNetRoles R ON NUR.RoleId=R.Id
WHERE Email like '%nucera%'



SELECT * FROM Schede S
LEFT JOIN Responsabili R ON S.CodResponsabile=R.CodResponsabile
