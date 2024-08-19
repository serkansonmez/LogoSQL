USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_BordroZarfi]    Script Date: 26.11.2020 22:33:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from [VW_BordroZarfi]
 
ALTER view [dbo].[VW_BordroZarfi] as
 
SELECT DISTINCT  PNT.LREF,  
 PNT.PERREF,
UPPER(dbo.Ay_isl('ay',MONTH(PNT.PERDBEG))) + '/' + CAST( YEAR(PNT.PERDBEG)  AS VARCHAR(4)) + ' HESAP PUSULASI' as Baslik,
L_CAPIDIV.TAXOFFCODE as VergiDairesi,
L_CAPIDIV.TAXNR as VergiNo,
L_CAPIDIV.WEBADD as WebSitesi,
L_CAPIDIV.NAME as IsverenAdi, 
CASE WHEN LEN(L_CAPIDIV.STREET) >1 THEN L_CAPIDIV.STREET + ' ' ELSE '' END + 
CASE WHEN LEN(L_CAPIDIV.ROAD) >1 THEN L_CAPIDIV.ROAD + ' ' ELSE '' END + 
CASE WHEN LEN(L_CAPIDIV.DOORNR) >1 THEN ' No: ' + L_CAPIDIV.DOORNR + ' ' ELSE '' END + 
CASE WHEN LEN(L_CAPIDIV.DISTRICT) >1 THEN L_CAPIDIV.DISTRICT + '/' ELSE '' END + 
CASE WHEN LEN(L_CAPIDIV.CITY) >1 THEN L_CAPIDIV.CITY  ELSE '' END AS IsverenAdresi,
L_CAPIDIV.SECURNR as SgkNumarasi,
PNT.PERNAME AS AdiSoyadi,
INF.IDTCNO As TCKimlikNo,
PRS.SSKNO as SskSicilNo,
ASSG.TITLE as Gorevi,
PRS.INDATE as IseGirisTarihi,
L_CAPIUNIT.NAME AS Departman,
ASSG.WAGE_WAGE as Ucreti, --MaasListe.BordroMaasi as Ucreti_R,

Case ASSG.WAGE_CLCTYPE
     WHEN 1 THEN 'Net'
     WHEN 2 THEN 'Br�t'
     ELSE 'Tan�ms�z' 
END AS UcretTuru,
PRS.OUTDATE as IstenCikisTarihi,
PNT.PERDBEG AS DonemTarihi, 
ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 1),0) AS  NormalCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 1),0) AS  NormalCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 1),0) AS  NormalCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 1),0) AS  NormalCalismaNetTutar,

ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 2),0) AS  HaftaSonuCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 2),0) AS  HaftaSonuCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 2),0) AS  HaftaSonuCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 2),0) AS  HaftaSonuCalismaNetTutar,


ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 3),0) AS  ResmiTatilCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 3),0) AS  ResmiTatilCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 3),0) AS  ResmiTatilCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 3),0) AS  ResmiTatilCalismaNetTutar,


ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 4),0) AS  CalisilanTatilCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 4),0) AS  CalisilanTatilCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 4),0) AS  CalisilanTatilCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 4),0) AS  CalisilanTatilCalismaNetTutar,

ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 6),0) AS  UcretsizIzinCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 6),0) AS  UcretsizIzinCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 6),0) AS  UcretsizIzinCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 6),0) AS  UcretsizIzinCalismaNetTutar,

ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 7),0) AS IstirahatCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 7),0) AS  IstirahatCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 7),0) AS  IstirahatCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1 and NR = 7),0) AS  IstirahatCalismaNetTutar,


ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 1),0) AS  FazlaMesaiCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 1),0) AS  FazlaMesaiCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 1),0) AS  FazlaMesaiCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 1),0) AS  FazlaMesaiCalismaNetTutar,

ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 4),0) AS GenelTatilCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 4),0) AS  GenelTatilCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 4),0) AS  GenelTatilCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 4),0) AS  GenelTatilCalismaNetTutar,

ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 2),0) AS  ResmiTatilMesaiCalismaGun,
ISNULL((SELECT sum(HOUR_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 2),0) AS  ResmiTatilMesaiCalismaSaat,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 2),0) AS  ResmiTatilMesaiCalismaBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 2),0) AS  ResmiTatilMesaiCalismaNetTutar,

ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1  ),0)
 + ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2  ),0) AS  IstihkakToplamiBrutTutar,
ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1  ),0)
 + ISNULL((SELECT ROUND(sum(NETAM),2) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2  ),0) AS  IstihkakToplamiNetTutar,
