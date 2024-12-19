
alter VIEW VW_UretimPlanlama  AS
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
		IsIstasyonlariId 
    FROM 
        VW_KesimIsEmriToplamlari
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 1 GROUP BY IsEmriNo) AS tblKesimSehpa 
            ON tblKesimSehpa.IsEmriNo collate Turkish_CI_AS = VW_KesimIsEmriToplamlari.IsEmriNo
        LEFT JOIN (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as KesimAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,OperasyonTanimiId from HurdaCamHareket  group by IsEmriNo,OperasyonTanimiId ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=1 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet ) AS  KesimTable ON KesimTable.IsEmriNo collate Turkish_CI_AS = VW_KesimIsEmriToplamlari.IsEmriNo
),

--select* from VW_KesimIsEmriToplamlari
BandoDurumu AS (
    SELECT 
        BandoTable.IsEmriNo,
        CASE 

            WHEN ISNULL(BandoTable.BandoAdet, 0)  = ISNULL(tblBandoSehpa.SehpaAdet, 0) 
                AND ISNULL(tblBandoSehpa.SehpaAdet, 0) = 0 THEN 1
            WHEN ISNULL(BandoTable.BandoAdet, 0)  = ISNULL(tblBandoSehpa.SehpaAdet, 0) 
                AND ISNULL(tblBandoSehpa.SehpaAdet, 0) > 0 THEN 3
            WHEN ISNULL(BandoTable.BandoAdet, 0)  <> ISNULL(tblBandoSehpa.SehpaAdet, 0) THEN 2
        END AS BandoDurumId,
		BandoTable.HurdaCamAdet,
		BandoTable.BandoAdet,
		tblBandoSehpa.SehpaAdet,
		IsIstasyonlariId 
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as BandoAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,OperasyonTanimiId from HurdaCamHareket  group by IsEmriNo,OperasyonTanimiId ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=2 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet ) AS BandoTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 2 GROUP BY IsEmriNo) AS tblBandoSehpa 
            ON tblBandoSehpa.IsEmriNo = BandoTable.IsEmriNo
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
		IsIstasyonlariId 
    FROM 
         (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as CncAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,OperasyonTanimiId from HurdaCamHareket  group by IsEmriNo,OperasyonTanimiId ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=4 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet) AS CncTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 3 GROUP BY IsEmriNo) AS tblCncSehpa 
            ON tblCncSehpa.IsEmriNo = CncTable.IsEmriNo
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
		IsIstasyonlariId 
    FROM 
        (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as DelikAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,OperasyonTanimiId from HurdaCamHareket  group by IsEmriNo,OperasyonTanimiId ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo
where OperasyonHareket.OperasyonTanimiId=5 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet ) AS  DelikTable
        LEFT JOIN (SELECT IsEmriNo, ISNULL(SUM(SehpaAdet), 0) AS SehpaAdet FROM dbo.SehpaHareket WHERE OperasyonTanimiId = 4 GROUP BY IsEmriNo) AS tblDelikSehpa 
            ON tblDelikSehpa.IsEmriNo = DelikTable.IsEmriNo
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

	isnull(BD.BandoAdet, 0) as   BandoSaglamAdet,
	isnull(BD.SehpaAdet, 0) as   BandoSehpaAdet,
    isnull(BD.HurdaCamAdet, 0) as   BandoHurdaCamAdet,
    isnull(BD.BandoDurumId,1) AS BandoDurumId,
	isnull(tblBandoDurumu.DurumAdi,'Baþlamadý') as BandoDurumAdi,
	isnull(BD.IsIstasyonlariId,0) as BandoIsIstasyonlariId,

    isnull(CD.CncAdet, 0) as   CncSaglamAdet,
	isnull(CD.SehpaAdet, 0) as   CncSehpaAdet,
    isnull(CD.HurdaCamAdet, 0) as   CncHurdaCamAdet,
    isnull(CD.CncDurumId,1) as CncDurumId,
	isnull(tblCncDurumu.DurumAdi,'Baþlamadý') as CncDurumAdi,
	isnull(CD.IsIstasyonlariId,0) as CncIsIstasyonlariId,

	isnull(DD.DelikAdet, 0) as   DelikSaglamAdet,
	isnull(DD.SehpaAdet, 0) as   DelikSehpaAdet,
    isnull(DD.HurdaCamAdet, 0) as   DelikHurdaCamAdet,
    isnull(DD.DelikDurumId,1) as DelikDurumId,
	isnull(tblDelikDurumu.DurumAdi,'Baþlamadý') as DelikDurumAdi,
	isnull(DD.IsIstasyonlariId,0) as DelikIsIstasyonlariId
    --ISNULL(SSS.CamAdet, 0) AS CamAdet

	--, PEGGING.PORDFICHEREF, ORFICHE.LOGICALREF , PEGGING.PORDLINEREF , ORFLINE.LOGICALREF 
	--, PEGGING.PEGREF ,PRODORD.LOGICALREF,ORFLINE.LOGICALREF,ORFICHE.LOGICALREF

	-- select * from TIGER..LG_024_PEGGING where PEGREF  = 4582
