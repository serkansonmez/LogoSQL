USE [KrcB2B_Default_v1]
GO

ALTER TABLE [dbo].[Kategori]  WITH CHECK ADD  CONSTRAINT [FK_Kategori_N11Kategori] FOREIGN KEY([N11KategoriId])
REFERENCES [dbo].[N11Kategori] ([N11KategoriId])
GO

ALTER TABLE [dbo].[Kategori] CHECK CONSTRAINT [FK_Kategori_N11Kategori]
GO