BALN_TAXNBASE_YTD - BALN_TAXNBASE_PTD AS DevredenGelirVergisi,
BALN_TAXNBASE_YTD As GelirVergisiMatrahi,
BALN_TAXNBASE_PTD As ToplamGelirVergisiMatrahi,
BALN_TAXNBASE_YTD AS KumulatifGelirVergisiMatrahi,
BALN_SSKNBASE_PTD as SGKMatrahi,
 BALN_SECEPLR_PTD -  ROUND(BALN_SSKNBASE_PTD * 0.02,2) as SGKIsverenPayi,
ROUND(BALN_SSKNBASE_PTD * 0.02,2) AS IssizlikSigortasiIsverenPayi,
PNT.BALN_SECEPLE_PTD - ROUND(BALN_SSKNBASE_PTD * 0.01,2) as SGKIsciPayi,
ROUND(BALN_SSKNBASE_PTD * 0.01,2) AS IssizlikSigortasiIsciPayi,
PNT.BALN_TAXNORM  as GelirVergisi,
PNT.BALN_STAMP as DamgaVergisi,
BALN_MINWAGEDISC AS AsgariGecimIndirimi,
0 as SakatlikIndirimi,
PNT.BALN_SECEPLE_PTD  + PNT.BALN_TAXNORM  + PNT.BALN_STAMP  as YasalKesintilerToplami,   --���i pay� + i�sizlik sigortas� i��i pay� + Gelir vergisi + Damga vergisi
 ISNULL(
 ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 1),0) +
ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 10),0) + 
ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 11),0)
 
 ,0) 
 as EkKesintilerToplami,
