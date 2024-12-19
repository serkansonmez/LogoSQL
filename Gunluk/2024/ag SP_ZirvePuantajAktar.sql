 

--  exec [SP_ZirvePuantajAktar] '453,454'
alter PROCEDURE [dbo].SP_ZirvePuantajAktar
    @SecilenKayitlar varchar(MAX)
AS
BEGIN

    CREATE TABLE #TempTable (Id varchar(30))

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

	DECLARE @DynamicDatabase NVARCHAR(200)
    DECLARE @DynamicQuery NVARCHAR(MAX)
	DECLARE @Query1 NVARCHAR(MAX) = ' '
	DECLARE @Query2 NVARCHAR(MAX) = ' '
	DECLARE @Query3 NVARCHAR(MAX) = ' '
	declare  @Yil int = 2024  
    declare @AyIndex int = 10
	DECLARE @InputString varchar(500)
	DECLARE @Id int
	  select @DynamicDatabase=sube.DbKlavuz,@Yil=Yil,@AyIndex=Ay from [ArGrupB2B_Default_v1]..PuantajTigemExcel pnt
	 left join [ArGrupB2B_Default_v1]..ZirveSubeler sube on sube.Id = pnt.zirveSubelerId
	where pnt.Id= (select top 1 Id FROM #TempTable)
	set @DynamicDatabase = '[' + @DynamicDatabase + '_GENEL]'
	DECLARE processes CURSOR FOR

  

	SELECT Id FROM #TempTable
	OPEN processes
 
	FETCH NEXT FROM processes
	INTO  @Id
	WHILE @@FETCH_STATUS = 0
	BEGIN
	        
		 
		 
	       
	        SET @Query1 = N' insert into  ' + @DynamicDatabase + '..puanbil 
			SELECT 
				   Ay [Ayindex]
				  ,(select max(SiraNo) + 1 from ' + @DynamicDatabase + '..puanbil  ) as [Sirano]
				  ,perbilgi.[Personelno]
				  ,1 [Puantajno]
				  ,perbilgi.Pgk [Personelgrubu]
				  ,perbilgi.Maas [Ucret]
				  ,pnt.syegs [Calismagunu]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''BT'') as [Geneltatil]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''HT'') as[Haftasonu]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''R'') as[Sihhiizin]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''Yн'') as[Yillikizin]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''MG'') as[Ucretliizin]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''мн'') as[Ucretsizizin]
				  ,[ArGrupB2B_Default_v1].dbo.fnc_CountPuantajTigemExcel(pnt.Id,''MG'')[Mazeretgunu]
				  ,pnt.hegs [Toplamisgunu]
				  ,pnt.hegs [Primgunu]
				  ,0 [fm1]
				  ,0 [fm2]
				  ,0 [fm3]
				  ,0 [Eksikcalsaati]
				  ,''01'' [Epgn]
				  ,null [Cs]
				  ,null [Hs]
				  ,-1 [Dvm]
				  ,perbilgi.Maas [Au]
				  ,0 [Fm]
				  ,-1 [So]
				  ,null [Cp]
				  ,-1 [Bt]
				  ,-1 [Vem]
				  ,-1 [Sim]
				  ,0 [Vrgi]
				  ,-1 [Gev]
				  ,-1 [Sk]
				  ,-1 [Isk]
				  ,-1 [Dv]
				  ,-1 [Sak]
				  ,-1 [Kt]
				  ,-1 [Netu]
				  ,-1 [Isskk]
				  ,-1 [Iisk]
				  ,-1 [Gsigm]
				  ,0 [Uip]
				  ,1 [Aei]
				  ,-1 [Fsk]
				  ,''D'' [Dsm]
				  ,0 [Veriade]
				  ,replace(replace(replace(replace(pnt.g1,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g1]
				  ,replace(replace(replace(replace(pnt.g2,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g2]
				  ,replace(replace(replace(replace(pnt.g3,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g3]
				  ,replace(replace(replace(replace(pnt.g4,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g4]
				  ,replace(replace(replace(replace(pnt.g5,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g5]
				  ,replace(replace(replace(replace(pnt.g6,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g6]
				  ,replace(replace(replace(replace(pnt.g7,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g7]
				  ,replace(replace(replace(replace(pnt.g8,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g8]
				  ,replace(replace(replace(replace(pnt.g9,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g9]
				  ,replace(replace(replace(replace(pnt.g10,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g10]
				  ,replace(replace(replace(replace(pnt.g11,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g11]
				  ,replace(replace(replace(replace(pnt.g12,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g12]
				  ,replace(replace(replace(replace(pnt.g13,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g13]'
				  set    @Query2 = N'
				  ,replace(replace(replace(replace(pnt.g14,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g14]
				  ,replace(replace(replace(replace(pnt.g15,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g15]
				  ,replace(replace(replace(replace(pnt.g16,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g16]
				  ,replace(replace(replace(replace(pnt.g17,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g17]
				  ,replace(replace(replace(replace(pnt.g18,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g18]
				  ,replace(replace(replace(replace(pnt.g19,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g19]
				  ,replace(replace(replace(replace(pnt.g20,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g20]
				  ,replace(replace(replace(replace(pnt.g21,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g21]
				  ,replace(replace(replace(replace(pnt.g22,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g22]
				  ,replace(replace(replace(replace(pnt.g23,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g23]
				  ,replace(replace(replace(replace(pnt.g24,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g24]
				  ,replace(replace(replace(replace(pnt.g25,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g25]
				  ,replace(replace(replace(replace(pnt.g26,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g26]
				  ,replace(replace(replace(replace(pnt.g27,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g27]
				  ,replace(replace(replace(replace(pnt.g28,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g28]
				  ,replace(replace(replace(replace(pnt.g29,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g29]
				  ,replace(replace(replace(replace(pnt.g30,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g30]
				  ,replace(replace(replace(replace(pnt.g31,''X'',''N''),''R'',''м''),''HT'',''T''),'''',''X'') [g31]'
				   set    @Query3 = N'
				  ,0 [Gelirindirim]
				  ,0 [Sskindirim]
				  ,perbilgi.Us [Ucretsekli]
				  ,perbilgi.Ts [Tahakkuksekli]
				  ,0 [Vmb]
				  ,0 [Vmpk]
				  ,pnt.Yil [Yil]
				  ,perbilgi.SSno [SSno]
				  ,''01'' [Belgeturu]
				  ,0 [Dinitatil]
				  ,null [Arti]
				  ,''0000'' [Kanunno]
				  ,perbilgi.[Sozlesmeturu]
				  ,perbilgi.[Personeldurumu]
				  ,0 [fmtutar1]
				  ,0 [fmtutar2]
				  ,0 [fmtutar3]
				  ,0 [Asgari_gecim_ind_tut]
				  ,0 [Kilitli]
				  ,null [Bordrotipi]
				  ,0 [Asgari_gecim_ind_brut]
				  ,0 [Asgari_gecim_ind_oran]
				  ,perbilgi.[Grupkodu]
				  ,0 [Sanalgev]
				  ,perbilgi.[Doktoralimi]
				  ,''H'' [Asgarimi]
				  ,0 [Devir_ssk]
				  ,0 [Devir_ssk_kullanilan]
				  ,0 [Devir_ssk_aya_yazilacak]
				  ,0 [Devir_ssk1]
				  ,0 [Devir_ssk2]
				  ,null [Devir_ssk3]
				  ,perbilgi.[Gorevi]
				  ,perbilgi.Mg [Meslekgrubu]
				  ,perbilgi.Mes [Meslegi]
				  ,0 [Onbesgunluk]
				  ,0 [zi1]
				  ,1 [r1]
				  ,null [zi4]
				  ,1 [r3]
				  ,null [agi]
				  ,1 [zi2]
				  ,null [Digerkanun]
				  ,0 [Damga_Vergi_Ist]
				  ,null [Bolgeici_Vergi_Matrahi]
				  ,0 [KisaCalismaGunu]
				  ,0 [KisaCalismaIlk7Gunu]
				  ,null [KisaCalismaHafCalGun]
				  ,null [KisaCalismaIlk7GunHesapla]
				  ,-1 [AsgariUcretDevirVergiMatrahi]
				  ,-1 [AsgariUcretVergiIstisnaTutari]
				  ,-1 [DamgaVergisiMatrahiIstisnaSonrasi]
				  ,-1 [GelirVergisiMatrahIndirimi]
				  ,null [FmTutar1Brut]
				  ,null [FmTutar2Brut]
				  ,null [FmTutar3Brut]
				  ,null [UcusDalisOrani]
	  
			  FROM [ArGrupB2B_Default_v1]..PuantajTigemExcel pnt  
			  left join [ArGrupB2B_Default_v1]..ZirveSubeler sube on sube.Id = pnt.zirveSubelerId
			  left join  ' + @DynamicDatabase + '..perbilgi perbilgi on  perbilgi.vatno = pnt.TcKimlikNo
			  left join  ' + @DynamicDatabase + '..[puanbil] zirvepnt on  zirvepnt.personelno = perbilgi.personelno and zirvepnt.Yil = @Yil and zirvepnt.ayindex = @AyIndex
			  where pnt.Yil = @Yil and pnt.Ay = @AyIndex   AND pnt.Id=@Id and zirvepnt.Sirano is null'
		     set @DynamicQuery = (@Query1 +  @Query2 + @Query3)
			 --select @DynamicQuery

		      -- Dinamik sorguyu чal§ўt§r
		      EXEC sp_executesql @DynamicQuery  , N'@AyIndex INT,  @Yil INT, @Id INT', @AyIndex = @AyIndex, @Yil= @Yil, @Id = @Id


	FETCH NEXT FROM processes
	INTO  @Id
	END

	CLOSE processes
	DEALLOCATE processes
	
  
    -- Clean up the temporary table

      IF OBJECT_ID('tempdb..#TempTable') IS NOT NULL
        DROP TABLE #TempTable; -- #TempTable varsa kald§r
   
 END
