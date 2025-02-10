select DISTINCT
 ITM.LOGICALREF as Referans,
 ITM.CYPHCODE,
 CASE  WHEN ITM.CYPHCODE = '1' then 'Stella'
       WHEN ITM.CYPHCODE = '01' then '1-Toz Ýçecek' 
      WHEN ITM.CYPHCODE = '02' then '2-Kahve'
	  WHEN ITM.CYPHCODE = '03' then '3-Çay' end AS Departman,
ITM.CODE as StokKodu,
ITM.NAME AS StokAdi,
TblStok.EldekiMiktar as  EldekiMiktar,
TblStok.BekleyenMiktar as  BekleyenMiktar,
TblStok.[KalanMiktar] as  DepoKalan,
tblTumAylar.AyAdi ,
  

tblEskiYilSatis.SatisAdet  OncekiSatis,
tblMevcutYilSatis.SatisAdet  MevcutSatis,
tblMevcutYilSatis.SatisAdet  - tblEskiYilSatis.SatisAdet   AS FarkAdet,
CASE 
    WHEN tblEskiYilSatis.SatisAdet > 0 THEN 
      round( ( (tblMevcutYilSatis.SatisAdet * 100.0) / tblEskiYilSatis.SatisAdet) - 100,2)
    ELSE NULL 
END AS ArtisYuzde 
 

FROM  
 CEZVE..LG_325_ITEMS AS ITM WITH(NOLOCK)  
leFT JOIN (SELECT   IT.LOGICALREF as LogicalRef,  IT.CODE AS [StokKodu], 
 IT.NAME AS [StokAciklamasi],
 IT.CYPHCODE AS [YetkiKodu],  
(SELECT SUM(ST1.ONHAND) FROM CEZVE..LG_325_01_STINVTOT AS 
ST1 WITH(NOLOCK) WHERE ST1.STOCKREF=IT.LOGICALREF AND ST1.INVENNO='0') AS [EldekiMiktar], 
 (SUM(OL.AMOUNT)-SUM(OL.SHIPPEDAMOUNT)) AS [BekleyenMiktar]  ,
((SELECT SUM(ST1.ONHAND) FROM CEZVE..LG_325_01_STINVTOT AS 
ST1 WHERE ST1.STOCKREF=IT.LOGICALREF AND ST1.INVENNO='0')  
- (SUM(OL.AMOUNT)-SUM(OL.SHIPPEDAMOUNT) ))  AS [KalanMiktar]


FROM CEZVE..LG_325_01_ORFLINE OL 
 INNER JOIN CEZVE..LG_325_ITEMS IT  ON IT.LOGICALREF=OL.STOCKREF  INNER JOIN CEZVE..LG_325_CLCARD CH  
ON CH.LOGICALREF=OL.CLIENTREF  INNER JOIN CEZVE..LG_325_01_ORFICHE OFC 
ON OL.ORDFICHEREF=OFC.LOGICALREF
  WHERE OL.TRCODE='1' 
  --and IT.NAME LIKE '%DEM%'  --stok adýna göre filtreleme
AND OL.AMOUNT>=OL.SHIPPEDAMOUNT
 GROUP BY  IT.CODE,IT.NAME,IT.CYPHCODE,IT.LOGICALREF   ) TblStok on TblStok.LogicalRef = ITM.LOGICALREF
 left join AltinCezveB2B_Default_v1..MalzemeYeniKodlar on MalzemeYeniKodlar.[Yeni Kod] = ITM.CODE
  left join CEZVE..LG_324_ITEMS ITMESKI on ITMESKI.CODE = MalzemeYeniKodlar.Kodu
  cross apply (SELECT 1 AS Ay, 'OCAK' AS AyAdi UNION ALL
    SELECT 2, 'ÞUBAT' UNION ALL
    SELECT 3, 'MART' UNION ALL
    SELECT 4, 'NÝSAN' UNION ALL
    SELECT 5, 'MAYIS' UNION ALL
    SELECT 6, 'HAZÝRAN' UNION ALL
    SELECT 7, 'TEMMUZ' UNION ALL
    SELECT 8, 'AÐUSTOS' UNION ALL
    SELECT 9, 'EYLÜL' UNION ALL
    SELECT 10, 'EKÝM' UNION ALL
    SELECT 11, 'KASIM' UNION ALL
    SELECT 12, 'ARALIK') tblTumAylar 
left join  AltinCezveB2B_Default_v1..VW_StokYillikSatislarAylik_324   tblEskiYilSatis on tblEskiYilSatis.STOCKREF =  ITMESKI.LOGICALREF and tblTumAylar.Ay = tblEskiYilSatis.MONTH_
left join  AltinCezveB2B_Default_v1..VW_StokYillikSatislarAylik_325   tblMevcutYilSatis on tblMevcutYilSatis.STOCKREF =  ITM.LOGICALREF	 and tblTumAylar.Ay = tblMevcutYilSatis.MONTH_

 where TblStok.EldekiMiktar  is not null


 --select * from AltinCezveB2B_Default_v1..VW_StokYillikSatislarAylik_325  where stockref = 44