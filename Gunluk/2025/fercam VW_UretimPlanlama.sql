USE [FercamB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_UretimPlanlama]    Script Date: 25.02.2025 10:50:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO















--select * from [VW_UretimPlanlama]  where UretimEmriNo =   '2409.0173'

-- ALTER VIEW [dbo].[VW_UretimPlanlama]  AS
WITH KesimDurumu AS (
    SELECT 
        VW_KesimIsEmriToplamlari.IsEmriNo,
         CASE 
            WHEN VW_KesimIsEmriToplamlari.GerceklesenAdet = 0 AND ISNULL(tblKesimSehpa.SehpaAdet, 0) = 0 THEN 1
			 WHEN VW_KesimIsEmriToplamlari.OptimizasyonAdet + ISNULL(KesimTable.HurdaCamAdet, 0) <= VW_KesimIsEmriToplamlari.GerceklesenAdet 
                AND ISNULL(tblKesimSehpa.SehpaAdet, 0) = VW_KesimIsEmriToplamlari.OptimizasyonAdet + ISNULL(KesimTable.HurdaCamAdet, 0) THEN 3
		 
		 WHEN VW_KesimIsEmriToplamlari.OptimizasyonAdet + ISNULL(KesimTable.HurdaCamAdet, 0) <> VW_KesimIsEmriToplamlari.GerceklesenAdet 
                AND ISNULL(tblKesimSehpa.SehpaAdet, 0) < VW_KesimIsEmriToplamlari.GerceklesenAdet + ISNULL(KesimTable.HurdaCamAdet, 0)
				AND VW_KesimIsEmriToplamlari.GerceklesenAdet > ISNULL(tblKesimSehpa.SehpaAdet, 0) THEN 2
		 WHEN VW_KesimIsEmriToplamlari.OptimizasyonAdet + ISNULL(KesimTable.HurdaCamAdet, 0) > VW_KesimIsEmriToplamlari.GerceklesenAdet 
              THEN 2
           
			WHEN VW_KesimIsEmriToplamlari.OptimizasyonAdet + ISNULL(KesimTable.HurdaCamAdet, 0) = VW_KesimIsEmriToplamlari.GerceklesenAdet 
                AND ISNULL(tblKesimSehpa.SehpaAdet, 0) < VW_KesimIsEmriToplamlari.GerceklesenAdet + ISNULL(KesimTable.HurdaCamAdet, 0) THEN 4
         
        END AS KesimDurumId,
		KesimTable.HurdaCamAdet,
		VW_KesimIsEmriToplamlari.GerceklesenAdet as KesimAdet,
		tblKesimSehpa.SehpaAdet,
		VW_KesimIsEmriToplamlari.OptimizasyonAdet as PlanlananAdet ,
		IsIstasyonlariId ,
		VW_KesimIsEmriToplamlari.IseBaslangicSaati as IseBaslangicSaati
    FROM 
       (select IsEmriNo,sum(OptimizasyonAdet) as OptimizasyonAdet,sum( GerceklesenAdet) as GerceklesenAdet,FercamKodu,MIN(IseBaslangicSaati) as IseBaslangicSaati  from VW_KesimIsEmriToplamlari   group by IsEmriNo,FercamKodu) VW_KesimIsEmriToplamlari
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet,MIN(Tarih) as Tarih FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 1 GROUP BY IsEmriNo) AS tblKesimSehpa 
            ON tblKesimSehpa.IsEmriNo collate Turkish_CI_AS = VW_KesimIsEmriToplamlari.IsEmriNo
        LEFT JOIN (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as KesimAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) AS IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket where (OperasyonTanimiId=1 or OperasyonTanimiId is null)  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=1 group by OperasyonHareket.IsEmriNo ) AS  KesimTable ON KesimTable.IsEmriNo collate Turkish_CI_AS = VW_KesimIsEmriToplamlari.IsEmriNo
),

