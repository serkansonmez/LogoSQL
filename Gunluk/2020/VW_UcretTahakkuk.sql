CREATE view VW_UcretTahakkuk as
SELECT DISTINCT
CASE WHEN PER.TYP = 1 THEN 'Aktif' ELSE 'Pasif' END AS Durum,
---PNT.PERDBEG [Puantaj Tarihi],
---UNT.NAME [Birim],
---PNT.PERDBEG [D�nem ba�lang�c�],
---PNT.PERDBEG [Bordro Tarihi],
---PNT.MNR [Ayi],
---PNT.BALN_DAYGROSSWAGE [G�nl�k �cret],
---PNT.BALN_HOURGROSSWAGE [Saatlik �creti],
---BALN_PAYMENTS_PTD [SGK Matrah],
---PNT.BALN_SSKNBASEAP_PTD [Devredilebilir Ek �demelerden gelen SGK matrah�],
---PNT.BALN_SSKNONTRNSAP_PTD [Devretmeyen ek �demeler toplam�],
---PNT.BALN_TAXFIX [Sabit GV],
---PNT.BALN_ROUNDDIFF_PTD [Yuvarlama Fark�],
---PNT.BALN_MINWAGEDISC [AG�1],
---PNT.BALN_SSKPRIMGOV [5510 - Hazine �ndirimi],
---PNT.SSKMDAYREASON [Eksik �al��ma kodlar�],
---PNT.BALN_SSKAPRMDIFF [��v. y�klendi�i kaza i��i prim tutar�],
---PNT.BALN_SSKABASE_PTD [Kaza SSK matrah�],
---PNT.BALN_SSKADAY_PTD [Kaza SSK g�n say�s�],
---ISNULL((SELECT SUM(TAXEXCL) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG),0)-PNL_SSK_ISSIZLIK.TAXEXCL-ISNULL((SELECT SUM(TAXEXCL) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=5 AND NR=6),0) [��veren SGK-ESK�],
---PNT.BALN_SSKNDAY_PTD*22.22 [657 Nolu TE�V�K],
---(SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (4,7)) [���i SGK],
---ROUND(PNT.BALN_SSKPRIMUNEMP,2) [4857-Engelli],
---(SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=5 AND NR IN (1)) [Avans],
---PNT.BALN_SSKNBASE_PTD*0.05 [�ndirim %5],
---STR(FRM.NR,1,1) + ' - ' + FRM.NAME [Firma],
---PNT.ACTDATE [��ten ��k��],
---PNT.WAGE_WAGE [�cret],
---PNT.BALN_ADDDDCTEPLE_PTD [Di�er Kesintiler],
---PNT.BALN_SSKNBASEWG_PTD [�cretden Gelen Kazan�lar],
---PNT.BALN_TAXNORM [Normal GV (AG�'siz)],
---PNT.BALN_TAXNBASE_YTD [Toplam Normal GV Matrah�],
---PNT.BALN_TAXNORM_YTD [�denen Toplam GV],
---PNT.BALN_TAXNORM [�denecek GV],
---PNT.BALN_PAYMENTS_PTD [Br�t Kazan�lar Toplam�],
---PNT.BALN_STAMPBASE_PTD [DV matrah�],
---PNT.BALN_NETWAGE [Net �stihkak],
---PNT.BALN_NETDESERVE-PNT.BALN_MINWAGEDISC_PTD [Net Kazan�2],
---PNT.BALN_NETWAGE-PNT.BALN_MINWAGEDISC_PTD + ISNULL((SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=5 AND NR IN (1,5)),0) [Net Kazan�(Kesintisiz)],
---PNT.BALN_TAXDISC_PTD [���i Kesintiler Taplam],
---PNL_SSK_ISSIZLIK.TAXEXCL [��veren ��sizlik1],
---BALN_SSKNDAY_MTD [ek g�n],
---PNT.BALN_AUTOINDPEND_PTD [Zorunlu BES],
---(SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=5 AND NR IN (10)) [Bes],


FRM.NAME [Firma],
DIV.NAME [��yeri],
MIDNAME AS B�lge,
PER.CODE [Sicil No],
PER.NAME + ' ' + PER.SURNAME [Ad Soyad],
PER.TTFNO [TC NO],
FINI.IbanNo as IBAN,
CASE FINI.SSKSTATUS
WHEN 1 THEN 'Normal' WHEN 2 THEN 'Emekli'end as SSK,
CASE PER.SPECODE
WHEN 1 THEN '1.ci Tur' WHEN 2 THEN '2.ci Tur'end as �deme,
PER.SPECIALCODE [�ZEL KOD],
PER.OUTDATE [��ten ��k�� tarihi],
CONVERT(DATETIME,PER.FIRMINDATE,101) AS [��e Giri� Tarihi],
YEAR(PNT.PERDBEG) AS Y�l,
DATEPART (M, PNT.PERDBEG) AS Ay,
PNT.BALN_GROSSWAGE [Br�t �creti],
PNT.BALN_SSKNDAY_PTD [�al��ma G�n�],
PNT.BALN_WORKS_PTD [Mesai Kazan� toplam�],
PNT.BALN_ADDWORKS_PTD [Fazla Mesai toplam�],
PNT.BALN_ADDPAYMS_PTD [Ek �demeler toplam�],
CASE PNT.SSKMDAYREASON
WHEN 21 THEN '�cretsiz izin' WHEN 01 THEN '�stirahat' WHEN 12 THEN 'Birden Fazla' WHEN 13 THEN 'Di�er' end as [Eksik G�n],
ISNULL((SELECT SUM(GROSSAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=4 AND NR IN (7)),0) [�zin �creti(Br�t)],
PNT.BALN_TTFEXCLTOT [SGK Matrah�],
PNT.BALN_SSKNBASE_PTD [Normal SGK matrah�],
PNT.BALN_SECEPLE_PTD [���i Kesintileri Toplam�],
PNT.BALN_LAWDEDUCTS_PTD [Yasal kesintiler],
ISNULL((SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (41,42,43,44)),0) [Gelir Vergisi],
PNT.BALN_TAXNBASE_PTD [Normal GV matrah�],
PNT.BALN_MINWAGEDISC_PTD [AG�],
PNT.BALN_STAMP [DV],
PNT.BALN_NETDESERVE [Net �deme],
PNT.BALN_NETWAGE-PNT.BALN_MINWAGEDISC_PTD [Net Kazan�],
PNT.BALN_SECEPLR_PTD [��veren Kesintiler Toplam�],
PNT.BALN_SSKPRIMGOV [5510 �ndirim],
---PNT.BALN_GROSSWAGE*0.155 [4857-Engelli],
---CASE WHEN LAW.SSKDISCLAW=2 THEN PNT.BALN_SSKNBASE_PTD*0.155 WHEN LAW.SSKDISCLAW=8 THEN PNT.BALN_SSKNBASE_PTD*0.205 WHEN LAW.SSKDISCLAW=1 THEN PNT.BALN_SSKNBASE_PTD*0.245 END [4857],
CASE WHEN LAW.SSKDISCLAW=2 THEN PNT.BALN_SSKNBASE_PTD*0.155 END [4857],
ROUND(PNT.BALN_SSKPRIMGOVDEPLAW,2) [�z�rl� %5 �ndirimi],
PNT.BALN_ADDDDCTEPLE_PTD [Ek kesintiler i��i pay� toplam�],
ISNULL((SELECT SUM(TAXEXCL) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (6)),0) [��veren ��sizlik],
ISNULL((SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (6)),0) [���i ��sizlik],
(SELECT SUM(TAXEXCL+NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (6)) [Toplam ��sizlik],
ISNULL((SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (4,5,7)),0) [���i SGK],
ISNULL((SELECT SUM(TAXEXCL) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (0,4,5,7)),0) [��veren SGK],
(SELECT SUM(TAXEXCL+NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (0,4,5,7)) [Toplam SGK],
PNT.BALN_SECEPLR_PTD+PNT.BALN_SECEPLE_PTD [TOPLAM PR�M],
(SELECT SUM(NETAM) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=5 AND NR IN (5)) [Maa� Haczi],
---PNT.BALN_GROSSWAGE+PNT.BALN_SECEPLR_PTD [Maliyet],
---PNT.BALN_PAYMENTS_PTD+PNT.BALN_SECEPLR_PTD-PNT.BALN_SSKPRIMGOV [Maliyet (�ndirimli)],
ISNULL((SELECT SUM(TAXEXCL) FROM LH_001_PNTLINE WHERE PERREF=PNT.PERREF AND PREF=PNT.LREF AND PERDBEG=PNT.PERDBEG AND TYP=6 AND NR IN (0,4,5,7)),0)-PNT.BALN_SSKPRIMGOV [�ndirimli ��veren SGK],

PNL7.HOUR_ 'FM Saat (%150)',
PNL8.HOUR_ 'GT Saat (%100)',
PNL.DAY_ 'Normal G�n',
PNL2.DAY_ 'Hafta Tatili',
PNL3.DAY_ 'Genel Tatil',
PNL4.DAY_ '�stirahat',
PNL5.DAY_ '�cretsiz �zin',
PNL9.DAY_ 'Toplam G�n',
PNT.PERDBEG
FROM LH_001_PNTCARD PNT
LEFT JOIN LH_001_PERSON PER ON PER.LREF=PNT.PERREF
LEFT JOIN L_CAPIUNIT UNT ON UNT.NR=PER.UNITNR AND UNT.FIRMNR=PER.FIRMNR
LEFT JOIN L_CAPIFIRM FRM ON FRM.NR=PNT.FIRMNR
LEFT JOIN LH_001_PNTLINE PNL_SSK_ISSIZLIK ON PNL_SSK_ISSIZLIK.PERREF=PNT.PERREF AND PNL_SSK_ISSIZLIK.PERDBEG=PNT.PERDBEG AND PNL_SSK_ISSIZLIK.TYP=6 AND PNL_SSK_ISSIZLIK.NR=6
LEFT JOIN L_CAPIDIV DIV ON DIV.NR=PNT.LOCNR AND DIV.FIRMNR=PNT.FIRMNR
LEFT JOIN LH_001_PNTLINE PNL ON PNL.PERREF=PNT.PERREF AND PNL.PERDBEG=PNT.PERDBEG AND PNL.TYP=1 AND PNL.NR=1 -- ok
LEFT JOIN LH_001_PNTLINE PNL2 ON PNL2.PERREF=PNT.PERREF AND PNL2.PERDBEG=PNT.PERDBEG AND PNL2.TYP=1 AND PNL2.NR=2 -- ok
LEFT JOIN LH_001_PNTLINE PNL3 ON PNL3.PERREF=PNT.PERREF AND PNL3.PERDBEG=PNT.PERDBEG AND PNL3.TYP=1 AND PNL3.NR=3 -- ok
LEFT JOIN LH_001_PNTLINE PNL4 ON PNL4.PERREF=PNT.PERREF AND PNL4.PERDBEG=PNT.PERDBEG AND PNL4.TYP=1 AND PNL4.NR=7 -- ok
LEFT JOIN LH_001_PNTLINE PNL5 ON PNL5.PERREF=PNT.PERREF AND PNL5.PERDBEG=PNT.PERDBEG AND PNL5.TYP=1 AND PNL5.NR=6 -- ok
LEFT JOIN LH_001_PNTLINE PNL7 ON PNL7.PERREF=PNT.PERREF AND PNL7.PERDBEG=PNT.PERDBEG AND PNL7.TYP=2 AND PNL7.NR=2 -- ok
LEFT JOIN LH_001_PNTLINE PNL8 ON PNL8.PERREF=PNT.PERREF AND PNL8.PERDBEG=PNT.PERDBEG AND PNL8.TYP=2 AND PNL8.NR=4
LEFT JOIN LH_001_PNTLINE PNL9 ON PNL9.PERREF=PNT.PERREF AND PNL9.PERDBEG=PNT.PERDBEG AND PNL9.TYP=0 AND PNL9.NR=1
LEFT JOIN LH_001_PERFIN FINI ON (PER.LREF = FINI.PERREF)
LEFT JOIN LH_001_LAWCHG LAW ON LAW.PERREF=PER.LREF 
where PNT.PERREF = 360  