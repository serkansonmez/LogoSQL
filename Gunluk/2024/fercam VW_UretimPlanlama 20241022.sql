USE [FercamB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_UretimPlanlama]    Script Date: 22.10.2024 13:39:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










--  select * from OperasyonTanimi


 -- select * from [VW_UretimPlanlama] where KesilenAdet > 0 and siparisNo = '230621011'     
  --ALTER VIEW [dbo].[VW_UretimPlanlama] AS 
SELECT   
    ORFLINE.LOGICALREF,   
    ORFICHE.FICHENO AS SiparisNo,
    ORFICHE.DOCODE as MusteriSiparisNo,
    ORFICHE.DATE_ as SiparisTarihi,
    ITEMS.CODE COLLATE SQL_Latin1_General_CP1_CI_AS AS [MalzemeKodu],                         
    PRODORD.FICHENO as UretimEmriNo,
    --tblDetay.ROTA_KODU AS RotaKodu,
    --tblDetay.FIRIN_ROTA_KODU AS FirinRotaKodu,
	UretimRotaBaglanti.RotaKodu,
	UretimRotaBaglanti.FirinRotasi AS FirinRotaKodu,
    ITEMS.NAME AS UrunKodu,
    CLCARD.CODE AS [FirmaKodu], 
    CLCARD.DEFINITION_ AS [FirmaAdi], 
    ORFLINE.AMOUNT AS [SiparisAdet],
   PRODORD.ACTAMOUNT AS [KesimAdet],
  
    tblDetay.RENK AS Renk,
    tblDetay.EN AS En,
    tblDetay.BOY AS Boy,
    tblDetay.KALINLIK AS Kalinlik,
    tblDetay.EN * tblDetay.BOY * ORFLINE.AMOUNT / 1000000 AS SiparisToplamAlan,
    tblDetay.BOMBE  as Firin,
    tblDetay.SERIGRAF  as Serigraf,
    0  as ToplamCap,
    tblDetay.EN * tblDetay.BOY  / 10000 AS BirimM2,
    
    CASE WHEN VW_KesimIsEmriToplamlari.GerceklesenAdet > 0 THEN 'Kesim' END as MevcutOperasyonDurumu,
    dbo.GetNextOperation(
        ITEMS.CODE COLLATE SQL_Latin1_General_CP1_CI_AS,
        CASE WHEN VW_KesimIsEmriToplamlari.GerceklesenAdet > 0 THEN 'Kesim' END
    ) as SonrakiOperasyon,

	 VW_KesimIsEmriToplamlari.OptimizasyonAdet as KesimPlanlanan,
	 VW_KesimIsEmriToplamlari.GerceklesenAdet as KesilenAdet,
    isnull(tblKesimSehpa.SehpaAdet,0 ) as KesimSehpaAdet,

	isnull(BandoTable.BandoAdet, 0) as   BandoSaglamAdet,
	isnull(tblBandoSehpa.SehpaAdet, 0) as   BandoSehpaAdet,
	case when isnull(BandoTable.BandoAdet, 0) = isnull(tblBandoSehpa.SehpaAdet, 0) and isnull(tblBandoSehpa.SehpaAdet, 0)=0 then 1
	     when isnull(BandoTable.BandoAdet, 0) = isnull(tblBandoSehpa.SehpaAdet, 0) and isnull(tblBandoSehpa.SehpaAdet, 0)>0 then 3
	     when isnull(BandoTable.BandoAdet, 0) <> isnull(tblBandoSehpa.SehpaAdet, 0)  then 2
    end as BandoDurumId,
	tblBandoDurumu.DurumAdi as BandoDurumAdi,
	isnull(BandoTable.IsIstasyonlariId,0) as BandoIsIstasyonlariId,

	isnull(CncTable.CncAdet, 0) as   CncSaglamAdet,
	isnull(tblCncSehpa.SehpaAdet, 0) as   CncSehpaAdet,
	case when isnull(CncTable.CncAdet, 0) = isnull(tblCncSehpa.SehpaAdet, 0) and isnull(tblCncSehpa.SehpaAdet, 0)=0 then 1
	     when isnull(CncTable.CncAdet, 0) = isnull(tblCncSehpa.SehpaAdet, 0) and isnull(tblCncSehpa.SehpaAdet, 0)>0 then 3
	     when isnull(CncTable.CncAdet, 0) <> isnull(tblCncSehpa.SehpaAdet, 0)  then 2
    end as CncDurumId,
	tblCncDurumu.DurumAdi as CncDurumAdi,
	isnull(CncTable.IsIstasyonlariId,0) as CncIsIstasyonlariId,

	isnull(DelikTable.DelikAdet, 0) as   DelikSaglamAdet,
	isnull(tblDelikSehpa.SehpaAdet, 0) as   DelikSehpaAdet,
	case when isnull(DelikTable.DelikAdet, 0) = isnull(tblDelikSehpa.SehpaAdet, 0) and isnull(tblDelikSehpa.SehpaAdet, 0)=0 then 1
	     when isnull(DelikTable.DelikAdet, 0) = isnull(tblDelikSehpa.SehpaAdet, 0) and isnull(tblDelikSehpa.SehpaAdet, 0)>0 then 3
	     when isnull(DelikTable.DelikAdet, 0) <> isnull(tblDelikSehpa.SehpaAdet, 0)  then 2
    end as DelikDurumId,
	tblDelikDurumu.DurumAdi as DelikDurumAdi,
	isnull(DelikTable.IsIstasyonlariId,0) as DelikIsIstasyonlariId

