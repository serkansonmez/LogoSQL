DECLARE 
    @Bolum NVARCHAR(255), 
    @Tarih DATE, 
    @VardiyaMakineNo NVARCHAR(255), 
    @OperatorSicilNo NVARCHAR(255), 
    @OperatorSicilNo1 float, 
    @OperatorSicilNo2 float, 
    @OperatorSicilNo3 NVARCHAR(255), 
    @OperatorSicilNo4 NVARCHAR(255), 
    @OperatorSicilNo5 NVARCHAR(255), 
    @ToplamOperatorSayisi float, 
    @BaslamaSaati TIME, 
    @BitisSaati TIME,
    @GerceklesenIsSuresiSaat datetime,
    @GerceklesenIsSuresiDK INT,
    @PlanlananSureDK INT,
    @M1 NVARCHAR(255), @M2 NVARCHAR(255), @M3 NVARCHAR(255), @M4 NVARCHAR(255),
    @M5 NVARCHAR(255), @M6 NVARCHAR(255), @M7 NVARCHAR(255), @M8 NVARCHAR(255),
    @M9 NVARCHAR(255), @M10 NVARCHAR(255), @M11 NVARCHAR(255), @M12 NVARCHAR(255),
    @M13 NVARCHAR(255), @M14 NVARCHAR(255), @M15 NVARCHAR(255), @M16 NVARCHAR(255),
    @M17 NVARCHAR(255), @M15Aciklama NVARCHAR(255),
    @ToplamDurus INT,
    @MakineCalismaSuresiDK INT,
    @IsEmriNo fLOAT,
    @SiparisNo NVARCHAR(255),
    @OptimizasyonNo FLOAT,
    @UrunAdi NVARCHAR(255),
    @FercamUrunKodu NVARCHAR(255),
    @MusteriUrunKodu NVARCHAR(255),
    @FirmaAdi NVARCHAR(255),
    @KesilecekMakine NVARCHAR(255),
    @DelikliCam NVARCHAR(255),
    @SiparisAdeti INT,
    @PlanlananAdet INT,
    @UretimAdeti INT,
    @SerigraftaSilinenCamAdeti INT,
    @H7 NVARCHAR(255), @H8 NVARCHAR(255), @H9 NVARCHAR(255), @H10 NVARCHAR(255),
    @H5 NVARCHAR(255), @H17 NVARCHAR(255), @H44 NVARCHAR(255), @H46 NVARCHAR(255),
    @H20 NVARCHAR(255), @H21 NVARCHAR(255), @H22 NVARCHAR(255), @H23 NVARCHAR(255),
    @H24 NVARCHAR(255), @H25 NVARCHAR(255), @H26 NVARCHAR(255), @H27 NVARCHAR(255),
    @H28 NVARCHAR(255), @H1 NVARCHAR(255), @H2 NVARCHAR(255), @H3 NVARCHAR(255),
    @H4 NVARCHAR(255), @H6 NVARCHAR(255), @H11 NVARCHAR(255), @H12 NVARCHAR(255),
    @H13 NVARCHAR(255), @H14 NVARCHAR(255), @H15 NVARCHAR(255), @H16 NVARCHAR(255),
    @H18 NVARCHAR(255), @H19 NVARCHAR(255), @H29 NVARCHAR(255), @H30 NVARCHAR(255),
    @H31 NVARCHAR(255), @H32 NVARCHAR(255), @H33 NVARCHAR(255), @H34 NVARCHAR(255),
    @H35 NVARCHAR(255), @H36 NVARCHAR(255), @H37 NVARCHAR(255), @H38 NVARCHAR(255),
    @H39 NVARCHAR(255), @H40 NVARCHAR(255), @H41 NVARCHAR(255), @H42 NVARCHAR(255),
    @H43 NVARCHAR(255), @H45 NVARCHAR(255), @H47 NVARCHAR(255), @H50 NVARCHAR(255),
    @H51 NVARCHAR(255), @H56 NVARCHAR(255),
    @ToplamHataMiktari INT,
    @KaliteOnaySicilNo NVARCHAR(255),
    @PlakaAdeti INT,
    @ToplamPlakaAdeti INT,
    @OtoklavHataAyrimi NVARCHAR(255),
    @KaliteBitisMiktari INT,
    @En FLOAT,
    @Boy FLOAT,
    @Kalýnlýk FLOAT,
    @Renk NVARCHAR(255),
    @UretimAlanM2 FLOAT,
    @HatalýAlanM2 FLOAT,
    @HatalýUretimYuzdesiM2 FLOAT,
    @HatalýUretimYuzdesiAdet FLOAT,
	@OptimizasyonNoStr varchar(20),
	@IsEmriNoStr varchar(20),

	@OperasyonHareketId int,
	@HurdaCamHareketId int,
	@KesimHareketId int,
	-- OperasyonHareket eksik
	@PersonelId1 int,
	@PersonelId2 int,
	@PersonelId3 int,
	@IsIstasyonlariId int,
	@LotNo varchar(20),
	@OperasyonTanimiId int;


	--select * from Personel where SicilNo = 1

