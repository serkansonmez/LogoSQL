USE [AltinCezveB2B_Default_v1]
GO

/****** Object:  Table [dbo].[UserGridSettings]    Script Date: 25.07.2024 17:27:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserGridSettings](
	[UserGridSettingsId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RowCreatedTime] [datetime] NOT NULL,
	[FormName] [varchar](255) NOT NULL,
	[DesignName] [varchar](255) NOT NULL,
	[IsDefault] [int] NOT NULL,
	[GridSettings] [varchar](2048) NOT NULL,
 CONSTRAINT [PK_UserGridSettings] PRIMARY KEY CLUSTERED 
(
	[UserGridSettingsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserGridSettings]  WITH CHECK ADD  CONSTRAINT [FK_UserGridSettings_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO

ALTER TABLE [dbo].[UserGridSettings] CHECK CONSTRAINT [FK_UserGridSettings_UserId]
GO