--select* from VW_KesimIsEmriToplamlari
BandoDurumu AS (
    SELECT 
        BandoTable.IsEmriNo,
        CASE 

            WHEN   BandoTable.BandoAdet   =  tblBandoSehpa.SehpaAdet 
                AND  tblBandoSehpa.SehpaAdet  = 0 THEN 1
            WHEN  BandoTable.BandoAdet   =  tblBandoSehpa.SehpaAdet 
                AND  tblBandoSehpa.SehpaAdet > 0 THEN 3
            WHEN  BandoTable.BandoAdet   <>  tblBandoSehpa.SehpaAdet  THEN 2
        END AS BandoDurumId,
		BandoTable.HurdaCamAdet,
		BandoTable.BandoAdet,
		tblBandoSehpa.SehpaAdet,
		BandoTable.IsIstasyonlariId,
		BandoTable.IseBaslangicSaati
		
	--	isnull(KD.SehpaAdet,0) as BandoPlanlanan  --select * from OperasyonHareket
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as BandoAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=2  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=2 group by OperasyonHareket.IsEmriNo  ) AS BandoTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 2 GROUP BY IsEmriNo) AS tblBandoSehpa 
            ON tblBandoSehpa.IsEmriNo = BandoTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  BandoTable.IsEmriNo  
),
CncDurumu AS (
    SELECT 
        CncTable.IsEmriNo,
        CASE 
            WHEN ISNULL(CncTable.CncAdet, 0) + ISNULL(CncTable.HurdaCamAdet, 0) = ISNULL(tblCncSehpa.SehpaAdet, 0) 
                AND ISNULL(tblCncSehpa.SehpaAdet, 0) = 0 THEN 1
            WHEN ISNULL(CncTable.CncAdet, 0) + ISNULL(CncTable.HurdaCamAdet, 0) = ISNULL(tblCncSehpa.SehpaAdet, 0) 
                AND ISNULL(tblCncSehpa.SehpaAdet, 0) > 0 THEN 3
            WHEN ISNULL(CncTable.CncAdet, 0) + ISNULL(CncTable.HurdaCamAdet, 0) <> ISNULL(tblCncSehpa.SehpaAdet, 0) THEN 2
        END AS CncDurumId,
		CncTable.HurdaCamAdet,
		CncTable.CncAdet,
		tblCncSehpa.SehpaAdet,
		CncTable.IsIstasyonlariId  ,
		CncTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0) as CncPlanlanan
    FROM 
         (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as CncAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=4   group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=4 group by OperasyonHareket.IsEmriNo ) AS CncTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 4 GROUP BY IsEmriNo) AS tblCncSehpa 
            ON tblCncSehpa.IsEmriNo = CncTable.IsEmriNo
			 --LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  CncTable.IsEmriNo 
			 --LEFT JOIN BandoDurumu AS BD ON BD.IsEmriNo collate Turkish_CI_AS  =  CncTable.IsEmriNo 
),
DelikDurumu AS (
    SELECT 
        DelikTable.IsEmriNo,
        CASE 
            WHEN ISNULL(DelikTable.DelikAdet, 0) + ISNULL(DelikTable.HurdaCamAdet, 0) = ISNULL(tblDelikSehpa.SehpaAdet, 0) 
                AND ISNULL(tblDelikSehpa.SehpaAdet, 0) = 0 THEN 1
            WHEN ISNULL(DelikTable.DelikAdet, 0) + ISNULL(DelikTable.HurdaCamAdet, 0) = ISNULL(tblDelikSehpa.SehpaAdet, 0) 
                AND ISNULL(tblDelikSehpa.SehpaAdet, 0) > 0 THEN 3
            WHEN ISNULL(DelikTable.DelikAdet, 0) + ISNULL(DelikTable.HurdaCamAdet, 0) <> ISNULL(tblDelikSehpa.SehpaAdet, 0) THEN 2
        END AS DelikDurumId,
		DelikTable.HurdaCamAdet,
		DelikTable.DelikAdet,
		tblDelikSehpa.SehpaAdet,
		DelikTable.IsIstasyonlariId  ,
		DelikTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0)as DelikPlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as DelikAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=5  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=5 group by OperasyonHareket.IsEmriNo  ) AS  DelikTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 5 GROUP BY IsEmriNo) AS tblDelikSehpa 
            ON tblDelikSehpa.IsEmriNo = DelikTable.IsEmriNo
		 --LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  DelikTable.IsEmriNo 
		 --LEFT JOIN BandoDurumu AS BD ON BD.IsEmriNo collate Turkish_CI_AS  =  DelikTable.IsEmriNo 
		 --LEFT JOIN BandoDurumu AS CD ON CD.IsEmriNo collate Turkish_CI_AS  =  DelikTable.IsEmriNo 
),

 
SerigrafDurumu AS (
    SELECT 
        SerigrafTable.IsEmriNo,
        CASE 

            WHEN   SerigrafTable.SerigrafAdet   =  tblSerigrafSehpa.SehpaAdet 
                AND  tblSerigrafSehpa.SehpaAdet  = 0 THEN 1
            WHEN  SerigrafTable.SerigrafAdet   =  tblSerigrafSehpa.SehpaAdet 
                AND  tblSerigrafSehpa.SehpaAdet > 0 THEN 3
            WHEN  SerigrafTable.SerigrafAdet   <>  tblSerigrafSehpa.SehpaAdet  THEN 2
        END AS SerigrafDurumId,
		SerigrafTable.HurdaCamAdet,
		SerigrafTable.SerigrafAdet,
		tblSerigrafSehpa.SehpaAdet,
		SerigrafTable.IsIstasyonlariId   ,
		SerigrafTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) as SerigrafPlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as SerigrafAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=6  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=6 group by OperasyonHareket.IsEmriNo ) AS SerigrafTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 6 GROUP BY IsEmriNo) AS tblSerigrafSehpa 
            ON tblSerigrafSehpa.IsEmriNo = SerigrafTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  SerigrafTable.IsEmriNo  
),


