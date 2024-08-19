USE [SuperIk_DB]
GO

/****** Object:  Table [dbo].[GRS_EDESPATCHLINEs_TBL]    Script Date: 10.11.2020 16:44:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GRS_EDESPATCHLINEs_TBL](
	[BELGE_NO] [varchar](15) NULL,
	[GIBIRSNO] [varchar](16) NULL,
	[SIRANO] [int] NULL,
	[URETICI_KODU] [varchar](35) NULL,
	[MUSTERI_KODU] [varchar](50) NULL,
	[STOK_KODU] [varchar](50) NOT NULL,
	[STOK_ADI] [nvarchar](4000) NOT NULL,
	[SATIR_NOTLARI] [varchar](1) NOT NULL,
	[MIKTAR] [float] NULL,
	[OLCU_BIRIMI] [varchar](3) NULL,
	[SIPARIS_NUMARASI] [varchar](50) NOT NULL,
	[SIPARIS_TARIHI] [datetime] NOT NULL,
	[SIPARIS_SATIR_NO] [int] NOT NULL
) ON [PRIMARY]
GO


