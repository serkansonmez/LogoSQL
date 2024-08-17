USE [AlvinB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_IREN_ASAS_2024_dbstok]    Script Date: 23.01.2024 14:59:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--  
create procedure SP_ErcomCariKartEslestirmeInsert as 
insert into ErcomCariKartEslestirme
select KOD,ADI,TedarikciId,ZirveKodu from 
(SELECT KOD,ADI,1 as TedarikciId,'' as ZirveKodu FROM [VW_IREN_2024_dbCari]
UNION ALL
SELECT KOD,ADI,2,'' FROM VW_IREN_ASAS_2024_dbcari)   tblToplam
left join ErcomCariKartEslestirme on tblToplam.KOD = ErcomCariKartEslestirme.carikodu
where carikodu is null and ADI is not null

  