FirinDurumu AS (
    SELECT 
        FirinTable.IsEmriNo,
        CASE 

            WHEN   FirinTable.FirinAdet   =  tblFirinSehpa.SehpaAdet 
                AND  tblFirinSehpa.SehpaAdet  = 0 THEN 1
            WHEN  FirinTable.FirinAdet   =  tblFirinSehpa.SehpaAdet 
                AND  tblFirinSehpa.SehpaAdet > 0 THEN 3
            WHEN  FirinTable.FirinAdet   <>  tblFirinSehpa.SehpaAdet  THEN 2
        END AS FirinDurumId,
		FirinTable.HurdaCamAdet,
		FirinTable.FirinAdet,
		tblFirinSehpa.SehpaAdet,
		FirinTable.IsIstasyonlariId ,
		FirinTable.IseBaslangicSaati  
		--isnull(KD.SehpaAdet,0) as FirinPlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as FirinAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=7  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=7 group by OperasyonHareket.IsEmriNo  ) AS FirinTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 7 GROUP BY IsEmriNo) AS tblFirinSehpa 
            ON tblFirinSehpa.IsEmriNo = FirinTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  FirinTable.IsEmriNo  
),


PaketlemeDurumu AS (
    SELECT 
        PaketlemeTable.IsEmriNo,
        CASE 

            WHEN   PaketlemeTable.PaketlemeAdet   =  tblPaketlemeSehpa.SehpaAdet 
                AND  tblPaketlemeSehpa.SehpaAdet  = 0 THEN 1
            WHEN  PaketlemeTable.PaketlemeAdet   =  tblPaketlemeSehpa.SehpaAdet 
                AND  tblPaketlemeSehpa.SehpaAdet > 0 THEN 3
            WHEN  PaketlemeTable.PaketlemeAdet   <>  tblPaketlemeSehpa.SehpaAdet  THEN 2
        END AS PaketlemeDurumId,
		PaketlemeTable.HurdaCamAdet,
		PaketlemeTable.PaketlemeAdet,
		tblPaketlemeSehpa.SehpaAdet,
		PaketlemeTable.IsIstasyonlariId,
		PaketlemeTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) as PaketlemePlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as PaketlemeAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=9  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=9 group by OperasyonHareket.IsEmriNo  ) AS PaketlemeTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 9 GROUP BY IsEmriNo) AS tblPaketlemeSehpa 
            ON tblPaketlemeSehpa.IsEmriNo = PaketlemeTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  PaketlemeTable.IsEmriNo  
),

RezistansDurumu AS (
    SELECT 
        RezistansTable.IsEmriNo,
        CASE 

            WHEN   RezistansTable.RezistansAdet   =  tblRezistansSehpa.SehpaAdet 
                AND  tblRezistansSehpa.SehpaAdet  = 0 THEN 1
            WHEN  RezistansTable.RezistansAdet   =  tblRezistansSehpa.SehpaAdet 
                AND  tblRezistansSehpa.SehpaAdet > 0 THEN 3
            WHEN  RezistansTable.RezistansAdet   <>  tblRezistansSehpa.SehpaAdet  THEN 2
        END AS RezistansDurumId,
		RezistansTable.HurdaCamAdet,
		RezistansTable.RezistansAdet,
		tblRezistansSehpa.SehpaAdet,
		RezistansTable.IsIstasyonlariId,
		RezistansTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) as RezistansPlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as RezistansAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=100  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=100 group by OperasyonHareket.IsEmriNo  ) AS RezistansTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 100 GROUP BY IsEmriNo) AS tblRezistansSehpa 
            ON tblRezistansSehpa.IsEmriNo = RezistansTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  RezistansTable.IsEmriNo  
),


