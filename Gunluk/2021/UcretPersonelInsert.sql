 
--select * from UcretPersonel
--SELECT * FROM BORDRODB.[dbo].HE_PERSONEL_SICIL_001
 insert into UcretPersonel
SELECT  PER.KURUM [Firma]
      ,PER.BOLUM [Bolge]
      ,PER.PersonelKodu AS [SicilNo]
      ,PER.TCKIMLIKNO [TcKimlikNo]
      ,PER.ADI [Adi]
      ,PER.SOYADI [Soyadi]
      ,PER.[Gorevi]
      ,PER.IseGirisTarihi [GirisTarihi]
      ,PER.Ucreti_R [Ucreti]
      ,0 AS [RaporluGunSayisi]
      ,PER.PersonelReferans [TB_Pers_LREF]
      ,PER.Ucreti_R [AylikNetUcreti]
      ,0 [AylikAGI]
      ,0 [IzinGunu]
       ,subSTRING(PER.IBANNO,1,26) [IbanNo]
     
    ,PER.KURUM_NR 
	,0 as birimno
	,PER.PersonelReferans
	,'' Durumu
	,1 as Vekalet
  FROM    BORDROPLUS_DB.[dbo].HE_PERSONEL_SICIL_001 PER   
LEFT JOIN  .[UcretPersonel] UcretPers ON PER.[TCKIMLIKNO] COLLATE TURKISH_CI_AS  = UcretPers.TcKimlikNo
 
where UcretPers.Id is null  


--select * from BORDROPLUS_DB.[dbo].HE_PERSONEL_SICIL_001 

--select * from UcretPersonel