-- Cursor tanýmý
DECLARE UretimCursor CURSOR FOR
SELECT   *
FROM [dbo].[UretimTumAylarExcel]  -- WHERE [ÝÞ EMRÝ NO] =  '24070243'

-- Cursor'ý aç
OPEN UretimCursor;

-- Cursor'dan veri oku
FETCH NEXT FROM UretimCursor INTO 
    @Bolum, @Tarih, @VardiyaMakineNo, @OperatorSicilNo, @OperatorSicilNo1, 
    @OperatorSicilNo2, @OperatorSicilNo3, @OperatorSicilNo4, @OperatorSicilNo5,
    @ToplamOperatorSayisi, @BaslamaSaati, @BitisSaati, @GerceklesenIsSuresiSaat,
    @GerceklesenIsSuresiDK, @PlanlananSureDK, @M1, @M2, @M3, @M4, @M5, @M6, @M7, 
    @M8, @M9, @M10, @M11, @M12, @M13, @M14, @M15, @M16, @M17, @M15Aciklama, 
    @ToplamDurus, @MakineCalismaSuresiDK, @IsEmriNo, @SiparisNo, @OptimizasyonNo,
    @UrunAdi, @FercamUrunKodu, @MusteriUrunKodu, @FirmaAdi, @KesilecekMakine,
    @DelikliCam, @SiparisAdeti, @PlanlananAdet, @UretimAdeti, @SerigraftaSilinenCamAdeti,
    @H7, @H8, @H9, @H10, @H5, @H17, @H44, @H46, @H20, @H21, @H22, @H23, @H24, @H25,
    @H26, @H27, @H28, @H1, @H2, @H3, @H4, @H6, @H11, @H12, @H13, @H14, @H15, @H16,
    @H18, @H19, @H29, @H30, @H31, @H32, @H33, @H34, @H35, @H36, @H37, @H38, @H39,
    @H40, @H41, @H42, @H43, @H45, @H47, @H50, @H51, @H56, @ToplamHataMiktari,
    @KaliteOnaySicilNo, @PlakaAdeti, @ToplamPlakaAdeti, @OtoklavHataAyrimi, 
    @KaliteBitisMiktari, @En, @Boy, @Kalýnlýk, @Renk, @UretimAlanM2, @HatalýAlanM2, 
    @HatalýUretimYuzdesiM2, @HatalýUretimYuzdesiAdet;

-- Döngüyle tüm kayýtlarý iþle
WHILE @@FETCH_STATUS = 0
BEGIN
     set @OperasyonTanimiId = 0
  SET @OperasyonTanimiId = CASE 
    WHEN  rtrim(@Bolum) LIKE 'K_S_M' THEN 1
    WHEN rtrim(@Bolum) LIKE 'BANDO' THEN 2
	 
    WHEN  rtrim(@Bolum) LIKE 'SU JET_' THEN 3
    WHEN  rtrim(@Bolum) LIKE 'CNC RODAJ' THEN 4
    WHEN  rtrim(@Bolum) LIKE 'DEL_K' THEN 5
    WHEN  rtrim(@Bolum) LIKE 'SER_GRAF' THEN 6
    WHEN  rtrim(@Bolum) LIKE 'Y.__FIRIN' THEN 7
 
    WHEN  rtrim(@Bolum) LIKE 'LAM_NE FIRIN' THEN 7
    WHEN  rtrim(@Bolum) LIKE 'D_Z FIRIN' THEN 7
 
    WHEN  rtrim(@Bolum) LIKE 'OTOKLAV' THEN 8
    WHEN  rtrim(@Bolum) LIKE 'PAKETLEME' THEN 9
    WHEN  rtrim(@Bolum) LIKE 'SHRINK' THEN 11
	WHEN  rtrim(@Bolum) LIKE 'SHRINK ' THEN 11
 
    WHEN  rtrim(@Bolum) LIKE 'VAKUMALMA' THEN 10
	 WHEN  rtrim(@Bolum) LIKE 'VAKUMLAMA' THEN 10
	
    WHEN  rtrim(@Bolum) LIKE 'BANT TRA_I' THEN 13
    WHEN  rtrim(@Bolum) LIKE 'BANT TIRA_I' THEN 14
 
    ELSE NULL
	
