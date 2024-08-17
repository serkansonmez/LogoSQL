USE [AltinCezveB2B_Default_v1]
GO

/****** Object:  StoredProcedure [dbo].[SP_GO3_CLFICHE_INSERT_24]    Script Date: 20.02.2024 21:35:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- SELECT * FROM GO3DB..LG_424_01_CLFICHE 
--SELECT * FROM GO3DB..LG_424_01_STLINE WHERE CLFICHEREF = 12426
-- EXECUTE DBO.SP_GO3_CLFICHE_INSERT_24  '375'

--EXEC DBO.[SP_GO3_CLFICHE_INSERT_24]

CREATE PROCEDURE [dbo].[SP_GO3_CLFICHE_INSERT_24]
          --@TigerBnficheRef int = 0
		    @SecilenKayitlar varchar(MAX)
as
begin 

    BEGIN TRY
        BEGIN TRANSACTION;
    CREATE TABLE #TempTable (Id varchar(30))

    -- Split the input string by comma and insert values into the temporary table
    DECLARE @StartPosition int = 0, @CommaPosition int = 0

    WHILE @StartPosition <= LEN(@SecilenKayitlar)
    BEGIN
        SET @CommaPosition = CHARINDEX(',', @SecilenKayitlar, @StartPosition)

        IF @CommaPosition = 0
            SET @CommaPosition = LEN(@SecilenKayitlar) + 1

        INSERT INTO #TempTable (Id)
        SELECT SUBSTRING(@SecilenKayitlar, @StartPosition, @CommaPosition - @StartPosition)

        SET @StartPosition = @CommaPosition + 1
    END

	--SELECT TOP 1 * FROM GO3DB..LG_424_01_CLFICHE ORDER BY LOGICALREF DESC
	DECLARE @TigerBnficheRef int = 0
	DECLARE @LOGICALREF int
	DECLARE @FICHENO varchar(17)
	DECLARE @DATE_ datetime
	DECLARE @DOCODE varchar(33)
	DECLARE @TRCODE smallint
	DECLARE @SPECCODE varchar(11)
	DECLARE @CYPHCODE varchar(11)
	DECLARE @BRANCH smallint
	DECLARE @DEPARTMENT smallint
	DECLARE @GENEXP1 varchar(51)
	DECLARE @GENEXP2 varchar(51)
	DECLARE @GENEXP3 varchar(51)
	DECLARE @GENEXP4 varchar(51)
	DECLARE @GENEXP5 varchar(51)
	DECLARE @GENEXP6 varchar(51)
	DECLARE @DEBIT float
	DECLARE @CREDIT float
	DECLARE @REPDEBIT float
	DECLARE @REPCREDIT float
	DECLARE @CAPIBLOCK_CREATEDBY smallint
	DECLARE @CAPIBLOCK_CREADEDDATE datetime
	DECLARE @CAPIBLOCK_CREATEDHOUR smallint
	DECLARE @CAPIBLOCK_CREATEDMIN smallint
	DECLARE @CAPIBLOCK_CREATEDSEC smallint
	DECLARE @CAPIBLOCK_MODIFIEDBY smallint
	DECLARE @CAPIBLOCK_MODIFIEDDATE datetime
	DECLARE @CAPIBLOCK_MODIFIEDHOUR smallint
	DECLARE @CAPIBLOCK_MODIFIEDMIN smallint
	DECLARE @CAPIBLOCK_MODIFIEDSEC smallint
	DECLARE @ACCOUNTED smallint
	DECLARE @INVOREF int
	DECLARE @CASHACCREF int
	DECLARE @CASHCENREF int
	DECLARE @PRINTCNT smallint
	DECLARE @CANCELLED smallint
	DECLARE @CANCELLEDACC smallint
	DECLARE @ACCFICHEREF int
	DECLARE @GENEXCTYP smallint
	DECLARE @LINEEXCTYP smallint
	DECLARE @TEXTINC smallint
	DECLARE @SITEID smallint
	DECLARE @RECSTATUS smallint
	DECLARE @ORGLOGICREF int
	DECLARE @WFSTATUS int
	DECLARE @TIME int
	DECLARE @CLCARDREF int
	DECLARE @BANKACCREF int
	DECLARE @BNACCREF int
	DECLARE @BNCENTERREF int
	DECLARE @TRADINGGRP varchar(17)
	DECLARE @POSCOMMACCREF int
	DECLARE @POSCOMMCENREF int
	DECLARE @POINTCOMMACCREF int
	DECLARE @POINTCOMMCENREF int
	DECLARE @PROJECTREF int
	DECLARE @STATUS smallint
	DECLARE @WFLOWCRDREF int
	DECLARE @ORGLOGOID varchar(25)
	DECLARE @AFFECTCOLLATRL smallint
	DECLARE @GRPFIRMTRANS smallint
	DECLARE @AFFECTRISK smallint
	DECLARE @POSTERMINALNR int
	DECLARE @POSTERMINALNUM varchar(17)
	DECLARE @APPROVE smallint
	DECLARE @APPROVEDATE datetime
	DECLARE @SALESMANREF int
	DECLARE @CSTRANSREF int
	DECLARE @DOCDATE datetime
	DECLARE @GUID varchar(37)
	DECLARE @DEVIR smallint
	DECLARE @PRINTDATE datetime
	DECLARE @FOREXIM smallint
	DECLARE @TYPECODE varchar(5)
	DECLARE @EINVOICE smallint
	DECLARE @HOUR_ smallint
	DECLARE @MINUTE_ smallint
	DECLARE @DEDUCTCODE varchar(11)
	DECLARE @ELECTDOC smallint
	DECLARE @NOTIFYCRDREF int
	DECLARE @GIBACCFICHEREF int
	DECLARE @PARTIALCSPAYREF int
	DECLARE @GIBINCMTAXREF int
	DECLARE @EXIMVAT smallint

	DECLARE @InputString varchar(500)
	declare @PRDATE datetime
	-- SELECT * FROM GO3DB..LG_424_01_CLFICHE WHERE LOGICALREF = 12426
	--1. se�ilen kay�tlar d�ng�ye al�n�yor...
	DECLARE processes CURSOR FOR

	 
	SELECT Id FROM #TempTable
	OPEN processes
 
	FETCH NEXT FROM processes
	INTO  @InputString
	WHILE @@FETCH_STATUS = 0
	BEGIN

	--2 �NCE TIGER2'DEN F���N DETAY B�LG�LER� ALINIYOR, REFERANSLARA D�KKAT ED�LECEK.
	set @TigerBnficheRef = CAST(@InputString as int )
	SELECT 
    @FICHENO = [FICHENO],
    @DATE_ = [DATE_],
    @DOCODE = [DOCODE],
    @TRCODE = [TRCODE],
    @SPECCODE = [SPECCODE],
    @CYPHCODE = [CYPHCODE],
    @BRANCH = [BRANCH],
    @DEPARTMENT = [DEPARTMENT],
    @GENEXP1 = [GENEXP1],
    @GENEXP2 = [GENEXP2],
    @GENEXP3 = [GENEXP3],
    @GENEXP4 = [GENEXP4],
    @DEBIT = [DEBIT],
    @CREDIT = [CREDIT],
    @REPDEBIT = [REPDEBIT],
    @REPCREDIT = [REPCREDIT],
    @CAPIBLOCK_CREATEDBY = [CAPIBLOCK_CREATEDBY],
    @CAPIBLOCK_CREADEDDATE = [CAPIBLOCK_CREADEDDATE],
    @CAPIBLOCK_CREATEDHOUR = [CAPIBLOCK_CREATEDHOUR],
    @CAPIBLOCK_CREATEDMIN = [CAPIBLOCK_CREATEDMIN],
    @CAPIBLOCK_CREATEDSEC = [CAPIBLOCK_CREATEDSEC],
    @CAPIBLOCK_MODIFIEDBY = [CAPIBLOCK_MODIFIEDBY],
    @CAPIBLOCK_MODIFIEDDATE = [CAPIBLOCK_MODIFIEDDATE],
    @CAPIBLOCK_MODIFIEDHOUR = [CAPIBLOCK_MODIFIEDHOUR],
    @CAPIBLOCK_MODIFIEDMIN = [CAPIBLOCK_MODIFIEDMIN],
    @CAPIBLOCK_MODIFIEDSEC = [CAPIBLOCK_MODIFIEDSEC],
    @ACCOUNTED = [ACCOUNTED],
    @INVOREF = [INVOREF],
    @CASHACCREF = [CASHACCREF],
    @CASHCENREF = [CASHCENREF],
    @PRINTCNT = [PRINTCNT],
    @CANCELLED = [CANCELLED],
    @CANCELLEDACC = [CANCELLEDACC],
    @ACCFICHEREF = [ACCFICHEREF],
    @GENEXCTYP = [GENEXCTYP],
    @LINEEXCTYP = [LINEEXCTYP],
    @TEXTINC = [TEXTINC],
    @SITEID = [SITEID],
    @RECSTATUS = [RECSTATUS],
    @ORGLOGICREF = [ORGLOGICREF],
    @WFSTATUS = [WFSTATUS],
    @TIME = [TIME],
    @CLCARDREF = [CLCARDREF],
    @BANKACCREF = [BANKACCREF],
    @BNACCREF = [BNACCREF],
    @BNCENTERREF = [BNCENTERREF],
    @TRADINGGRP = [TRADINGGRP],
    @POSCOMMACCREF = [POSCOMMACCREF],
    @POSCOMMCENREF = [POSCOMMCENREF],
    @POINTCOMMACCREF = [POINTCOMMACCREF],
    @POINTCOMMCENREF = [POINTCOMMCENREF],
    @PROJECTREF = [PROJECTREF],
    @STATUS = [STATUS],
    @WFLOWCRDREF = [WFLOWCRDREF],
    @ORGLOGOID = [ORGLOGOID],
    @AFFECTCOLLATRL = [AFFECTCOLLATRL],
    @GRPFIRMTRANS = [GRPFIRMTRANS],
    @AFFECTRISK = [AFFECTRISK],
    @POSTERMINALNR = [POSTERMINALNR],
    @POSTERMINALNUM = [POSTERMINALNUM],
    @APPROVE = [APPROVE],
    @APPROVEDATE = [APPROVEDATE],
    @SALESMANREF = [SALESMANREF],
    @CSTRANSREF = [CSTRANSREF],
    @DOCDATE = [DOCDATE],
    
FROM CEZVE.[dbo].[LG_324_01_CLFICHE] WHERE LOGICALREF = @TigerBnficheRef
	 

	--
	  --SET @CLIENTREF     = ( SELECT LOGICALREF FROM GO3DB..LG_424_CLCARD GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_324_CLCARD TGRCL WHERE TGRCL.LOGICALREF=   @CLIENTREF))
      
	  --SET @ACCOUNTREF     = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_324_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @ACCOUNTREF))

	-- 2. TIGER2'DEK�  DE�ERLERLE INSERT TAMAMLANIYOR.
   -- BEGIN TRY
		INSERT INTO go3db.[dbo].[LG_424_01_CLFICHE]
				   ([DATE_]
			   ,[FICHENO]
			   ,[SPECODE]
			   ,[CYPHCODE]
			   ,[BRANCH]
			   ,[DEPARMENT]
			   ,[TRCODE]
			   ,[MODULENR]
			   ,[SOURCEFREF]
			   ,[ACCOUNTED]
			   ,[CANCELLED]
			   ,[SIGN]
			   ,[DEBITTOT]
			   ,[CREDITTOT]
			   ,[GENEXP1]
			   ,[GENEXP2]
			   ,[GENEXP3]
			   ,[GENEXP4]
			   ,[GENEXP5]
			   ,[GENEXP6]
			   ,[PRINTCNT]
			   ,[CAPIBLOCK_CREATEDBY]
			   ,[CAPIBLOCK_CREADEDDATE]
			   ,[CAPIBLOCK_CREATEDHOUR]
			   ,[CAPIBLOCK_CREATEDMIN]
			   ,[CAPIBLOCK_CREATEDSEC]
			   ,[CAPIBLOCK_MODIFIEDBY]
			   ,[CAPIBLOCK_MODIFIEDDATE]
			   ,[CAPIBLOCK_MODIFIEDHOUR]
			   ,[CAPIBLOCK_MODIFIEDMIN]
			   ,[CAPIBLOCK_MODIFIEDSEC]
			   ,[CANCELLEDACC]
			   ,[ACCFICHEREF]
			   ,[GENEXCTYP]
			   ,[LINEEXCTYP]
			   ,[SITEID]
			   ,[RECSTATUS]
			   ,[ORGLOGICREF]
			   ,[REPDEBIT]
			   ,[REPCREDIT]
			   ,[TEXTINC]
			   ,[WFSTATUS]
			   ,[CRCARDWZD]
			   ,[BNACCOUNTREF]
			   ,[TRANGRPNO]
			   ,[PROJECTREF]
			   ,[COLLATROLLREF]
			   ,[COLLATTRNREF]
			   ,[BNCRREF]
			   ,[ORGLOGOID]
			   ,[REFLECTED]
			   ,[REFLACCFICHEREF]
			   ,[CANCELLEDREFLACC]
			   ,[APPROVE]
			   ,[APPROVEDATE]
			   ,[COLLATCARDREF]
			   ,[SALESMANREF]
			   ,[GUID]
			   ,[CRCARDWZDPER]
			   ,[LEASINGREF]
			   ,[OFFERREF]
			   ,[CRCARDFCREF]
			   ,[FROMCREDITCLOSE]
			   ,[FROMCURDIFFPROC]
			   ,[PRINTDATE]
			   ,[FTIME]
			   ,[FROMCRSTRUCT]
			   ,[STATUS]
			   ,[PARTIALCSPAYREF]
			   ,[EXIMVAT]
			   ,[GIBACCFICHEREF])
			 VALUES
				   (@DATE_ 
		,@FICHENO  
		,@SPECODE  
		,@CYPHCODE 
		,@BRANCH 
		,@DEPARMENT 
		,@TRCODE 
		,@MODULENR 
		,@SOURCEFREF 
		,@ACCOUNTED 
		,@CANCELLED 
		,@SIGN 
		,@DEBITTOT 
		,@CREDITTOT 
		,@GENEXP1 
		,@GENEXP2 
		,@GENEXP3 
		,@GENEXP4 
		,@GENEXP5 
		,@GENEXP6 
		,@PRCNT 
		,@CAPIBLOCK_CREATEDBY 
		,@CAPIBLOCK_CREADEDDATE 
		,@CAPIBLOCK_CREATEDHOUR 
		,@CAPIBLOCK_CREATEDMIN 
		,@CAPIBLOCK_CREATEDSEC 
		,@CAPIBLOCK_MODIFIEDBY 
		,@CAPIBLOCK_MODIFIEDDATE 
		,@CAPIBLOCK_MODIFIEDHOUR 
		,@CAPIBLOCK_MODIFIEDMIN 
		,@CAPIBLOCK_MODIFIEDSEC 
		,@CANCELLEDACC 
		,@ACCFICHEREF 
		,@GENEXCTYP 
		,@LINEEXCTYP 
		,@SITEID 
		,@RECSTATUS 
		,@ORGLOGICREF 
		,@REPDEBIT 
		,@REPCREDIT 
		,@TEXTINC 
		,@WFSTATUS 
		,@CRCARDWZD 
		,@BNACCOUNTREF 
		,@TRANGRPNO  
		,@PROJECTREF 
		,@COLLATROLLREF 
		,@COLLATTRNREF 
		,@BNCRREF 
		,@ORGLOGOID  
		,@REFLECTED 
		,@REFLACCFICHEREF 
		,@CANCELLEDREFLACC 
		,@APPROVE 
		,@APPROVEDATE 
		,@COLLATCARDREF 
		,@SALESMANREF 
		,@GUID  
		,@CRCARDWZDPER 
		,@LEASINGREF 
		,@OFFERREF 
		,@CRCARDFCREF 
		,@FROMCREDITCLOSE 
		,@FROMCURDIFFPROC 
		,@PRDATE 
		,@FTIME 
		,@FROMCRSTRUCT 
		,@STATUS 
		,@PARTIALCSPAYREF 
		,@EXIMVAT 
		,@GIBACCFICHEREF )
	 --COMMIT; -- Transaction ba�ar�yla tamamland�
	 --END TRY
  --   BEGIN CATCH
  --          ROLLBACK; -- Hata durumunda transaction geri al�nd�
  --          -- Hata i�leme kodlar� buraya gelecek
  --          PRINT 'Banka Fi�i Master Hata : '  + ERROR_MESSAGE();
  --    END CATCH
--	  BEGIN TRY
		--3. irsaliye fi�inin referans� al�nd�, detay sat�rlarda kullan�lacak
		DECLARE @Go3BankaFisiReferans int = 0;
		SET @Go3BankaFisiReferans = SCOPE_IDENTITY();
		--4. detay b�l�m�nde SP_Detay Kullan�c�lacak
		if (@Go3BankaFisiReferans is not null)
		begin
			 EXEC DBO.SP_GO3_BNFLINE_INSERT_24 @TigerBnficheRef, @Go3BankaFisiReferans
		--5. Tiger' docNo'ya insert edilen kay�t update edilecek
		     update  CEZVE..LG_324_01_CLFICHE SET SPECODE = @FICHENO    WHERE LOGICALREF = @TigerBnficheRef
        end
    --	COMMIT; -- Transaction ba�ar�yla tamamland�
    --END TRY
    --BEGIN CATCH
    --    ROLLBACK; -- Hata durumunda transaction geri al�nd�
    --    -- Hata i�leme kodlar� buraya gelecek
    --      PRINT 'Banka Fi�i Master Hata : '  + ERROR_MESSAGE();
    --END CATCH
    FETCH NEXT FROM processes
	INTO  @InputString
	END

	CLOSE processes
	DEALLOCATE processes



	      COMMIT; -- Commit the transaction if everything is successful
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK; -- Roll back the transaction if an error occurs

        -- Handle the error (you can log it, print a message, etc.)
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH

--return  @Go3IrsaliyeFisiReferans
END

--DELETE from GO3DB..LG_424_01_BNFLINE WHERE SOURCEFREF IS NULL 
GO


