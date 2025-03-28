USE [TIGER2_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_118_21_NAKIT_AKIS_LISTESI]    Script Date: 10.09.2021 13:54:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








--exec SP_118_21_NAKIT_AKIS_LISTESI '21210103','21210113'
ALTER procedure [dbo].[SP_118_21_NAKIT_AKIS_LISTESI]  
( @IlkTarih date, @SonTarih date ,@USERID INT)
as 
begin

SELECT 'Açılış İşlemi' AS [ISLEMTURU]
      ,'Banka' AS [MODUL]
      ,@IlkTarih as [TARIH]
      ,year(@IlkTarih) as [YIL]
      ,month(@IlkTarih) [AY]
      ,day(@IlkTarih) [GUN]
      ,'0' as [FISNO]
      ,0 as [DOVIZKURU]
      ,sum([DOVIZLITUTAR]) as [DOVIZLITUTAR]
	   ,0 as [DOVIZKURU_EURO]
      ,sum([DOVIZLITUTAR_EURO]) as [DOVIZLITUTAR_EURO]
      ,sum([TUTAR]) AS TUTAR
      ,'' as [BANKAHSPADI]
      ,'' as [ACIKLAMA]
      ,'' as [BANKAKONTNO]
      ,'' as [BANKAHSPKODU]
      ,'' as [BANKAKODU]
      ,'' as [BANKAADI]
      ,'' as [CARINO]
      ,'' as [CARIADI]
      , [ISYERI]
      ,'' as [BOLUM]
      ,'' as [HESAPGRUBU]
      ,'' as [MMRKKODU]
      ,'' as [MMRKADI]
      ,'' as [MHESAPKODU]
      ,'' as [MHESAPADI]
      ,'' as [FINANSKOD]
      ,'' as [FINANSACIKLAMA]
      ,'   A.DEVİR' as [BASLIK1]
      ,'DEVİR' as [BASLIK2]
      ,'DEVİR' as [BASLIK3]
      ,'' as [BASLIK4]
      ,'' as [BASLIK1ID]
      ,'' as [BASLIK2ID]
      ,'' as [BASLIK3ID]
      ,'' as [BASLIK4ID]
      ,'' as [Hafta]
     ,'' as HESAPTURU
     ,@USERID
  FROM [TIGER2_DB].[dbo].[VW_118_21_NAKIT_AKIS] where [TARIH] < @IlkTarih  AND ISLEMTURU IS NOT NULL
 GROUP BY [ISYERI]
UNION ALL

SELECT [ISLEMTURU]
      ,[MODUL]
      ,[TARIH]
      ,[YIL]
      ,[AY]
      ,[GUN]
      ,[FISNO]
      ,[DOVIZKURU]
      ,[DOVIZLITUTAR]
	  ,[DOVIZKURU_EURO]
      ,[DOVIZLITUTAR_EURO]
      ,[TUTAR]
      ,[BANKAHSPADI]
      ,[ACIKLAMA]
      ,[BANKAKONTNO]
      ,[BANKAHSPKODU]
      ,[BANKAKODU]
      ,[BANKAADI]
      ,[CARINO]
      ,[CARIADI]
      ,[ISYERI]
      ,[BOLUM]
      ,[HESAPGRUBU]
      ,[MMRKKODU]
      ,[MMRKADI]
      ,[MHESAPKODU]
      ,[MHESAPADI]
      ,[FINANSKOD]
      ,[FINANSACIKLAMA]
      ,[BASLIK1]
      ,[BASLIK2]
      ,[BASLIK3]
      ,[BASLIK4]
      ,[BASLIK1ID]
      ,[BASLIK2ID]
      ,[BASLIK3ID]
      ,[BASLIK4ID]
      ,[Hafta]
       , HESAPTURU
       ,@USERID
  FROM [TIGER2_DB].[dbo].[VW_118_21_NAKIT_AKIS] WHERE TARIH BETWEEN @IlkTarih AND @SonTarih AND ISLEMTURU IS NOT NULL
UNION ALL


SELECT 'Kapanış İşlemi' AS [ISLEMTURU]
      ,'Banka' AS [MODUL]
      ,@IlkTarih as [TARIH]
      ,year(@IlkTarih) as [YIL]
      ,month(@IlkTarih) [AY]
      ,day(@IlkTarih) [GUN]
      ,'0' as [FISNO]
      ,0 as [DOVIZKURU]
    ,sum([DOVIZLITUTAR]) as [DOVIZLITUTAR]
	   ,0 as [DOVIZKURU_EURO]
    ,sum([DOVIZLITUTAR_EURO]) as [DOVIZLITUTAR_EURO]
      ,sum([TUTAR]) AS TUTAR
      ,'' as [BANKAHSPADI]
      ,'' as [ACIKLAMA]
      ,'' as [BANKAKONTNO]
      ,'' as [BANKAHSPKODU]
      ,'' as [BANKAKODU]
      ,'' as [BANKAADI]
      ,'' as [CARINO]
      ,'' as [CARIADI]
      , [ISYERI]
      ,'' as [BOLUM]
      ,'' as [HESAPGRUBU]
      ,'' as [MMRKKODU]
      ,'' as [MMRKADI]
      ,'' as [MHESAPKODU]
      ,'' as [MHESAPADI]
      ,'' as [FINANSKOD]
      ,'' as [FINANSACIKLAMA]
      ,'   D.TOPLAM' as [BASLIK1]
      ,'TOPLAM' as [BASLIK2]
      ,'TOPLAM' as [BASLIK3]
      ,'' as [BASLIK4]
      ,'' as [BASLIK1ID]
      ,'' as [BASLIK2ID]
      ,'' as [BASLIK3ID]
      ,'' as [BASLIK4ID]
      ,'' as [Hafta]
      , '' AS HESAPTURU
      ,@USERID
  FROM [TIGER2_DB].[dbo].[VW_118_21_NAKIT_AKIS] where [TARIH] <= @SonTarih AND ISLEMTURU IS NOT NULL
   GROUP BY [ISYERI]
  
  end






