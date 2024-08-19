
--2. Jguar personel Kartlarýnýn otomatik olarak UcretPersonel tablosunda update iþlemi
declare @Id int
declare @Firma varchar(100)
declare @Bolge varchar(100)
declare @SicilNo varchar(100)
declare @TcKimlikNo varchar(11)
declare @Adi varchar(30)
declare @Soyadi varchar(30)
declare @Gorevi varchar(50)
declare @GirisTarihi datetime
declare @Ucreti decimal
declare @AkademikUnvani varchar(50)

declare @KurumNo int
declare @BirimNo int
declare @JguarPersonRef int
declare @Durumu varchar(50)


declare @IbanNo varchar(50)
declare @IkametgahAdresi varchar(250)
declare @GsmNo varchar(250)
declare @PersonelAgiTanimlariId int


--select * from BORDRODB.[dbo].HE_PERSONEL_SICIL_001 JPER  
DECLARE processes CURSOR FOR

select  DISTINCT    UcretPers.Id,JPER.IBANNO,Adresi,TElefon,PersonelAgiTanimlari.Id    from BORDRODB.[dbo].HE_PERSONEL_SICIL_001 JPER   
LEFT JOIN [SuperIk_DB].[dbo].[UcretPersonel] UcretPers ON JPER.[TCKIMLIKNO] COLLATE TURKISH_CI_AS  = UcretPers.TcKimlikNo
left join PersonelAgiTanimlari on  LTRIM(RTRIM(PersonelAgiTanimlari.AgiTanimi)) = LTRIM(RTRIM(AgiDurumu))
 
where UcretPers.TcKimlikNo is  not null  

--SELECT * FROM PersonelAgiTanimlari

OPEN processes
FETCH NEXT FROM processes
INTO 
 @Id,
@IbanNo  ,
  @IkametgahAdresi  ,
  @GsmNo  ,
  @PersonelAgiTanimlariId
 
WHILE @@FETCH_STATUS = 0
BEGIN
 
	UPDATE UcretPersonel set  IbanNo=@IbanNo,GsmNo=@GsmNo,IkametAdresi=@IkametgahAdresi,PersonelAgiTanimlariId=@PersonelAgiTanimlariId where Id = @Id
FETCH NEXT FROM processes
INTO   @Id,
@IbanNo  ,
  @IkametgahAdresi  ,
  @GsmNo  ,
  @PersonelAgiTanimlariId
END
CLOSE processes
DEALLOCATE processes