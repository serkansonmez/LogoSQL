USE [AlvinB2B_Default_v1]
GO

/****** Object:  StoredProcedure [dbo].[SP_ZirveFireFisiAktar]    Script Date: 25.03.2024 18:44:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 
--  exec [SP_ZirveFireFisiAktar] '1400082|ÝSMAÝL BURAN-WC|1400082|20240315|Aktarýlmadý'
CREATE PROCEDURE [dbo].[SP_ZirveFireFisiAktar]
    @SecilenKayitlar varchar(MAX)
AS
BEGIN
   -- declare @SecilenKayitlar varchar(1024) = 'S301312|Poz 1|20241004,S301312|Poz 2|20241004'
    -- Create a temporary table to hold the values
    CREATE TABLE #TempTable (Id varchar(330))

    -- Split the input string by comma and insert values into the temporary table
    DECLARE @StartPosition INT = 1, @CommaPosition INT

    WHILE @StartPosition <= LEN(@SecilenKayitlar)
    BEGIN
        SET @CommaPosition = CHARINDEX(',', @SecilenKayitlar, @StartPosition)

        IF @CommaPosition = 0
            SET @CommaPosition = LEN(@SecilenKayitlar) + 1

        INSERT INTO #TempTable (Id)
        SELECT SUBSTRING(@SecilenKayitlar, @StartPosition, @CommaPosition - @StartPosition)

        SET @StartPosition = @CommaPosition + 1
    END

    -- Select records from VW_ZirveAktarimListesi where Id is in the temporary table
    --SELECT *     FROM VW_ZirveAktarimListesi     WHERE Id IN (SELECT Id FROM #TempTable)
	DECLARE @InputString varchar(500)
	DECLARE @siparisNo varchar(50)
	DECLARE @pozNo varchar(50)
	DECLARE @Tarih date

	DECLARE @Id int
	DECLARE @TeklifSiparisNo varchar(50)
	DECLARE @MusterilerId int 
	DECLARE @ErcomStokId int
	DECLARE @Miktar float
	DECLARE @Birim varchar(50)
	DECLARE @BirimKg  float
	DECLARE @BirimFiyat float
	DECLARE @IskontoToplamFiyat float
	DECLARE @MusteriKodu varchar(50)
	DECLARE @StokAdi varchar(250)
	DECLARE @StokKodu varchar(50)
	DECLARE @TeklifNo varchar(50)
	declare @StokP_Id varchar(100)
	DECLARE @IrsaliyeNo VARCHAR(100)
	declare @cariAdi varchar(250)
	DECLARE @P_ID VARCHAR(100)
	declare @ZirveStokRef int
	declare @ZirveIrsaliyeRef int 
	DECLARE processes CURSOR FOR

	 
	SELECT Id FROM #TempTable
	OPEN processes
 
	FETCH NEXT FROM processes
	INTO  @InputString
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--set @siparisNo = SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1)
		--set @InputString = SUBSTRING(@InputString, CHARINDEX('|', @InputString) + 1, LEN(@InputString))
		--set @pozNo = SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1)
		--set @Tarih = CAST(SUBSTRING(@InputString, CHARINDEX('|', @InputString) + 1, LEN(@InputString)) AS date)
		SET @siparisNo = SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1)
		SET @InputString = SUBSTRING(@InputString, CHARINDEX('|', @InputString) + 1, LEN(@InputString))

		SET @cariAdi  = SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1)
		SET @InputString = SUBSTRING(@InputString, CHARINDEX('|', @InputString) + 1, LEN(@InputString))
	 
		SET @pozNo = SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1)
		SET @InputString = SUBSTRING(@InputString, CHARINDEX('|', @InputString) + 1, LEN(@InputString))

		--SET @Tarih = CAST(@InputString AS DATE)
		SET @Tarih = CONVERT(date, SUBSTRING(@InputString, 1, CHARINDEX('|', @InputString) - 1), 112)
     
		DECLARE @siparisNo2 as varchar(50) = @siparisNo -- +   '|' + @pozNo
		  
	    declare @MasterIrsaliyeRef int
		declare @CARIUNVAN VARCHAR(250)
        select TOP 1 @CARIUNVAN=CARIUNVAN, @ZirveIrsaliyeRef= ZirveIrsaliyeRef from VW_ErcomMaliyetAnalizi where  teklifSiparisNo = @siparisNo
		 
		if (@ZirveIrsaliyeRef is null)
		begin
	        EXECUTE @MasterIrsaliyeRef = [dbo].SP_ZirveFireFisiMasterInsert @Tarih,@siparisNo2,'',@CARIUNVAN
		    select   @IrsaliyeNo=EVRAKNO, @P_ID= P_ID FROM  [ÝREN_PVC_2024T]..IRSALIYE WHERE  SIRANO = @MasterIrsaliyeRef 
       end
	--	select @MasterIrsaliyeRef,@P_ID,@siparisNo,@siparisNo2
		-- ikinci Bölümde Zirve Programýna Sarf Eklenecek....
		   
 
		     DECLARE detailProc CURSOR FOR
			  select VW_ErcomMaliyetAnalizi.Id,TeklifSiparisNo,MusterilerId,ErcomStokId,Miktar,Birim,BirimKg,case when Miktar>0 then round(IskontoToplamFiyat / Miktar,2) else IskontoToplamFiyat end as BirimFiyat,IskontoToplamFiyat,MusteriKodu,
			-- StokAdi,StokKodu,
			  case when VW_ErcomMaliyetAnalizi.TedarikciFirmaId=1 then TblStk.STA else TblStkAsas.STA end  AS Stokadi, 
			  case when VW_ErcomMaliyetAnalizi.TedarikciFirmaId=1 then TblStk.STK else TblStkAsas.STK end AS StokKodu,
		 	  TeklifNo,
			  case when VW_ErcomMaliyetAnalizi.TedarikciFirmaId=1 then TblStk.P_ID else TblStkAsas.P_ID end AS P_ID, --TblStk.P_ID,
			  case when VW_ErcomMaliyetAnalizi.TedarikciFirmaId=1 then TblStk.REF else TblStkAsas.REF end AS REF --TblStk.REF 
			  
			  from VW_ErcomMaliyetAnalizi 
				left join ErcomEslesmeyenKartlar with(nolock)  on VW_ErcomMaliyetAnalizi.StokKodu = ErcomEslesmeyenKartlar.ErcomKodu
				LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStk ON SUBSTRING(TblStk.stk,8,5) + SUBSTRING(TblStk.stk,14,4)  = case when ErcomEslesmeyenKartlar.ZirveKodu is not null then replace(ErcomEslesmeyenKartlar.ZirveKodu,'.','') else  StokKodu end
				LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStkAsas with(nolock)  ON  TblStkAsas.stk   = case when ErcomEslesmeyenKartlar.ZirveKodu is not null then replace(ErcomEslesmeyenKartlar.ZirveKodu,'.','') else  StokKodu end
			--  where TeklifSiparisNo = 'S301312' and PozNo= 'Poz 1' and ZirveIrsaliyeRef is null
		      where VW_ErcomMaliyetAnalizi.AktifPasif = 1 and TeklifSiparisNo = @siparisNo --and PozNo= @pozNo 
			  and ZirveIrsaliyeRef is null
			 --select @siparisNo ,   @pozNo 
			 
			OPEN detailProc
 
			FETCH NEXT FROM detailProc
			INTO  @Id,@TeklifSiparisNo,@MusterilerId,@ErcomStokId,@Miktar,@Birim,@BirimKg,@BirimFiyat,@IskontoToplamFiyat,@MusteriKodu,@StokAdi,@StokKodu,@TeklifNo,@StokP_Id,@ZirveStokRef
			WHILE @@FETCH_STATUS = 0
			BEGIN
			          declare @DetayIrsaliyeId int 
				     --detay kayýt insert ediliyor...
				--	select   @StokKodu,@StokAdi,@Birim,1,@Miktar,@BirimFiyat,@MasterIrsaliyeRef,@IrsaliyeNo,@StokP_Id,@TeklifNo,@MusteriKodu,'',@P_ID,@ZirveStokRef
					  EXECUTE @DetayIrsaliyeId = [dbo].SP_ZirveFireFisiDetayInsert @StokKodu,@StokAdi,@Birim,1,@Miktar,@BirimFiyat,@MasterIrsaliyeRef,@IrsaliyeNo,@StokP_Id,@TeklifNo,@MusteriKodu,'',@P_ID,@ZirveStokRef
		 		     -- Kayýt edildiðine dair iz maliyet
					   update ErcomMaliyetAnalizi set ZirveDonem='24',ZirveSarfFisNo=@IrsaliyeNo,ZirveIrsaliyeRef=@MasterIrsaliyeRef,ZirveIrsaliyeAltRef=@DetayIrsaliyeId  where Id = @Id
			FETCH NEXT FROM detailProc
			INTO  @Id,@TeklifSiparisNo,@MusterilerId,@ErcomStokId,@Miktar,@Birim,@BirimKg,@BirimFiyat,@IskontoToplamFiyat,@MusteriKodu,@StokAdi,@StokKodu,@TeklifNo,@StokP_Id,@ZirveStokRef
			END

			CLOSE detailProc
			DEALLOCATE detailProc
		 

	FETCH NEXT FROM processes
	INTO  @InputString
	END

	CLOSE processes
	DEALLOCATE processes
	
    UPDATE [ÝREN_PVC_2024T].[dbo].IRSALIYE set TOPLAMKDV = 0, GENELTOPLAM = ROUND( (SELECT SUM(TUTARTL) FROM  [ÝREN_PVC_2024T].[dbo].IRSALIYE_ALT WHERE IRSALIYE_ALT.P_ID = IRSALIYE.P_ID),2) , TOPLAMKDVD = 0, GENELTOPLAMD = 0 WHERE IRSALIYE.TUR = 84

    -- Clean up the temporary table
    DROP TABLE #TempTable
 END


--delete from ErcomMaliyetAnalizi where TeklifSiparisNo = 's301417'
GO


