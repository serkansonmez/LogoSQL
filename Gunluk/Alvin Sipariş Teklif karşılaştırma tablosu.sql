USE [AlvinB2B_Default_v1]
GO

SELECT MusteriAdi, sum(SiparisTutariKdvHaric) as SiparisTutariKdvHaric, sum(SiparisSayi) as SiparisSayi, sum(TeklifTutariKdvHaric) as TeklifTutariKdvHaric, sum(TeklifSayi) as TeklifSayi,
case when sum(TeklifTutariKdvHaric) > 0 then round(sum(SiparisTutariKdvHaric) / sum(TeklifTutariKdvHaric),2) * 100 else 0 end  as TeklifSiparisOrani
from (
SELECT MusteriAdi, sum(KdvHaricTutar) as SiparisTutariKdvHaric, count(KdvHaricTutar) as SiparisSayi, 0 as TeklifTutariKdvHaric, 0 as TeklifSayi
  FROM [dbo].[VW_TeklifRaporu] where Aktif= 1 and SipariseDonusmeTarihi is not null
GROUP BY MusteriAdi
UNION ALL
SELECT MusteriAdi, 0 as SiparisTutariKdvHaric, 0 as SiparisSayi, sum(KdvHaricTutar) as TeklifTutariKdvHaric, count(KdvHaricTutar) as TeklifSayi
  FROM [dbo].[VW_TeklifRaporu] where Aktif= 1 and SipariseDonusmeTarihi is   null
GROUP BY MusteriAdi ) as tbl group by MusteriAdi
order by sum(TeklifSayi) desc