END;
 --select @Bolum,@OperasyonTanimiId
			SET @OptimizasyonNoStr =	CAST(CAST(@OptimizasyonNo AS DECIMAL(20,0)) AS VARCHAR(20))		
			SET @IsEmriNoStr = STUFF(CAST(CAST(@IsEmriNo AS DECIMAL(20,0)) AS VARCHAR(20)), 5, 0, '.')
    --  select * from IsIstasyonlari where IstasyonKodu like '%59%'
	  set @PersonelId1=0
	  set @PersonelId2=0
	  set @PersonelId3=0
	  set @PersonelId1 = (select top 1 Id from Personel where cast(SicilNo as int) = cast( @OperatorSicilNo as int))
	  set @PersonelId2 = (select top 1 Id from Personel where cast(SicilNo as int)= cast(@OperatorSicilNo1 as int))
	  set @PersonelId3 = (select top 1 Id from Personel where cast(SicilNo as int) = cast(@OperatorSicilNo2 as int))
	  set @IsIstasyonlariId = (select top 1 IsIstasyonlariId from IsIstasyonlari where IstasyonKodu like '%' + SUBSTRING( REPLACE(replace(@VardiyaMakineNo,'16','79'),'23','14'),6,2) + '%' )
	-- SELECT @PersonelId1, @OperatorSicilNo, @PersonelId2,@OperatorSicilNo1,@PersonelId3,@OperatorSicilNo2
	--select   DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) as IseBaslangicSaati,
			--				   1 as KullaniciId,
			--				   @OptimizasyonNoStr,
			--				   @PlakaAdeti,
			--				   @ToplamDurus,
			--				   @PersonelId1,
			--				   @PersonelId2,
			--				   @IsIstasyonlariId,
			--				   'Excel'  as Aciklama,
			--				   '' as Lot1,
			--				   '' as Lot2,
			--				   '' as Lot3 , @Bolum,
			--				   @OperatorSicilNo2,
			--				   @VardiyaMakineNo,
			--				   REPLACE( SUBSTRING( @VardiyaMakineNo,1,7),'-','')
		 --			            ,@OperasyonTanimiId
			--					,@Bolum
	  --1.1 Kesim bölümü için KesimHareket kontrol edilecek
	  if (@OperasyonTanimiId=1)
	  begin
	   
	     set @KesimHareketId = 0
	     select top 1 @KesimHareketId= KesimHareketId from KesimHareket where 
		      OptimizasyonKodu =  @OptimizasyonNoStr and 
			  KullaniciId>= 2
			  print 'yeni sistemde yoksa Kesim devam'
          if (@KesimHareketId =0)  -- sistem devreye girdikten sonraki optimizasyon varsa yoksa devam et
		  begin
		      select top 1 @KesimHareketId= KesimHareketId from KesimHareket where 
		      OptimizasyonKodu =  @OptimizasyonNoStr and 
			  IseBaslangicSaati = DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) and 
			  KullaniciId= 1
			  if (@KesimHareketId=0 AND @OptimizasyonNoStr is not null)  -- excel'de olup daha önce eklemediðimiz kaydý eklemek için ilave edildi
			  begin 
			  print 'KesimHareket insert üstü'
			          insert into KesimHareket
					  select   DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) as IseBaslangicSaati,
							   1 as KullaniciId,
							   @OptimizasyonNoStr,
							   @PlakaAdeti,
							   @ToplamDurus,
							   isnull(@PersonelId1,0),
							   isnull(@PersonelId2,0),
							   @IsIstasyonlariId,
							   'Excel'  as Aciklama,
							   '' as Lot1,
							   '' as Lot2,
							   '' as Lot3
		       end		
           end
		  -- select * into KesimHareket_20241218 from KesimHareket
	  end  -- kesim bitti ,diðerlerine bakýlacak
	  else
	  begin
	         

			 --select   
			 --@IsEmriNoStr,@BaslamaSaati,
		  --  --    STUFF(CAST(CAST(@IsEmriNo AS DECIMAL(20,0)) AS VARCHAR(20)), 5, 0, '.') , 
			 --  --DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) ,
			 --  @OperasyonTanimiId

	       -- 1. SaglamCamAdet için OperasyonHareket tablosuna kayýt atýlmasý
	       set @OperasyonHareketId= 0
	       select top 1 @OperasyonHareketId = OperasyonHareketId from OperasyonHareket where 
		      IsEmriNo =   @IsEmriNoStr and 
			  IseBaslangicSaati = DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) and 
			  OperasyonTanimiId = @OperasyonTanimiId
			 
	       -- select *   from OperasyonHareket
		   if (@OperasyonHareketId= 0 AND @UretimAdeti>0)
		   begin
		       if (@IsIstasyonlariId is null and @OperasyonTanimiId=9)
			   begin
			        set @IsIstasyonlariId = 40     --paketleme'de masa1 referansý aktarýldý
			   end
		      else if (@IsIstasyonlariId is null OR @OperasyonTanimiId is null)
			  begin
			    select 
						1 as KullaniciId,
						GETDATE() as RowUpdatedTime,
						DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) as IseBaslangicSaati,
						@OperasyonTanimiId,
						 @IsEmriNoStr as IsEmriNo,
						 @FercamUrunKodu,
						 @UretimAdeti as SaglamCamAdet,
						 isnull(@PersonelId1,2),
						 isnull(@PersonelId2,0),
						 isnull(@PersonelId3,0),
						 @IsIstasyonlariId,
						 'excel' as Aciklama,
						 '' as LotNo
			  end
			  else 
			  begin

		   insert into OperasyonHareket
			   select 
						1 as KullaniciId,
						GETDATE() as RowUpdatedTime,
						DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) as IseBaslangicSaati,
						@OperasyonTanimiId,
						 @IsEmriNoStr as IsEmriNo,
						 @FercamUrunKodu,
						 @UretimAdeti as SaglamCamAdet,
						 isnull(@PersonelId1,2),
						 isnull(@PersonelId2,0),
						 isnull(@PersonelId3,0),
						 @IsIstasyonlariId,
						 'excel' as Aciklama,
						 '' as LotNo
				end
		   end 	
		      -- 2. Hurda Cam için HurdaCamHareket tablosuna kayýt atýlmasý
			  -- select * from HurdaCamHareket
		   set @HurdaCamHareketId = 0
		   select  @HurdaCamHareketId=HurdaCamHareketId from HurdaCamHareket
		   where @IsEmriNoStr =IsEmriNo and 
		   OperasyonTanimiId = @OperasyonTanimiId and
		   Tarih = DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME))
		   if (@HurdaCamHareketId=0 and  @ToplamHataMiktari>0)
		   begin
		   print 'HurdaCamHareket insert üstü'
		     insert HurdaCamHareket
		   select 
		       DATEADD(SECOND, DATEDIFF(SECOND, 0, @BaslamaSaati), CAST(@Tarih AS DATETIME)) as Tarih,
			   1 as KullaniciId,
			   case when @OperasyonTanimiId=1 then isnull(@OptimizasyonNoStr,'') else (select top 1 OperasyonAdi from OperasyonTanimi where  OperasyonTanimiId=@OperasyonTanimiId)   end,
			   @IsEmriNoStr as IsEmriNo,
			   @ToplamHataMiktari,
			   1 as HataKodlariId, 
			   'excel' as Aciklama,
			   @OperasyonTanimiId
			     
	        end
	  end

    -- Sonraki kaydý oku
    FETCH NEXT FROM UretimCursor INTO 
        @Bolum, @Tarih, @VardiyaMakineNo, @OperatorSicilNo, @OperatorSicilNo1, 
        @OperatorSicilNo2, @OperatorSicilNo3, @OperatorSicilNo4, @OperatorSicilNo5,
        @ToplamOperatorSayisi, @BaslamaSaati, @BitisSaati, @GerceklesenIsSuresiSaat,
        @GerceklesenIsSuresiDK, @PlanlananSureDK, @M1, @M2, @M3, @M4, @M5, @M6, @M7, 
        @M8, @M9, @M10, @M11, @M12, @M13, @M14, @M15, @M16, @M17, @M15Aciklama, 
        @ToplamDurus, @MakineCalismaSuresiDK, @IsEmriNo, @SiparisNo, @OptimizasyonNo,
        @UrunAdi, @FercamUrunKodu, @MusteriUrunKodu, @FirmaAdi, @KesilecekMakine,
        @DelikliCam, @SiparisAdeti, @PlanlananAdet, @UretimAdeti, @SerigraftaSilinenCamAdeti,
        @H7, @H8, @H9, @H10, @H5, @H17, @H44, @H46, @H20, @H21, @H22, @H23, @H24, @H25,
        @H26, @H27, @H28, @H1, @H2, @H3, @H4, @H6, @H11, @H12, @H13, @H14, @H15, @H16,
        @H18, @H19, @H29, @H30, @H31, @H32, @H33, @H34, @H35, @H36, @H37, @H38, @H39,
        @H40, @H41, @H42, @H43, @H45, @H47, @H50, @H51, @H56, @ToplamHataMiktari,
        @KaliteOnaySicilNo, @PlakaAdeti, @ToplamPlakaAdeti, @OtoklavHataAyrimi, 
        @KaliteBitisMiktari, @En, @Boy, @Kalýnlýk, @Renk, @UretimAlanM2, @HatalýAlanM2, 
        @HatalýUretimYuzdesiM2, @HatalýUretimYuzdesiAdet;
END;

-- Cursor'ý kapat ve belleði temizle
CLOSE UretimCursor;
DEALLOCATE UretimCursor;


--  select * from OperasyonHareket where KullaniciId = 1 and IsEmriNo= '2312.0057'
--  select * from KesimHareket where KullaniciId = 1
--  select * from HurdaCamHareket where KullaniciId = 1


-- select * from VW_DurusHareket