USE [SuperIk_DB]
GO

/****** Object:  Table [dbo].[AileBirey]    Script Date: 17.09.2021 14:46:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ExcelPerformans2021](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RowDeleted] [char](1) NULL,
	[RowUpdatedBy] [int] NULL,
	[RowUpdatedTime] [datetime] NULL,
	[PuanlayanUcretPersonelId] [int] NULL,
	[PuanlananUcretPersonelId] [int] NOT NULL,
	[PuanlayanPersonelAdi] [varchar](255) NULL,
	[PuanlananPersonelAdi] [varchar](255) NULL,
	[PuanlamaDerecesi] [int] NULL,
	[OrtamalaPuan] [int] NULL,
	[SiraNo] [int] NULL,
	[Soru] [varchar](255) NULL,
	[Puan] [int] NULL,
	[GecerliPuan] [int] NULL,
 CONSTRAINT [PK_ExcelPerformans2021] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


