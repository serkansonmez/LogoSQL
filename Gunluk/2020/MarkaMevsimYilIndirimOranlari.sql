USE [ArgelasB2B_Default_v1]
GO

/****** Object:  Table [dbo].[MarkaMevsimYilIndirimOranlari]    Script Date: 9.11.2020 22:48:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MarkaMevsimYilIndirimOranlari](
	[MarkaMevsimYilIndirimOranlariId] [int] IDENTITY(1,1) NOT NULL,
	[Yil] [int] NOT NULL,
	[Marka] [varchar](100) NOT NULL,
	[Tur] [varchar](100) NOT NULL,
	[Mevsim] [varchar](100) NOT NULL,
	[IndirimOrani] [float] NOT NULL,
 CONSTRAINT [PK_MarkaMevsimYilIndirimOranlari] PRIMARY KEY CLUSTERED 
(
	[MarkaMevsimYilIndirimOranlariId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


