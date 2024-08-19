--1- sql server ayarlarý
Use master
go
   sp_configure 'show advanced options' , 1
go
   Reconfigure with Override
go
   sp_configure 'Ole Automation Procedures' , 1
go
   Reconfigure with Override
Go
-- 2.Döviz Kurlarýnýn Yazýlacaðý Tablo oluþturuluyor
   if not exists (select * from sys.tables where name = N'DOVIZKURLARI' and type = 'U')
   begin
       Create table DOVIZKURLARI (Tarih date,
                                  CrossOrder Smallint,
                                  Kod NVarchar(5),
                                  CurrencyCode NVarchar(5),
                                  UNIT  varchar(50),
                                  Isim varchar(100),
                                  CurrencyName varchar(100) ,
                                  ForexBuying float  ,
                                  ForexSelling float,
                                  BanknoteBuying float,
                                  BanknoteSelling float)
   end
   --3. Stored Procedure oluþturuluyor

   if exists (select * from sys.objects where type = 'P' AND name = 'UPR_GetDovizKurlari_MerkezBankasi')
        drop procedure UPR_GetDovizKurlari_MerkezBankasi
go
   Create proc [dbo].[UPR_GetDovizKurlari_MerkezBankasi]
            (@pYil Smallint, @pAy TinyInt, @pGun TinyInt)
   As
   begin
       Declare @url as varchar(8000)
       /*
         Set @url = 'https://www.tcmb.gov.tr/kurlar/today.xml'
         Set @url = 'https://www.tcmb.gov.tr/kurlar/201903/12032019.xml'
       */

       Declare @XmlYilAy NVarchar(6), @XmlTarih NVarchar(10)
       Set @XmlYilAy =  Right('0000' + cast(@pYil as varchar(4)) , 4) + Right('00' + cast(@pAy as varchar(2)) , 2)
       Set @XmlTarih =  Right('00' + cast(@pGun as varchar(2)) , 2) + Right('00' + cast(@pAy as varchar(2)) , 2) + Right('0000' + cast(@pYil as varchar(4)) , 4)

       If DateFromParts(@pYil, @pAy, @pGun) = DateAdd(dd,0,DateDiff(dd,0,GetDate())) --gelen parametrelergünün tarihi ise
           Set @url =  'https://www.tcmb.gov.tr/kurlar/today.xml'
       else
           Set @url =  'https://www.tcmb.gov.tr/kurlar/' + @XmlYilAy + '/' + @XmlTarih + '.xml'
       Print @url

       declare @OBJ AS INT
       declare @RESULT AS INT
       EXEC @RESULT = SP_OACREATE 'MSXML2.XMLHTTP', @OBJ OUT
       EXEC @RESULT = SP_OAMethod @OBJ , 'open' , null , 'GET', @url, false
       EXEC @RESULT = SP_OAMethod @OBJ, send, NULL,''
       
        If OBJECT_ID('tempdb..#XML') IS NOT Null DROP TABLE #XML

       Create table #XML ( STRXML varchar(max))
       Insert INTO #XML(STRXML) EXEC @RESULT = SP_OAGetProperty @OBJ, 'responseXML.xml'
       
       --Select * From #XML

       DECLARE @XML AS XML
       SELECT @XML = STRXML FROM #XML
       DROP TABLE #XML
       DECLARE @HDOC AS INT
       EXEC SP_XML_PREPAREDOCUMENT @HDOC OUTPUT , @XML
       
       Delete from DOVIZKURLARI where tarih = DateFromParts(@pYil, @pAy, @pGun)
       INSERT INTO DOVIZKURLARI ( Tarih,CrossOrder,Kod,CurrencyCode,UNIT,Isim,CurrencyName,ForexBuying,ForexSelling,BanknoteBuying,BanknoteSelling)
 
       SELECT DateFromParts(@pYil, @pAy, @pGun) As Tarih,
              * FROM OPENXML(@HDOC, 'Tarih_Date/Currency')
                       With (CrossOrder NVarchar(5), Kod Varchar(5),  CurrencyCode NVarchar(5),
                             Unit varchar(50) 'Unit',
                             Isim varchar(100)   'Isim',
                             CurrencyName varchar(100)   'CurrencyName',
                             ForexBuying float   'ForexBuying',
                             ForexSelling float 'ForexSelling',
                             BanknoteBuying float 'BanknoteBuying',
                             BanknoteSelling float 'BanknoteSelling'
                           )
   End
Go
 ---2020,12,15 test amaçlý bir günlük YIL,AY,GÜN
exec UPR_GetDovizKurlari_MerkezBankasi 2020,12,15 --test amaçlý bir günlük

--4. iki tarih arasý indir: Geçmiþ döneme ait kurlarý indirebilmek için iki tarih arasý sorguyu kullanabilirsiniz.
declare @IlkTarih datetime = '20200911'
declare @SonTarih datetime = '20201221'
declare @Yil int   
declare @Ay int  
declare @Gun int  

WHILE (@IlkTarih<@SonTarih)
BEGIN
    set @Yil =  year(@IlkTarih)
	set @Ay =  month(@IlkTarih)
	set @Gun =  day(@IlkTarih)
	exec UPR_GetDovizKurlari_MerkezBankasi @Yil,@Ay,@Gun
	SET @IlkTarih = DATEADD(dd,1,@IlkTarih)
	--SELECT @IlkTarih
END

SELECT * FROM DOVIZKURLARI