--DATEPART(WEEK, ORFICHE.DATE_) AS [Sipariþ Haftasý], ORFICHE.DATE_ AS [Sipariþ Tarihi],                         
--(CASE ORFLINE.CLOSED WHEN 0 THEN 'Bekliyor' WHEN 1 THEN 'Kapandý' END) AS Statü, 
--  ITEMS.STGRPCODE AS [Malzeme Grup Kodu], ITEMS.SPECODE3 AS [Özel Kod3],                         
--  ORFLINE.SHIPPEDAMOUNT AS [Sevk Miktarý], ORFLINE.AMOUNT - ORFLINE.SHIPPEDAMOUNT AS Kalan,                         
--ORFLINE.LINEEXP AS [Satýr Açýklamasý], ORFLINE.DUEDATE AS [Teslim Tarihi], ORFLINE.PRICE AS Fiyat, (ORFLINE.AMOUNT - ORFLINE.SHIPPEDAMOUNT)   
--* ORFLINE.PRICE AS [Kalan Tutar], TEDARIKCI.ICUSTSUPCODE AS [Musteri Kodu], MONTH(ORFLINE.DUEDATE) AS [Teslim Ay]   

FROM         
    TIGER.dbo.LG_024_01_ORFLINE AS ORFLINE 
    INNER JOIN TIGER.dbo.LG_024_01_ORFICHE AS ORFICHE ON ORFLINE.ORDFICHEREF = ORFICHE.LOGICALREF 
    INNER JOIN TIGER.dbo.LG_024_ITEMS AS ITEMS ON ORFLINE.STOCKREF = ITEMS.LOGICALREF 
    INNER JOIN TIGER.dbo.LG_024_CLCARD AS CLCARD ON ORFLINE.CLIENTREF = CLCARD.LOGICALREF 
    LEFT OUTER JOIN (SELECT ITEMREF, CLIENTREF, ICUSTSUPCODE FROM TIGER.dbo.LG_024_SUPPASGN) AS TEDARIKCI 
        ON CLCARD.LOGICALREF = TEDARIKCI.CLIENTREF AND ITEMS.LOGICALREF = TEDARIKCI.ITEMREF  
    LEFT JOIN TIGER..LG_024_PEGGING PEGGING ON PEGGING.PORDFICHEREF = ORFICHE.LOGICALREF AND PEGGING.PORDLINEREF = ORFLINE.LOGICALREF 
    LEFT JOIN TIGER..LG_024_PRODORD PRODORD ON PEGGING.PEGREF = PRODORD.LOGICALREF
   -- LEFT JOIN TIGER..LG_XT050_024 tblDetay ON tblDetay.PARLOGREF = ORFLINE.STOCKREF
    LEFT JOIN TIGER..LG_XT050_024 tblDetay ON tblDetay.PARLOGREF = ITEMS.LOGICALREF
	left join UretimRotaBaglanti on UretimRotaBaglanti.FercamKodu collate Turkish_CI_AS = ITEMS.CODE
    LEFT JOIN VW_KesimIsEmriToplamlari ON VW_KesimIsEmriToplamlari.IsEmriNo  = PRODORD.FICHENO 
    LEFT JOIN (SELECT [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=1 GROUP BY [IsEmriNo]) AS tblKesimSehpa  ON tblKesimSehpa.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
       
	LEFT JOIN (select  IsEmriNo, isnull(sum(SaglamCamAdet),0) as BandoAdet,IsIstasyonlariId from OperasyonHareket where OperasyonTanimiId=2 group by IsEmriNo,IsIstasyonlariId ) AS BandoTable on BandoTable.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
	LEFT JOIN (SELECT  [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=2 GROUP BY [IsEmriNo]) AS tblBandoSehpa   ON  rtrim(tblBandoSehpa.IsEmriNo)  collate Turkish_CI_AS =  rtrim(PRODORD.FICHENO) 
	left join IslemDurumu tblBandoDurumu with(nolock) on tblBandoDurumu.IslemDurumuId = 	case when isnull(BandoTable.BandoAdet, 0) = isnull(tblBandoSehpa.SehpaAdet, 0) and isnull(tblBandoSehpa.SehpaAdet, 0)=0 then 1
											 when isnull(BandoTable.BandoAdet, 0) = isnull(tblBandoSehpa.SehpaAdet, 0) and isnull(tblBandoSehpa.SehpaAdet, 0)>0 then 3
											 when isnull(BandoTable.BandoAdet, 0) <> isnull(tblBandoSehpa.SehpaAdet, 0)  then 2
										end

	LEFT JOIN (select  IsEmriNo, isnull(sum(SaglamCamAdet),0) as CncAdet,IsIstasyonlariId from OperasyonHareket where OperasyonTanimiId=4 group by IsEmriNo, IsIstasyonlariId ) AS CncTable on CncTable.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
	LEFT JOIN (SELECT  [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=4 GROUP BY [IsEmriNo]) AS tblCncSehpa   ON  rtrim(tblCncSehpa.IsEmriNo)  collate Turkish_CI_AS =  rtrim(PRODORD.FICHENO) 
	left join IslemDurumu tblCncDurumu with(nolock) on tblCncDurumu.IslemDurumuId = 	case when isnull(CncTable.CncAdet, 0) = isnull(tblCncSehpa.SehpaAdet, 0) and isnull(tblCncSehpa.SehpaAdet, 0)=0 then 1
											 when isnull(CncTable.CncAdet, 0) = isnull(tblCncSehpa.SehpaAdet, 0) and isnull(tblCncSehpa.SehpaAdet, 0)>0 then 3
											 when isnull(CncTable.CncAdet, 0) <> isnull(tblCncSehpa.SehpaAdet, 0)  then 2
										end

	LEFT JOIN (select  IsEmriNo, isnull(sum(SaglamCamAdet),0) as DelikAdet,IsIstasyonlariId from OperasyonHareket where OperasyonTanimiId=5 group by IsEmriNo,IsIstasyonlariId ) AS DelikTable on DelikTable.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
	LEFT JOIN (SELECT  [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=5 GROUP BY [IsEmriNo]) AS tblDelikSehpa   ON  rtrim(tblDelikSehpa.IsEmriNo)  collate Turkish_CI_AS =  rtrim(PRODORD.FICHENO) 
	left join IslemDurumu tblDelikDurumu with(nolock) on tblDelikDurumu.IslemDurumuId = 	case when isnull(DelikTable.DelikAdet, 0) = isnull(tblDelikSehpa.SehpaAdet, 0) and isnull(tblDelikSehpa.SehpaAdet, 0)=0 then 1
											 when isnull(DelikTable.DelikAdet, 0) = isnull(tblDelikSehpa.SehpaAdet, 0) and isnull(tblDelikSehpa.SehpaAdet, 0)>0 then 3
											 when isnull(DelikTable.DelikAdet, 0) <> isnull(tblDelikSehpa.SehpaAdet, 0)  then 2
										end

WHERE    
    (ORFICHE.TRCODE = 1) AND (ORFLINE.AMOUNT - ORFLINE.SHIPPEDAMOUNT > 0)

--and ORFICHE.FICHENO  = '231201002'

--SELECT * FROM LG_XT050_024


--select * from VW_KesimIsEmriToplamlari
 
GO


