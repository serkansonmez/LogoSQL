USE [SuperIk_DB]
GO

/****** Object:  Table [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK]    Script Date: 9.11.2020 23:14:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK](
	[ISLETME_KODU] [int] NULL,
	[SUBE_KODU] [int] NULL,
	[BELGE_NO] [varchar](15) NOT NULL,
	[GIB_DOC_NO] [varchar](16) NULL,
	[TARIH] [datetime] NOT NULL,
	[SIPARIS_NUMARASI] [nvarchar](50) NULL,
	[SIPARIS_TARIHI] [datetime] NULL,
	[QRCODEEX_BASLIK] [nvarchar](50) NOT NULL,
	[QRCODEEX] [nvarchar](50) NOT NULL,
	[XSLT] [nvarchar](50) NOT NULL,
	[PRINTXSLT] [nvarchar](50) NOT NULL,
	[CARI_ALIAS] [nvarchar](200) NULL,
	[CARI_KODU] [varchar](15) NOT NULL,
	[EIRSSENARYO] [nvarchar](200) NOT NULL,
	[WEB_ADRESI] [nvarchar](200) NOT NULL,
	[TESLIM_SEKLI] [int] NOT NULL,
	[M_CARI_KODU] [varchar](50) NULL,
	[M_UNVAN] [nvarchar](200) NOT NULL,
	[M_ADRES] [nvarchar](200) NOT NULL,
	[M_ILCE] [nvarchar](200) NOT NULL,
	[M_IL] [nvarchar](200) NOT NULL,
	[M_VERGI_DAIRESI] [nvarchar](200) NOT NULL,
	[M_VERGI_NUMARASI] [nvarchar](200) NOT NULL,
	[M_WEB_ADRESI] [nvarchar](200) NOT NULL,
	[M_TELEFON] [nvarchar](200) NOT NULL,
	[M_FAX] [nvarchar](200) NOT NULL,
	[M_ULKE_KODU] [nvarchar](200) NOT NULL,
	[F_CARI_KODU] [nvarchar](200) NOT NULL,
	[F_UNVAN] [nvarchar](200) NOT NULL,
	[F_ADRES] [nvarchar](200) NOT NULL,
	[F_ILCE] [nvarchar](200) NOT NULL,
	[F_IL] [nvarchar](200) NOT NULL,
	[F_VERGI_DAIRESI] [nvarchar](200) NOT NULL,
	[F_VERGI_NUMARASI] [nvarchar](200) NOT NULL,
	[G_CARI_KODU] [nvarchar](200) NOT NULL,
	[G_UNVAN] [nvarchar](200) NOT NULL,
	[G_ADRES] [nvarchar](200) NOT NULL,
	[G_ILCE] [nvarchar](200) NOT NULL,
	[G_IL] [nvarchar](200) NOT NULL,
	[G_ULKE_KODU] [nvarchar](200) NOT NULL,
	[G_VERGI_DAIRESI] [nvarchar](200) NOT NULL,
	[G_VERGI_NUMARASI] [nvarchar](200) NOT NULL,
	[G_E_POSTA] [nvarchar](200) NOT NULL,
	[G_WEB_ADRESI] [nvarchar](200) NOT NULL,
	[NOT1] [nvarchar](4000) NULL,
	[NOT2] [nvarchar](4000) NULL,
	[NOT3] [nvarchar](4000) NULL,
	[NOT4] [nvarchar](4000) NULL,
	[NOT5] [nvarchar](4000) NULL,
	[NOT6] [nvarchar](4000) NULL,
	[NOT7] [nvarchar](4000) NULL,
	[NOT8] [nvarchar](4000) NULL,
	[NOT9] [nvarchar](4000) NULL,
	[NOT10] [nvarchar](4000) NULL,
	[NOT11] [nvarchar](4000) NULL,
	[NOT12] [nvarchar](4000) NULL,
	[NOT13] [nvarchar](4000) NULL,
	[NOT14] [nvarchar](4000) NULL,
	[NOT15] [nvarchar](4000) NULL,
	[NOT16] [nvarchar](4000) NULL,
	[T_LISANS_ID] [nvarchar](200) NOT NULL,
	[T_UNVAN] [nvarchar](200) NOT NULL,
	[T_VKN] [nvarchar](200) NOT NULL,
	[T_ILCE] [nvarchar](200) NOT NULL,
	[T_IL] [nvarchar](200) NOT NULL,
	[T_ULKE] [nvarchar](200) NOT NULL,
	[T_POSTA_KODU] [nvarchar](200) NOT NULL,
	[T_ADI_1] [nvarchar](200) NOT NULL,
	[T_SOYADI_1] [nvarchar](200) NOT NULL,
	[T_GOREVI_1] [nvarchar](200) NOT NULL,
	[T_TCKIMLIKNO_1] [nvarchar](200) NOT NULL,
	[T_DORSE_PLAKA_1] [nvarchar](200) NOT NULL,
	[T_ADI_2] [nvarchar](200) NOT NULL,
	[T_SOYADI_2] [nvarchar](200) NOT NULL,
	[T_GOREVI_2] [nvarchar](200) NOT NULL,
	[T_TCKIMLIKNO_2] [nvarchar](200) NOT NULL,
	[T_DORSE_PLAKA_2] [nvarchar](200) NOT NULL,
	[T_ADI_3] [nvarchar](200) NOT NULL,
	[T_SOYADI_3] [nvarchar](200) NOT NULL,
	[T_GOREVI_3] [nvarchar](200) NOT NULL,
	[T_TCKIMLIKNO_3] [nvarchar](200) NOT NULL,
	[T_DORSE_PLAKA_3] [nvarchar](200) NOT NULL,
	[KAYITTARIHI] [datetime] NULL,
	[STATUS] [int] NULL,
	[STATUS_DESC] [nvarchar](max) NULL,
	[IRSALIYE_EK_BILGILER] [varchar](max) NULL,
	[EIRSALIYE_UUID] [varchar](50) NULL,
	[NUMUNE_QR_CODE_ISLENMIS] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_LISANS_ID]  DEFAULT (' ') FOR [T_LISANS_ID]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_UNVAN]  DEFAULT (' ') FOR [T_UNVAN]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_VKN]  DEFAULT (' ') FOR [T_VKN]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_ILCE]  DEFAULT (' ') FOR [T_ILCE]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_IL]  DEFAULT (' ') FOR [T_IL]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_ULKE]  DEFAULT (' ') FOR [T_ULKE]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_POSTA_KODU]  DEFAULT (' ') FOR [T_POSTA_KODU]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_ADI_1]  DEFAULT (' ') FOR [T_ADI_1]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_SOYADI_1]  DEFAULT (' ') FOR [T_SOYADI_1]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_GOREVI_1]  DEFAULT (' ') FOR [T_GOREVI_1]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_TCKIMLIKNO_1]  DEFAULT (' ') FOR [T_TCKIMLIKNO_1]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_DORSE_PLAKA_1]  DEFAULT (' ') FOR [T_DORSE_PLAKA_1]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_ADI_2]  DEFAULT (' ') FOR [T_ADI_2]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_SOYADI_2]  DEFAULT (' ') FOR [T_SOYADI_2]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_GOREVI_2]  DEFAULT (' ') FOR [T_GOREVI_2]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_TCKIMLIKNO_2]  DEFAULT (' ') FOR [T_TCKIMLIKNO_2]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_DORSE_PLAKA_2]  DEFAULT (' ') FOR [T_DORSE_PLAKA_2]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_ADI_3]  DEFAULT (' ') FOR [T_ADI_3]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_SOYADI_3]  DEFAULT (' ') FOR [T_SOYADI_3]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_GOREVI_3]  DEFAULT (' ') FOR [T_GOREVI_3]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_TCKIMLIKNO_3]  DEFAULT (' ') FOR [T_TCKIMLIKNO_3]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TBL_T_DORSE_PLAKA_3]  DEFAULT (' ') FOR [T_DORSE_PLAKA_3]
GO

ALTER TABLE [dbo].[GRS_EDESPATCHHEADERs_TBL-ESK] ADD  CONSTRAINT [DF_GRS_EDESPATCHHEADERs_TARIH]  DEFAULT (getdate()) FOR [KAYITTARIHI]
GO