FROM 
 TIGER.dbo.LG_024_01_ORFLINE  AS ORFLINE  WITH(NOLOCK)
    INNER JOIN TIGER.dbo.LG_024_01_ORFICHE AS ORFICHE  WITH(NOLOCK) ON ORFLINE.ORDFICHEREF = ORFICHE.LOGICALREF 
	
    INNER JOIN TIGER.dbo.LG_024_ITEMS AS ITEMS  WITH(NOLOCK) ON ORFLINE.STOCKREF = ITEMS.LOGICALREF 
    INNER JOIN TIGER.dbo.LG_024_CLCARD AS CLCARD  WITH(NOLOCK) ON ORFLINE.CLIENTREF = CLCARD.LOGICALREF 
    LEFT OUTER JOIN (SELECT ITEMREF, CLIENTREF, ICUSTSUPCODE FROM TIGER.dbo.LG_024_SUPPASGN  WITH(NOLOCK) ) AS TEDARIKCI 
        ON CLCARD.LOGICALREF = TEDARIKCI.CLIENTREF AND ITEMS.LOGICALREF = TEDARIKCI.ITEMREF  
    LEFT JOIN TIGER..LG_024_PEGGING PEGGING  WITH(NOLOCK) ON PEGGING.PORDFICHEREF = ORFICHE.LOGICALREF AND PEGGING.PORDLINEREF = ORFLINE.LOGICALREF 
    LEFT JOIN TIGER..LG_024_PRODORD PRODORD  WITH(NOLOCK) ON PEGGING.PEGREF = PRODORD.LOGICALREF
   -- LEFT JOIN TIGER..LG_XT050_024 tblDetay ON tblDetay.PARLOGREF = ORFLINE.STOCKREF
    LEFT JOIN TIGER..LG_XT050_024 tblDetay  WITH(NOLOCK) ON tblDetay.PARLOGREF = ITEMS.LOGICALREF
	left join UretimRotaBaglanti  WITH(NOLOCK) on UretimRotaBaglanti.FercamKodu collate Turkish_CI_AS = ITEMS.CODE
    --LEFT JOIN VW_KesimIsEmriToplamlari  WITH(NOLOCK) ON VW_KesimIsEmriToplamlari.IsEmriNo  = PRODORD.FICHENO
	  LEFT JOIN KesimDurumu AS KD ON KD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN BandoDurumu AS BD ON BD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN CncDurumu AS CD ON CD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO   -- Adjust join condition
    LEFT JOIN DelikDurumu AS DD ON DD.IsEmriNo collate Turkish_CI_AS = PRODORD.FICHENO 
	left join IslemDurumu tblKesimDurumu with(nolock) on tblKesimDurumu.IslemDurumuId = KD.KesimDurumId
	left join IslemDurumu tblBandoDurumu with(nolock) on tblBandoDurumu.IslemDurumuId = BD.BandoDurumId
	left join IslemDurumu tblCncDurumu with(nolock) on tblCncDurumu.IslemDurumuId = CD.CncDurumId
	left join IslemDurumu tblDelikDurumu with(nolock) on tblDelikDurumu.IslemDurumuId = DD.DelikDurumId

	--LEFT JOIN (SELECT  [IsEmriNo], SUM([SehpaAdet]) as [SehpaAdet] FROM [dbo].[SehpaHareket] where OperasyonTanimiId=2 GROUP BY [IsEmriNo]) AS tblKesimSehpa   ON  rtrim(tblKesimSehpa.IsEmriNo)  collate Turkish_CI_AS =  rtrim(PRODORD.FICHENO) 
	--LEFT JOIN (select  OperasyonHareket.IsEmriNo, isnull(sum(SaglamCamAdet),0) as KesimAdet,IsIstasyonlariId,isnull(HurdaCamAdet,0) as HurdaCamAdet from OperasyonHareket 
 --   left join (select IsEmriNo, isnull(sum(HurdaCamAdet),0) as HurdaCamAdet,OperasyonTanimiId from HurdaCamHareket  group by IsEmriNo,OperasyonTanimiId ) as tblHurda on tblHurda.IsEmriNo = OperasyonHareket.IsEmriNo



--where OperasyonHareket.OperasyonTanimiId=1 group by OperasyonHareket.IsEmriNo,IsIstasyonlariId ,HurdaCamAdet ) AS KesimTable on KesimTable.IsEmriNo = PRODORD.FICHENO collate Turkish_CI_AS
	WHERE    
    (ORFICHE.TRCODE = 1) AND (ORFLINE.AMOUNT - ORFLINE.SHIPPEDAMOUNT > 0) and  KD.PlanlananAdet > 0
	AND ORFICHE.DATE_ BETWEEN DATEADD(dd, -90, PRODORD.DATE_) AND DATEADD(dd, 90, PRODORD.DATE_)
	--AND PRODORD.FICHENO = '2407.0428'     
 -- select * from VW_UretimPlanlama where MevcutOperasyonDurumu = 'bando'

 