--Net �cret + (SGK ���i Primi + ��sizlik Primi) + Damga Vergisi + Gelir Vergisi as IsverenMaliyetiToplam,
ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 1  ),0)    
 + ISNULL((SELECT sum(GROSSAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2  ),0)  --istihkak toplam� br�t
 --+ PNT.BALN_SECEPLE_PTD   --SGKIsciPayi
 --+  PNT.BALN_TAXNORM  -- Gelir Vergisi
 --+ PNT.BALN_STAMP  -- damga vergisi
 +  BALN_SECEPLR_PTD   -- SGK i�veren
 - ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 6 and NR = 7),0) -- hazine indirimi d��ecek
 
 as IsverenMaliyetiToplam,
ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 1),0) as Avans,
ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 10),0) as Icra,
ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 11),0) as Bes,
PNT.BALN_NETWAGE as NetEleGecenTutar ,
 UPPER(dbo.Ay_isl('ay',MONTH(PNT.PERDBEG))) + '/' + CAST( YEAR(PNT.PERDBEG)  AS VARCHAR(4)) as YilAyYaziIle

 
 /*

 PRJ.CODE AS ProjeKodu, FIN.EXPCENTER AS MasrafMerkezi, 
 PNT.WAGE_WAGE AS Maasi, PNT.BALN_TTFEXCLTOT AS OdemelerToplami, 
 
 case WHEN BALN_PAYMENTS_PTD  > SEPLIMIT then Round(SEPLIMIT / 12,2)  ELSE Round(BALN_PAYMENTS_PTD / 12,2) END AS KidemOneli, 
 
 CASE WHEN PNT.WAGE_CLCTYPE = 1 THEN 'Net' ELSE 'Br�t' END AS MaasTuru, 
 isnull((SELECT SUM(NETAM) AS Expr1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH (NOLOCK) WHERE (PREF = PNT.LREF) AND (TYP = 2)),0) AS FazlaMesai, 
 isnull((SELECT SUM(NETAM) AS Expr1 FROM BORDRODB.dbo.LH_001_PNTLINE AS LH_001_PNTLINE_3 WITH (NOLOCK) WHERE (PREF = PNT.LREF) AND (TYP = 3) AND (NR = 1)),0) AS YemekYardimi, 
 isnull((SELECT SUM(NETAM) AS Expr1 FROM BORDRODB.dbo.LH_001_PNTLINE AS LH_001_PNTLINE_2 WITH (NOLOCK) WHERE (PREF = PNT.LREF) AND (TYP = 3) AND (NR = 2)),0) AS YolYardimi, 
 isnull((SELECT SUM(NETAM) AS Expr1 FROM BORDRODB.dbo.LH_001_PNTLINE AS LH_001_PNTLINE_1 WITH (NOLOCK) WHERE (PREF = PNT.LREF) AND (TYP = 4)),0) AS EkOdemeler, 
 PNT.BALN_SECEPLR_PTD AS SGKIsveren, 
 PNT.BALN_SECEPLE_PTD AS SGKIsci, PNT.BALN_STAMP AS DamgaVergisi, PNT.BALN_TAXNORM + PNT.BALN_MINWAGEDISC_PTD AS GelirVergisi, 
 --PNT.BALN_ADDDDCTEPLE_PTD AS OzelKesintilerToplami, 
  ISNULL(OzelKesintiler.KesintiTutari,0) AS OzelKesintilerToplami,
 PNT.BALN_SSKPRIMGOV AS HazineceKarsilanacakSgk, PNT.BALN_MINWAGEDISC_PTD AS AGI, PNT.BALN_NETWAGE AS Odenen 
 ,YEAR(PNT.PERDBEG) as Yil
,MONTH(PNT.PERDBEG) as Ay
, '740.01'   as  ProjeOzelKodu
 
,ISNULL((SELECT sum(NETAM) as t2 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 2 and NR = 4 ),0) AS  ResmiTatilMesai
,ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 4 and NR = 11),0) AS  PersonelTemini
,ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 4 and NR = 6),0) AS  Tonaj
,ISNULL((SELECT sum(DAY_) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 0 and NR = 3),0) AS  CalismaGunu

,ISNULL((SELECT sum(NETAM) as t1 FROM BORDRODB.dbo.LH_001_PNTLINE WITH(NOLOCK) WHERE PREF = PNT.LREF AND TYP = 5 and NR = 10),0) AS  OtomatikKatilimBES
*/
 FROM BORDRODB.dbo.LH_001_PNTCARD AS PNT WITH (nolock) 
  LEFT OUTER JOIN BORDRODB.dbo.LH_001_PERSON AS PRS WITH (nolock) ON PRS.LREF = PNT.PERREF
  LEFT OUTER JOIN BORDRODB.dbo.LH_001_PERFIN AS FIN WITH (nolock) ON FIN.PERREF = PNT.PERREF
  LEFT OUTER JOIN BORDRODB.dbo.LH_001_FAMILY AS FML WITH (nolock) ON FML.PERREF = PNT.PERREF  AND FML.RELATION = 0
   LEFT OUTER JOIN BORDRODB.dbo.LH_001_PERIDINF AS INF WITH (nolock) ON INF.LREF = FML.IDREF 
  LEFT OUTER JOIN BORDRODB.dbo.LH_001_QUALFDEF AS PRJ ON PRJ.LREF = FIN.PRJREF 
  LEFT OUTER JOIN BORDRODB.[dbo].L_CAPIDIV L_CAPIDIV ON  L_CAPIDIV.FIRMNR = PNT.FIRMNR AND L_CAPIDIV.NR = PNT.LOCNR
  LEFT OUTER JOIN BORDRODB.[dbo].LH_001_ASSIGN ASSG WITH(NOLOCK) ON (PNT.PERREF  =  ASSG.PERREF) AND (ASSG.ENDDATE IS NULL) 
  LEFT OUTER JOIN BORDRODB.[dbo].L_CAPIUNIT (nolock) on  PRS.UNITNR = L_CAPIUNIT.NR
     left JOIN (SELECT Point_Reference,ISNULL(SUM(KesintiTutari),0) AS KesintiTutari FROM BORDRODB.dbo.VW_AylikBorcKesintiListesi 
	 
GROUP BY Point_Reference) OzelKesintiler ON OzelKesintiler.Point_Reference =   PNT.LREF
 LEFT JOIN BORDRODB.[dbo].LH_001_LAWPAR H_001_LAWPARS (nolock)  ON PNT.PERDBEG BETWEEN H_001_LAWPARS.BEGDATE  AND ISNULL(H_001_LAWPARS.ENDDATE,GETDATE())
  --AND PNT.BALN_TTFEXCLTOT = 5264.26
 
-- SELECT * FROM BORDRODB.dbo.L_CAPIUNIT 





GO


