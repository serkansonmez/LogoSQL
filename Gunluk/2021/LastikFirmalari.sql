 --drop Table [LastikFirmalari]

CREATE TABLE [dbo].[LastikFirmalari](
	[LastikFirmalariId] [int] IDENTITY(1,1) NOT NULL,
	[FirmaAdi] [nvarchar](40) NOT NULL,
	[FirmaLogo] [nvarchar](100) NULL,
	[LastikFirmaGruplariId] [int]   NOT NULL,
 CONSTRAINT [PK_LastikFirmalari] PRIMARY KEY CLUSTERED 
(
	[LastikFirmalariId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[LastikFirmalari]  WITH NOCHECK ADD  CONSTRAINT [FK_LastikFirmalari_LastikFirmaGruplari] FOREIGN KEY([LastikFirmaGruplariId])
REFERENCES [dbo].[LastikFirmaGruplari] ([LastikFirmaGruplariId])
GO

ALTER TABLE [dbo].[LastikFirmalari] CHECK CONSTRAINT FK_LastikFirmalari_LastikFirmaGruplari