ShrinkDurumu AS (
    SELECT 
        ShrinkTable.IsEmriNo,
        CASE 

            WHEN   ShrinkTable.ShrinkAdet   =  tblShrinkSehpa.SehpaAdet 
                AND  tblShrinkSehpa.SehpaAdet  = 0 THEN 1
            WHEN  ShrinkTable.ShrinkAdet   =  tblShrinkSehpa.SehpaAdet 
                AND  tblShrinkSehpa.SehpaAdet > 0 THEN 3
            WHEN  ShrinkTable.ShrinkAdet   <>  tblShrinkSehpa.SehpaAdet  THEN 2
        END AS ShrinkDurumId,
		ShrinkTable.HurdaCamAdet,
		ShrinkTable.ShrinkAdet,
		tblShrinkSehpa.SehpaAdet,
		ShrinkTable.IsIstasyonlariId,
		ShrinkTable.IseBaslangicSaati
		--isnull(KD.SehpaAdet,0) as ShrinkPlanlanan
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as ShrinkAdet,max(IsIstasyonlariId) as IsIstasyonlariId,isnull(avg(HurdaCamAdet),0) as HurdaCamAdet,MIN(IseBaslangicSaati) as IseBaslangicSaati from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  where OperasyonTanimiId=101 group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=101 group by OperasyonHareket.IsEmriNo  ) AS ShrinkTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 101 GROUP BY IsEmriNo) AS tblShrinkSehpa 
            ON tblShrinkSehpa.IsEmriNo = ShrinkTable.IsEmriNo
       -- LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS  =  ShrinkTable.IsEmriNo  
)





 


 
SELECT   
    ORFLINE.LOGICALREF,   
    ORFICHE.FICHENO AS SiparisNo,
    ORFICHE.DOCODE AS MusteriSiparisNo,
    ORFICHE.DATE_ AS SiparisTarihi,
    ITEMS.CODE COLLATE SQL_Latin1_General_CP1_CI_AS AS [MalzemeKodu],                         
    PRODORD.FICHENO AS UretimEmriNo,
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
    tblDetay.BOMBE AS Firin,
    tblDetay.SERIGRAF AS Serigraf,
    0 AS ToplamCap,
    tblDetay.EN * tblDetay.BOY / 10000 AS BirimM2,

	 --VW_KesimIsEmriToplamlari.OptimizasyonAdet as KesimPlanlanan,
	 
	 --VW_KesimIsEmriToplamlari.GerceklesenAdet as KesilenAdet,
  --  isnull(tblKesimSehpa.SehpaAdet,0 ) as KesimSehpaAdet,
	 -- isnull(KesimTable.HurdaCamAdet, 0) as   KesimHurdaCamAdet,

    dbo.fn_RotaMevcutDurumu(UretimRotaBaglanti.RotaKodu, isnull(KD.KesimDurumId,1),  isnull(BD.BandoDurumId,1), 1,  isnull(CD.CncDurumId,1),  isnull(DD.DelikDurumId,1), 1, 1, 1) AS MevcutOperasyonDurumu,
    dbo.GetNextOperation(
        ITEMS.CODE COLLATE SQL_Latin1_General_CP1_CI_AS,
        dbo.fn_RotaMevcutDurumu(UretimRotaBaglanti.RotaKodu, isnull(KD.KesimDurumId,1),  isnull(BD.BandoDurumId,1), 1,  isnull(CD.CncDurumId,1),  isnull(DD.DelikDurumId,1), 1, 1, 1)
    ) AS SonrakiOperasyon,

    KD.PlanlananAdet AS KesimPlanlanan,
    KD.KesimAdet AS KesilenAdet,
    ISNULL(KD.SehpaAdet, 0) AS KesimSehpaAdet,
    ISNULL(KD.HurdaCamAdet, 0) AS KesimHurdaCamAdet,
    isnull(KD.KesimDurumId,1) as KesimDurumId,
	isnull(tblKesimDurumu.DurumAdi,'Baþlamadý') as KesimDurumAdi,
	isnull(KD.IsIstasyonlariId,0) as KesimIsIstasyonlariId,
	KD.IseBaslangicSaati AS KesimIseBaslangicSaati,

	--isnull(BD.BandoPlanlanan,0) as   BandoPlanlanan, 
	isnull(KD.SehpaAdet,0) as BandoPlanlanan,
	isnull(BD.BandoAdet, 0) as   BandoSaglamAdet,
	isnull(BD.SehpaAdet, 0) as   BandoSehpaAdet,
    isnull(BD.HurdaCamAdet, 0) as   BandoHurdaCamAdet,
    isnull(BD.BandoDurumId,1) AS BandoDurumId,
	isnull(tblBandoDurumu.DurumAdi,'Baþlamadý') as BandoDurumAdi,
	isnull(BD.IsIstasyonlariId,0) as BandoIsIstasyonlariId,
	BD.IseBaslangicSaati AS BandoIseBaslangicSaati,

	--isnull(CD.CncPlanlanan,0) as   CncPlanlanan,
	isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0) as CncPlanlanan,
    isnull(CD.CncAdet, 0) as   CncSaglamAdet,
	isnull(CD.SehpaAdet, 0) as   CncSehpaAdet,
    isnull(CD.HurdaCamAdet, 0) as   CncHurdaCamAdet,
    isnull(CD.CncDurumId,1) as CncDurumId,
	isnull(tblCncDurumu.DurumAdi,'Baþlamadý') as CncDurumAdi,
	isnull(CD.IsIstasyonlariId,0) as CncIsIstasyonlariId,
	CD.IseBaslangicSaati AS CncIseBaslangicSaati, 

	--isnull(DD.DelikPlanlanan,0) as   DelikPlanlanan,
	isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0)as DelikPlanlanan,
	isnull(DD.DelikAdet, 0) as   DelikSaglamAdet,
	isnull(DD.SehpaAdet, 0) as   DelikSehpaAdet,
    isnull(DD.HurdaCamAdet, 0) as   DelikHurdaCamAdet,
    isnull(DD.DelikDurumId,1) as DelikDurumId,
	isnull(tblDelikDurumu.DurumAdi,'Baþlamadý') as DelikDurumAdi,
	isnull(DD.IsIstasyonlariId,0) as DelikIsIstasyonlariId,
	DD.IseBaslangicSaati AS DelikIseBaslangicSaati, 
	
	--isnull(SD.SerigrafPlanlanan,0) as   SerigrafPlanlanan,
	isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0) -    isnull(DD.HurdaCamAdet,0)   as SerigrafPlanlanan,
	isnull(SD.SerigrafAdet, 0) as   SerigrafSaglamAdet,
	isnull(SD.SehpaAdet, 0) as   SerigrafSehpaAdet,
    isnull(SD.HurdaCamAdet, 0) as   SerigrafHurdaCamAdet,
    isnull(SD.SerigrafDurumId,1) as SerigrafDurumId,
	isnull(tblSerigrafDurumu.DurumAdi,'Baþlamadý') as SerigrafDurumAdi,
	isnull(SD.IsIstasyonlariId,0) as SerigrafIsIstasyonlariId,
	SD.IseBaslangicSaati AS SerigrafIseBaslangicSaati, 

	isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0) -    isnull(DD.HurdaCamAdet,0)   -    isnull(SD.HurdaCamAdet,0) as FirinPlanlanan,
	isnull(FD.FirinAdet, 0) as   FirinSaglamAdet,
	isnull(FD.SehpaAdet, 0) as   FirinSehpaAdet,
    isnull(FD.HurdaCamAdet, 0) as   FirinHurdaCamAdet,
    isnull(FD.FirinDurumId,1) as FirinDurumId,
	isnull(tblFirinDurumu.DurumAdi,'Baþlamadý') as FirinDurumAdi,
	isnull(FD.IsIstasyonlariId,0) as FirinIsIstasyonlariId,
	FD.IseBaslangicSaati AS FirinIseBaslangicSaati, 

    isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0) -    isnull(DD.HurdaCamAdet,0)  -    isnull(SD.HurdaCamAdet,0)  -  isnull(FD.HurdaCamAdet, 0)  as RezistansPlanlanan,
	isnull(RD.RezistansAdet, 0) as   RezistansSaglamAdet,
	isnull(RD.SehpaAdet, 0) as   RezistansSehpaAdet,
    isnull(RD.HurdaCamAdet, 0) as   RezistansHurdaCamAdet,
    isnull(RD.RezistansDurumId,1) as RezistansDurumId,
	isnull(tblRezistansDurumu.DurumAdi,'Baþlamadý') as RezistansDurumAdi,
	isnull(RD.IsIstasyonlariId,0) as RezistansIsIstasyonlariId ,
	RD.IseBaslangicSaati AS RezistansIseBaslangicSaati, 

    isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0) -    isnull(DD.HurdaCamAdet,0)  -    isnull(SD.HurdaCamAdet,0)  -  isnull(FD.HurdaCamAdet, 0)   -  isnull(RD.HurdaCamAdet, 0) as PaketlemePlanlanan,
	isnull(PD.PaketlemeAdet, 0) as   PaketlemeSaglamAdet,
	isnull(PD.SehpaAdet, 0) as   PaketlemeSehpaAdet,
    isnull(PD.HurdaCamAdet, 0) as   PaketlemeHurdaCamAdet,
    isnull(PD.PaketlemeDurumId,1) as PaketlemeDurumId,
	isnull(tblPaketlemeDurumu.DurumAdi,'Baþlamadý') as PaketlemeDurumAdi,
	isnull(PD.IsIstasyonlariId,0) as PaketlemeIsIstasyonlariId ,
	PD.IseBaslangicSaati AS PaketlemeIseBaslangicSaati,

	isnull(KD.SehpaAdet,0) - isnull(BD.HurdaCamAdet,0)  - isnull(CD.HurdaCamAdet,0) -    isnull(DD.HurdaCamAdet,0)  -    isnull(SD.HurdaCamAdet,0)  -  isnull(FD.HurdaCamAdet, 0)   -  isnull(RD.HurdaCamAdet, 0) -  isnull(PD.HurdaCamAdet, 0) as ShrinkPlanlanan,
	 isnull(SHRD.ShrinkAdet,0)  as   ShrinkSaglamAdet,
	isnull(SHRD.SehpaAdet, 0) as   ShrinkSehpaAdet,
    isnull(SHRD.HurdaCamAdet, 0) as   ShrinkHurdaCamAdet,
    isnull(SHRD.ShrinkDurumId,1) as ShrinkDurumId,
	isnull(tblShrinkDurumu.DurumAdi,'Baþlamadý') as ShrinkDurumAdi,
	isnull(SHRD.IsIstasyonlariId,0) as ShrinkIsIstasyonlariId ,
	SHRD.IseBaslangicSaati AS ShrinkIseBaslangicSaati




	--,ORFLINE.AMOUNT , ORFLINE.SHIPPEDAMOUNT 
    --ISNULL(SSS.CamAdet, 0) AS CamAdet

	--, PEGGING.PORDFICHEREF, ORFICHE.LOGICALREF , PEGGING.PORDLINEREF , ORFLINE.LOGICALREF 
	--, PEGGING.PEGREF ,PRODORD.LOGICALREF,ORFLINE.LOGICALREF,ORFICHE.LOGICALREF

	-- select * from TIGER..LG_025_PEGGING where PEGREF  = 4582
