USE [BORDRODB]
GO

/****** Object:  View [dbo].[HE_PERSONEL_SICIL_001]    Script Date: 6.08.2020 12:51:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--ALTER VIEW [dbo].[HE_PERSONEL_SICIL_001] AS

SELECT
	dbo.LH_001_PERSON.NAME AS ADI, 
	dbo.LH_001_PERSON.SURNAME AS SOYADI, 
	dbo.LH_001_PERSON.NAME + ' ' + dbo.LH_001_PERSON.SURNAME AS ADISOYADI, 
	dbo.LH_001_PERSON.SPECODE AS OZELKOD, 
	CAST(dbo.L_CAPIFIRM.NR AS varchar(3)) +'  -  ' +dbo.L_CAPIFIRM.NAME AS KURUM, 
	dbo.L_CAPIDEPT.NAME AS BOLUM, 
	(CASE dbo.LH_001_PERSON.SEX WHEN 1 THEN 'Erkek' WHEN 2 THEN 'Kad�n' ELSE 'Bozuk' END) AS CINSIYET, 
	(CASE dbo.LH_001_PERSON.STATUS WHEN 1 THEN 'Bekar' WHEN 2 THEN 'Evli' WHEN 3 THEN 'Dul' ELSE 'Tan�ms�z' END)AS MEDENIHAL, 
	(CASE dbo.LH_001_PERSON.EDUCATION WHEN 1 THEN '�lkokul' WHEN 2 THEN 'Ortaokul' WHEN 3 THEN 'Lise' WHEN 4 THEN 'Y�ksek' WHEN 5 THEN 'Y�ksek Lisans' WHEN 6 THEN 'Doktora' ELSE 'Tan�ms�z' END) AS EGITIM, 
	dbo.LH_001_PERSON.SSKNO AS SSKNO, 
	dbo.LH_001_PERSON.TTFNO AS TTFNO, 
	dbo.LH_001_PERSON.TAXNO AS VERGINO, 
	
	(CASE dbo.LH_001_PERSON.TYP WHEN 1 THEN 'Aktif Personel' WHEN 2 THEN 'Eski Personel' WHEN 3 THEN 'Ba�vurusu Al�nm��'ELSE 'Tan�ms�z' END) AS TIPI, 
	dbo.LH_001_PERIDINF.DADDY AS BABAADI, 	
	dbo.LH_001_PERIDINF.MUMMY AS ANNEADI, 
	dbo.LH_001_PERIDINF.BIRTHPLACE AS DOGUMYERI, 
	dbo.LH_001_PERIDINF.BIRTHDATE AS DOGUMTARIHI, 
	(CASE dbo.LH_001_PERIDINF.BLOODGROUP 
	WHEN 1 THEN '0 RH +'
	WHEN 2 THEN '0 RH -'
	WHEN 3 THEN 'A RH +'
	WHEN 4 THEN 'A RH -'
	WHEN 5 THEN 'B RH +'
	WHEN 6 THEN 'B RH -'
	WHEN 7 THEN 'AB RH +'
	WHEN 8 THEN 'AB RH -'
	ELSE 'Tan�ms�z' END) AS KANGRUBU, 
	dbo.LH_001_PERIDINF.IDTCNO AS TCKIMLIKNO, 
	dbo.LH_001_PERIDINF.SERIALNO AS CUZDANSERINO, 
	dbo.LH_001_PERIDINF.NO_ AS CUZDANNO, 
	dbo.LH_001_PERIDINF.CITY AS IL, 
	dbo.LH_001_PERIDINF.TOWN AS ILCE, 
	dbo.LH_001_PERIDINF.VILLAGE AS KOY, 
	dbo.LH_001_PERIDINF.BOOK AS CILTNO, 
	dbo.LH_001_PERIDINF.PAGE AS SAYFANO, 
	dbo.LH_001_PERIDINF.ROW_ AS KUTUKNO, 
	dbo.LH_001_PERIDINF.GIVENPLACE AS VERILDIGIYER, 
	dbo.LH_001_PERIDINF.GIVENREASON AS VERMENEDENI, 
	dbo.LH_001_PERIDINF.GIVENDATE AS VERILDIGITARIH, 
	dbo.LH_001_PERIDINF.NATIONALITY AS UYRUK, 
	(CASE dbo.LH_001_PERIDINF.MILTSTATUS WHEN 1 THEN 'Tecilli' WHEN 2 THEN 'Terhis' WHEN 3 THEN 'Muaf' ELSE 'Tan�ms�z' END) AS ASKERLIKDURUMU, 
	dbo.LH_001_PERIDINF.MILTTERMDATE AS TERHISTARIHI, 
	(CASE dbo.LH_001_PERIDINF.DRIVINGCLASS 
	WHEN 1 THEN 'Yok'
	WHEN 2 THEN 'A1'
	WHEN 3 THEN 'A2'
	WHEN 4 THEN 'B'
	WHEN 5 THEN 'C'
	WHEN 6 THEN 'D'
	WHEN 7 THEN 'E'
	WHEN 8 THEN 'H'
	WHEN 9 THEN 'F'
	WHEN 10 THEN 'G'
	WHEN 11 THEN 'K'
	ELSE 'Tan�ms�z' END) AS EHLIYETSINIFI, 
	dbo.LH_001_PERIDINF.PROFESSION AS MESLEK
  ,dbo.LH_001_PERSON.INDATE as IseGirisTarihi
  ,dbo.LH_001_PERSON.OUTDATE as IstenCikisTarihi
  ,dbo.LH_001_PERSON.CODE AS PersonelKodu
  ,ASSG.TITLE as Gorevi
  ,LH_001_PERSON.PREFIX AS AkademikUnvani
  ,LH_001_PERSON.LREF AS PersonelReferans
  ,PRJ.CODE AS ProjeKodu
   ,PRJ.NAME AS ProjeAdi
   ,FINI.IBANNO
   ,ASSG.WAGE_WAGE as Ucreti_R
   ,LH_001_PERSON.TYP AS TYP
   ,tblAgi.EXP as AgiYuzde
   ,tblAgi.DESC_ as AgiDurumu
   ,tblAdres.EXP1 as Adresi
--   ,tblCepTel.EXP1 as CepTelefon
   ,ISNULL(tblEvTel.EXP1,tblCepTel.EXP1) as  Telefon
FROM    dbo.LH_001_PERIDINF RIGHT OUTER JOIN
        dbo.LH_001_FAMILY ON dbo.LH_001_PERIDINF.LREF = dbo.LH_001_FAMILY.IDREF RIGHT OUTER JOIN
        dbo.LH_001_PERSON ON dbo.LH_001_FAMILY.PERREF = dbo.LH_001_PERSON.LREF LEFT OUTER JOIN
        dbo.L_CAPIDEPT ON dbo.LH_001_PERSON.DEPTNR = dbo.L_CAPIDEPT.NR AND 
        dbo.LH_001_PERSON.FIRMNR = dbo.L_CAPIDEPT.FIRMNR LEFT OUTER JOIN
        dbo.L_CAPIFIRM ON dbo.LH_001_PERSON.FIRMNR = dbo.L_CAPIFIRM.NR

		LEFT OUTER JOIN LH_001_ASSIGN ASSG WITH(NOLOCK) ON (LH_001_PERSON.LREF  =  ASSG.PERREF) AND (ASSG.ENDDATE IS NULL) 
		left JOIN (SELECT top 10000
TYPD.LREF, TYPD.TYP, TYPD.NR, TYPD.STATIC, TYPD.EXP, TYPD.DESC_, TYPD.NETFLAG
 FROM 
LH_001_TYPEDEF TYPD WITH(NOLOCK) 
 WHERE 
(TYPD.TYP = -43)  ) tblAgi on tblAgi.NR = ASSG.MWDISCREF 
		LEFT OUTER JOIN LH_001_PERFIN FINI WITH(NOLOCK) ON (LH_001_PERSON.LREF  =  FINI.PERREF)
		LEFT OUTER JOIN LH_001_QUALFDEF PRJ on PRJ.LREF = FINI.PRJREF
		LEFT JOIN LH_001_CONTACT tblAdres ON tblAdres.TYP =1 AND tblAdres.CARDREF = LH_001_FAMILY.LREF
		LEFT JOIN LH_001_CONTACT tblEvTel ON tblEvTel.TYP =2 AND tblEvTel.CARDREF = LH_001_FAMILY.LREF
		LEFT JOIN LH_001_CONTACT tblCepTel ON tblCepTel.TYP =3 AND tblCepTel.CARDREF = LH_001_FAMILY.LREF
 
WHERE  LH_001_FAMILY.RELATION = 0

GO


