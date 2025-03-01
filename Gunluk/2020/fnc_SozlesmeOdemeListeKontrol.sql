USE [WorkInZone_Default_v1]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_SozlesmeOdemeListeKontrol]    Script Date: 14.12.2020 21:49:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
ALTER function [dbo].[fnc_SozlesmeOdemeListeKontrol]()

RETURNS @TABLE
TABLE (
	ContractId int,
	Vade datetime ,
	TaksitSayisi int ,
	SozlemeBaslangicTarihi datetime,
	KiralamaTutari decimal (15,2),
	KdvTutari decimal (15,2),
	KdvDahilTutar decimal (15,2)) 

--AS
BEGIN
 /*
 declare @Table table(
	ContractId int,
	Vade datetime ,
	TaksitSayisi int ,
	SozlemeBaslangicTarihi datetime,
	KiralamaTutari decimal (15,2))   
	*/
DECLARE @TaksitSayisi int
DECLARE @DetayId int
DECLARE @AracModeli varchar(128)
DECLARE @SeriNo varchar(128)
DECLARE @FaturalamaGunu int
DECLARE @IlkTarih datetime
DECLARE @SonTarih datetime
DECLARE @KiralamaBaslangicTarihi datetime
DECLARE @EskiTarih datetime
DECLARE @YeniTarih datetime
DECLARE @Sayac int
DECLARE @AY int
DECLARE @YIL int
DECLARE @ESKIAY int
DECLARE @ESKIYIL int
DECLARE @EUROSATIS decimal(15,4)
DECLARE @EUROSAYI INT
DECLARE @KiralamaTutari decimal(15,4)
DECLARE @kdvTutari decimal(15,4)
DECLARE @kdvliTutar decimal(15,4)
DECLARE @AYICI_FATURA int = 0
DECLARE @KiralamaValeoFirmalarId int = 0
DECLARE @GUN int
 
 
 

DECLARE MainProc CURSOR FOR
SELECT  Contract.ContractId,   ContractDetails.Quantity,DAY(StartDate) as FaturalamaGunu,StartDate, isnull(ContractDetails.Tutar/Quantity,0) ,
isnull(ContractDetails.KdvliTutar/Quantity,0) - isnull(ContractDetails.Tutar/Quantity,0),
isnull(ContractDetails.KdvliTutar/Quantity,0)
FROM Contract

LEFT JOIN ContractDetails on  ContractDetails.ContractId =  Contract.ContractId
 
OPEN MainProc
FETCH NEXT FROM MainProc
INTO @DetayId,@TaksitSayisi,@FaturalamaGunu,@KiralamaBaslangicTarihi,@KiralamaTutari,@kdvTutari,@kdvliTutar
WHILE @@FETCH_STATUS = 0
BEGIN
   SET @Sayac = 1
    SET @GUN = DAY(@KiralamaBaslangicTarihi)
   SET @AY = MONTH(@KiralamaBaslangicTarihi)
   SET @YIL = YEAR(@KiralamaBaslangicTarihi)
    
    IF (@GUN = 1 AND  @FaturalamaGunu=30)
   begin
      set @AYICI_FATURA = 1
   end
   else 
   begin
      set @AYICI_FATURA = 0
   end
     
   while (@Sayac<=@TaksitSayisi)
   begin	
      
       SET @AY = @AY + 1
       
      IF (@AY>12)
      BEGIN
         SET @AY = 1
         SET @YIL = @YIL + 1
      END   
      --select @DetayId,@AracModeli,@SeriNo,@TaksitSayisi,@FaturalamaGunu,@Sayac
      -- onceki ayı bul
      if (@AY =1 )
      begin
          set @ESKIAY = 12
          set @ESKIYIL = @YIL - 1
      end
      ELSE 
      begin
   
             set @ESKIAY = @AY - 1
		   
          set @ESKIYIL = @YIL
      end
     if (@ESKIAY=2 and @FaturalamaGunu>28 and @ESKIYIL % 4 = 0)
         set @EskiTarih = Convert(datetime,cast(@ESKIYIL as char(4)) + '-' + cast(@ESKIAY as char(2)) + '-' + cast('29'  as char(2)),120) 
	  else if (@ESKIAY=2 and @FaturalamaGunu>28 and @ESKIYIL % 4 <> 0)
         set @EskiTarih = Convert(datetime,cast(@ESKIYIL as char(4)) + '-' + cast(@ESKIAY as char(2)) + '-' + cast('28'  as char(2)),120) 
	  else 
	     set @EskiTarih = Convert(datetime,cast(@ESKIYIL as char(4)) + '-' + cast(@ESKIAY as char(2)) + '-' + cast(@FaturalamaGunu  as char(2)),120)
		 
	  if (@AY=2 and @FaturalamaGunu>28 and @YIL % 4 = 0) 
         set @YeniTarih = Convert(datetime,cast(@YIL as char(4)) + '-' + cast(@AY as char(2)) + '-' + cast('29' as char(2)),120)
      else if (@AY=2 and @FaturalamaGunu>28 and @YIL % 4 <> 0) 
         set @YeniTarih = Convert(datetime,cast(@YIL as char(4)) + '-' + cast(@AY as char(2)) + '-' + cast('28' as char(2)),120)
	  else 
	     set @YeniTarih = Convert(datetime,cast(@YIL as char(4)) + '-' + cast(@AY as char(2)) + '-' + cast(@FaturalamaGunu as char(2)),120)
      
      
      insert @Table
      SELECT @DetayId,@YeniTarih,@TaksitSayisi, @KiralamaBaslangicTarihi,@KiralamaTutari,@kdvTutari,@kdvliTutar
       
      
       
      SET @Sayac  = @Sayac + 1
      
   end  

FETCH NEXT FROM MainProc
INTO @DetayId,@TaksitSayisi,@FaturalamaGunu,@KiralamaBaslangicTarihi,@KiralamaTutari,@kdvTutari,@kdvliTutar
END
CLOSE MainProc
DEALLOCATE MainProc
-- select * from @Table
 
RETURN
END   