FROM 
 TIGER.dbo.LG_025_01_ORFLINE  AS ORFLINE  WITH(NOLOCK)
    INNER JOIN TIGER.dbo.LG_025_01_ORFICHE AS ORFICHE  WITH(NOLOCK) ON ORFLINE.ORDFICHEREF = ORFICHE.LOGICALREF 
	
    INNER JOIN TIGER.dbo.LG_025_ITEMS AS ITEMS  WITH(NOLOCK) ON ORFLINE.STOCKREF = ITEMS.LOGICALREF 
    INNER JOIN TIGER.dbo.LG_025_CLCARD AS CLCARD  WITH(NOLOCK) ON ORFLINE.CLIENTREF = CLCARD.LOGICALREF 
    INNER   JOIN (SELECT ITEMREF, CLIENTREF, ICUSTSUPCODE FROM TIGER.dbo.LG_025_SUPPASGN  WITH(NOLOCK) ) AS TEDARIKCI 
        ON CLCARD.LOGICALREF = TEDARIKCI.CLIENTREF AND ITEMS.LOGICALREF = TEDARIKCI.ITEMREF  
    LEFT JOIN TIGER..LG_025_PEGGING PEGGING  WITH(NOLOCK) ON PEGGING.PORDFICHEREF = ORFICHE.LOGICALREF AND PEGGING.PORDLINEREF = ORFLINE.LOGICALREF 
    LEFT JOIN TIGER..LG_025_PRODORD PRODORD  WITH(NOLOCK) ON PEGGING.PEGREF = PRODORD.LOGICALREF
   -- LEFT JOIN TIGER..LG_XT050_025 tblDetay ON tblDetay.PARLOGREF = ORFLINE.STOCKREF
    LEFT JOIN TIGER..LG_XT050_025 tblDetay  WITH(NOLOCK) ON tblDetay.PARLOGREF = ITEMS.LOGICALREF
	left join UretimRotaBaglanti  WITH(NOLOCK) on UretimRotaBaglanti.FercamKodu collate Turkish_CI_AS = ITEMS.CODE
    --LEFT JOIN VW_KesimIsEmriToplamlari  WITH(NOLOCK) ON VW_KesimIsEmriToplamlari.IsEmriNo  = PRODORD.FICHENO
	LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN BandoDurumu AS BD ON BD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN CncDurumu AS CD ON CD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN DelikDurumu AS DD ON DD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO 
	LEFT JOIN SerigrafDurumu AS SD ON SD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO 
	LEFT JOIN FirinDurumu AS FD ON FD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO
	LEFT JOIN RezistansDurumu AS RD ON RD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO
	LEFT JOIN PaketlemeDurumu AS PD ON PD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO
	LEFT JOIN ShrinkDurumu AS SHRD ON SHRD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO
	left join IslemDurumu tblKesimDurumu with(nolock) on tblKesimDurumu.IslemDurumuId = KD.KesimDurumId
	left join IslemDurumu tblBandoDurumu with(nolock) on tblBandoDurumu.IslemDurumuId = BD.BandoDurumId
	left join IslemDurumu tblCncDurumu with(nolock) on tblCncDurumu.IslemDurumuId = CD.CncDurumId
	left join IslemDurumu tblDelikDurumu with(nolock) on tblDelikDurumu.IslemDurumuId = DD.DelikDurumId
	left join IslemDurumu tblSerigrafDurumu with(nolock) on tblSerigrafDurumu.IslemDurumuId = SD.SerigrafDurumId
	left join IslemDurumu tblFirinDurumu with(nolock) on tblFirinDurumu.IslemDurumuId = FD.FirinDurumId
	left join IslemDurumu tblRezistansDurumu with(nolock) on tblRezistansDurumu.IslemDurumuId = RD.RezistansDurumId
	left join IslemDurumu tblPaketlemeDurumu with(nolock) on tblPaketlemeDurumu.IslemDurumuId = PD.PaketlemeDurumId
	left join IslemDurumu tblShrinkDurumu with(nolock) on tblShrinkDurumu.IslemDurumuId = SHRD.ShrinkDurumId

	--LEFT JOIN (SELECT  [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=2 GROUP BY [IsEmriNo]) AS tblKesimSehpa   ON  rtrim(tblKesimSehpa.IsEmriNo)  collate Turkish_CI_AS =  rtrim(PRODORD.FICHENO) 
	--LEFT JOIN (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as KesimAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
 --   left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet from HurdaCamHareket  group by IsEmriNo ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo



--where OperasyonHareket.OperasyonTanimiId=1 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet ) AS KesimTable on KesimTable.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
	WHERE    
   (ORFICHE.TRCODE = 1) and PRODORD.FICHENO IS NOT NULL  -- AND  KD.PlanlananAdet > 0  -- (ORFLINE.AMOUNT - ORFLINE.SHIPPEDAMOUNT > 0) and --
	--AND ORFICHE.DATE_ BETWEEN DATEADD(dd, -365, PRODORD.DATE_) AND DATEADD(dd, 365, PRODORD.DATE_)
	--  AND ITEMS.CODE  = '44 003'
	 --and PRODORD.FICHENO =   '2408.0188'
 
 --select * from UretimRotaTanim
 
 


 
GO


