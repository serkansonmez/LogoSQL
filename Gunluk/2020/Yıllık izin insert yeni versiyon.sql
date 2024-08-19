USE [SuperIk_DB]
GO
--select * from  [PersonelIzinTurleri]
 
insert into [PersonelIzin]
SELECT  0 [RowDeleted]
      ,GETDATE() [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,VW_YillikIzinHakedisListesi.UcretPersonelId [UcretPersonelId]
      ,1 as [PersonelIzinTurleriId]   --Yýllýk izin
      ,GerceklesecekTarih as [BaslangicTarihi]
      ,DATEADD(YY,1,GerceklesecekTarih )
      ,isnull(Krc2020IzinExcel.[2020KullanilanIzin] + Krc2020IzinExcel.KalanIzin,0) as [DevirGunu]
      ,null [IzinGunu]
      ,isnull(Krc2020IzinExcel.[2020KullanilanIzin] + Krc2020IzinExcel.KalanIzin,0) [KalanGun]
      ,year(GerceklesecekTarih) [IzinYili]
      ,null [IzinAdresi]
      ,null [IzinTelefonNo]
  FROM [dbo].[PersonelIzin]
  right join VW_YillikIzinHakedisListesi on VW_YillikIzinHakedisListesi.UcretPersonelId = [PersonelIzin].UcretPersonelId and [PersonelIzin].[PersonelIzinTurleriId] = 1
  
  left join UcretPersonel on UcretPersonel.Id = VW_YillikIzinHakedisListesi.UcretPersonelId
  left join Krc2020IzinExcel on (UcretPersonel.Adi + ' ' + Soyadi) = Krc2020IzinExcel.AdiSoyadi
  where [PersonelIzin].Id is null
--select * from [PersonelIzinTurleri]
insert into [PersonelIzin]
SELECT  0 [RowDeleted]
      ,GETDATE() [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,VW_YillikIzinHakedisListesi.UcretPersonelId [UcretPersonelId]
      ,6 as [PersonelIzinTurleriId]   --Yýllýk izin
     
      ,DATEADD(DD, Krc2020IzinExcel.[2020KullanilanIzin] * -1,'20200731' )
	   ,'20200731' as [BaslangicTarihi]
      ,null as [DevirGunu]
      ,isnull(Krc2020IzinExcel.[2020KullanilanIzin],0) as [IzinGunu]
      ,isnull( Krc2020IzinExcel.KalanIzin,0) [KalanGun]
      ,year(GerceklesecekTarih) [IzinYili]
      ,null [IzinAdresi]
      ,null [IzinTelefonNo]
  FROM [dbo].[PersonelIzin]
  right join VW_YillikIzinHakedisListesi on VW_YillikIzinHakedisListesi.UcretPersonelId = [PersonelIzin].UcretPersonelId and [PersonelIzin].[PersonelIzinTurleriId] = 6
  
  left join UcretPersonel on UcretPersonel.Id = VW_YillikIzinHakedisListesi.UcretPersonelId
  left join Krc2020IzinExcel on (UcretPersonel.Adi + ' ' + Soyadi) = Krc2020IzinExcel.AdiSoyadi
  where [PersonelIzin].Id is null and isnull(Krc2020IzinExcel.[2020KullanilanIzin],0)>0
  
  --select * from Krc2020IzinExcel
  --select * from VW_YillikIzinHakedisListesi
GO


