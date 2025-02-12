USE [AltinCezveB2B_Default_v1]
GO

/****** Object:  StoredProcedure [dbo].[SP_GO3_CLFLINE_INSERT_24]    Script Date: 20.02.2024 21:58:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 
CREATE PROCEDURE [dbo].[SP_GO3_CLFLINE_INSERT_24]
          @TigerClficheRef INT,
		  @Go3ClficheRef INT
		   
as
begin 
--TANIMLAMALAR
DECLARE @LOGICALREF int

DECLARE @CLIENTREF INT;
DECLARE @CLACCREF INT;
DECLARE @CLCENTERREF INT;
DECLARE @CASHCENTERREF INT;
DECLARE @CASHACCOUNTREF INT;
DECLARE @VIRMANREF INT;
DECLARE @SOURCEFREF INT;
DECLARE @DATE_ DATETIME;
DECLARE @DEPARTMENT SMALLINT;
DECLARE @BRANCH SMALLINT;
DECLARE @MODULENR SMALLINT;
DECLARE @TRCODE SMALLINT;
DECLARE @LINENR SMALLINT;
DECLARE @SPECODE VARCHAR(11);
DECLARE @CYPHCODE VARCHAR(11);
DECLARE @TRANNO VARCHAR(17);
DECLARE @DOCODE VARCHAR(33);
DECLARE @LINEEXP VARCHAR(251);
DECLARE @ACCOUNTED SMALLINT;
DECLARE @SIGN SMALLINT;
DECLARE @AMOUNT FLOAT;
DECLARE @TRCURR SMALLINT;
DECLARE @TRRATE FLOAT;
DECLARE @TRNET FLOAT;
DECLARE @REPORTRATE FLOAT;
DECLARE @REPORTNET FLOAT;
DECLARE @EXTENREF INT;
DECLARE @PAYDEFREF INT;
DECLARE @ACCFICHEREF INT;
DECLARE @PRINTCNT SMALLINT;
DECLARE @CAPIBLOCK_CREATEDBY SMALLINT;
DECLARE @CAPIBLOCK_CREADEDDATE DATETIME;
DECLARE @CAPIBLOCK_CREATEDHOUR SMALLINT;
DECLARE @CAPIBLOCK_CREATEDMIN SMALLINT;
DECLARE @CAPIBLOCK_CREATEDSEC SMALLINT;
DECLARE @CAPIBLOCK_MODIFIEDBY SMALLINT;
DECLARE @CAPIBLOCK_MODIFIEDDATE DATETIME;
DECLARE @CAPIBLOCK_MODIFIEDHOUR SMALLINT;
DECLARE @CAPIBLOCK_MODIFIEDMIN SMALLINT;
DECLARE @CAPIBLOCK_MODIFIEDSEC SMALLINT;
DECLARE @CANCELLED SMALLINT;
DECLARE @TRGFLAG SMALLINT;
DECLARE @TRADINGGRP VARCHAR(17);
DECLARE @LINEEXCTYP SMALLINT;
DECLARE @ONLYONEPAYLINE SMALLINT;
DECLARE @DISCFLAG SMALLINT;
DECLARE @DISCRATE FLOAT;
DECLARE @VATRATE FLOAT;
DECLARE @CASHAMOUNT FLOAT;
DECLARE @DISCACCREF INT;
DECLARE @DISCCENREF INT;
DECLARE @VATRACCREF INT;
DECLARE @VATRCENREF INT;
DECLARE @PAYMENTREF INT;
DECLARE @VATAMOUNT FLOAT;
DECLARE @SITEID SMALLINT;
DECLARE @RECSTATUS SMALLINT;
DECLARE @ORGLOGICREF INT;
DECLARE @INFIDX FLOAT;
DECLARE @POSCOMMACCREF INT;
DECLARE @POSCOMMCENREF INT;
DECLARE @POINTCOMMACCREF INT;
DECLARE @POINTCOMMCENREF INT;
DECLARE @CHEQINFO VARCHAR(121);
DECLARE @CREDITCNO VARCHAR(25);
DECLARE @CLPRJREF INT;
DECLARE @STATUS SMALLINT;
DECLARE @EXIMFILEREF INT;
DECLARE @EXIMPROCNR SMALLINT;
DECLARE @MONTH_ SMALLINT;
DECLARE @YEAR_ SMALLINT;
DECLARE @FUNDSHARERAT FLOAT;
DECLARE @AFFECTCOLLATRL SMALLINT;
DECLARE @GRPFIRMTRANS SMALLINT;
DECLARE @REFLVATACCREF INT;
DECLARE @REFLVATOTHACCREF INT;
DECLARE @AFFECTRISK SMALLINT;
DECLARE @BATCHNR INT;
DECLARE @APPROVENR INT;
DECLARE @BATCHNUM VARCHAR(17);
DECLARE @APPROVENUM VARCHAR(17);
DECLARE @EUVATSTATUS INT;
DECLARE @ORGLOGOID VARCHAR(25);
DECLARE @EXIMTYPE SMALLINT;
DECLARE @EIDISTFLNNR SMALLINT;
DECLARE @EISRVDSTTYP SMALLINT;
DECLARE @EXIMDISTTYP SMALLINT;
DECLARE @SALESMANREF INT;
DECLARE @BANKACCREF INT;
DECLARE @BNACCREF INT;
DECLARE @BNCENTERREF INT;
DECLARE @DEVIRPROCDATE DATETIME;
DECLARE @DOCDATE DATETIME;
DECLARE @INSTALREF INT;
DECLARE @DEVIR SMALLINT;
DECLARE @DEVIRMODULENR INT;
DECLARE @FTIME INT;
DECLARE @OFFERREF INT;
DECLARE @RETCCFCREF INT;
DECLARE @EMFLINEREF INT;
DECLARE @FROMEXCHDIFF SMALLINT;
DECLARE @CANDEDUCT SMALLINT;
DECLARE @DEDUCTIONPART1 SMALLINT;
DECLARE @DEDUCTIONPART2 SMALLINT;
DECLARE @UNDERDEDUCTLIMIT SMALLINT;
DECLARE @VATDEDUCTRATE FLOAT;
DECLARE @VATDEDUCTACCREF INT;
DECLARE @VATDEDUCTOTHACCREF INT;
DECLARE @VATDEDUCTCENREF INT;
DECLARE @VATDEDUCTOTHCENREF INT;
DECLARE @CANTCREDEDUCT SMALLINT;
DECLARE @GUID VARCHAR(37);
DECLARE @PAIDINCASH SMALLINT;
DECLARE @BRUTAMOUNT FLOAT;
DECLARE @NETAMOUNT FLOAT;
DECLARE @BRUTAMOUNTTR FLOAT;
DECLARE @NETAMOUNTTR FLOAT;
DECLARE @BRUTAMOUNTREP FLOAT;
DECLARE @NETAMOUNTREP FLOAT;
DECLARE @BNLNTRCURR SMALLINT;
DECLARE @BNLNTRRATE FLOAT;
DECLARE @BNLNTRNET FLOAT;
DECLARE @PRINTDATE DATETIME;
DECLARE @INCDEDUCTAMNT SMALLINT;
DECLARE @AFFECTCOST SMALLINT;
DECLARE @FOREXIM SMALLINT;
DECLARE @EXIMFILECODECLF VARCHAR(25);
DECLARE @SPECODE2 VARCHAR(41);
DECLARE @SERVREASONDEF VARCHAR(251);


--2- tiger irsaliye sat�rlar� d�ng�ye al�nacak
DECLARE processesDetail CURSOR FOR

 
SELECT [LOGICALREF]
      ,[CLIENTREF]
      ,[CLACCREF]
      ,[CLCENTERREF]
      ,[CASHCENTERREF]
      ,[CASHACCOUNTREF]
      ,[VIRMANREF]
      ,[SOURCEFREF]
      ,[DATE_]
      ,[DEPARTMENT]
      ,[BRANCH]
      ,[MODULENR]
      ,[TRCODE]
      ,[LINENR]
      ,[SPECODE]
      ,[CYPHCODE]
      ,[TRANNO]
      ,[DOCODE]
      ,[LINEEXP]
      ,[ACCOUNTED]
      ,[SIGN]
      ,[AMOUNT]
      ,[TRCURR]
      ,[TRRATE]
      ,[TRNET]
      ,[REPORTRATE]
      ,[REPORTNET]
      ,[EXTENREF]
      ,[PAYDEFREF]
      ,[ACCFICHEREF]
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
      ,[CANCELLED]
      ,[TRGFLAG]
      ,[TRADINGGRP]
      ,[LINEEXCTYP]
      ,[ONLYONEPAYLINE]
      ,[DISCFLAG]
      ,[DISCRATE]
      ,[VATRATE]
      ,[CASHAMOUNT]
      ,[DISCACCREF]
      ,[DISCCENREF]
      ,[VATRACCREF]
      ,[VATRCENREF]
      ,[PAYMENTREF]
      ,[VATAMOUNT]
      ,[SITEID]
      ,[RECSTATUS]
      ,[ORGLOGICREF]
      ,[INFIDX]
      ,[POSCOMMACCREF]
      ,[POSCOMMCENREF]
      ,[POINTCOMMACCREF]
      ,[POINTCOMMCENREF]
      ,[CHEQINFO]
      ,[CREDITCNO]
      ,[CLPRJREF]
      ,[STATUS]
      ,[EXIMFILEREF]
      ,[EXIMPROCNR]
      ,[MONTH_]
      ,[YEAR_]
      ,[FUNDSHARERAT]
      ,[AFFECTCOLLATRL]
      ,[GRPFIRMTRANS]
      ,[REFLVATACCREF]
      ,[REFLVATOTHACCREF]
      ,[AFFECTRISK]
      ,[BATCHNR]
      ,[APPROVENR]
      ,[BATCHNUM]
      ,[APPROVENUM]
      ,[EUVATSTATUS]
      ,[ORGLOGOID]
      ,[EXIMTYPE]
      ,[EIDISTFLNNR]
      ,[EISRVDSTTYP]
      ,[EXIMDISTTYP]
      ,[SALESMANREF]
      ,[BANKACCREF]
      ,[BNACCREF]
      ,[BNCENTERREF]
      ,[DEVIRPROCDATE]
      ,[DOCDATE]
      ,[INSTALREF]
      ,[DEVIR]
      ,[DEVIRMODULENR]
      ,[FTIME]
  FROM CEZVE.[dbo].[LG_324_01_CLFLINE] WHERE SOURCEFREF = @TigerClficheRef

  --SELECT * FROM CEZVE..[LG_324_01_CLFLINE]
OPEN processesDetail
 
FETCH NEXT FROM processesDetail
INTO @LOGICALREF,@CLIENTREF,@CLACCREF,@CLCENTERREF,@CASHCENTERREF,@CASHACCOUNTREF,@VIRMANREF,@SOURCEFREF,@DATE_,@DEPARTMENT,@BRANCH,@MODULENR,@TRCODE,@LINENR,@SPECODE
,@CYPHCODE,@TRANNO,@DOCODE,@LINEEXP,@ACCOUNTED,@SIGN,@AMOUNT,@TRCURR,@TRRATE,@TRNET,@REPORTRATE,@REPORTNET,@EXTENREF,@PAYDEFREF,@ACCFICHEREF,@PRINTCNT,@CAPIBLOCK_CREATEDBY,@CAPIBLOCK_CREADEDDATE
,@CAPIBLOCK_CREATEDHOUR,@CAPIBLOCK_CREATEDMIN,@CAPIBLOCK_CREATEDSEC,@CAPIBLOCK_MODIFIEDBY,@CAPIBLOCK_MODIFIEDDATE,@CAPIBLOCK_MODIFIEDHOUR,@CAPIBLOCK_MODIFIEDMIN,@CAPIBLOCK_MODIFIEDSEC
,@CANCELLED,@TRGFLAG,@TRADINGGRP,@LINEEXCTYP,@ONLYONEPAYLINE,@DISCFLAG,@DISCRATE,@VATRATE,@CASHAMOUNT,@DISCACCREF,@DISCCENREF,@VATRACCREF,@VATRCENREF,@PAYMENTREF,@VATAMOUNT
,@SITEID,@RECSTATUS,@ORGLOGICREF,@INFIDX,@POSCOMMACCREF,@POSCOMMCENREF,@POINTCOMMACCREF,@POINTCOMMCENREF,@CHEQINFO,@CREDITCNO,@CLPRJREF,@STATUS,@EXIMFILEREF,@EXIMPROCNR,@MONTH_,@YEAR_
,@FUNDSHARERAT,@AFFECTCOLLATRL,@GRPFIRMTRANS,@REFLVATACCREF,@REFLVATOTHACCREF,@AFFECTRISK,@BATCHNR,@APPROVENR,@BATCHNUM,@APPROVENUM,@EUVATSTATUS,@ORGLOGOID,@EXIMTYPE,@EIDISTFLNNR,@EISRVDSTTYP,@EXIMDISTTYP
,@SALESMANREF,@BANKACCREF,@BNACCREF,@BNCENTERREF,@DEVIRPROCDATE,@DOCDATE,@INSTALREF,@DEVIR,@DEVIRMODULENR,@FTIME
WHILE @@FETCH_STATUS = 0
BEGIN
        --3 REFERANSLARA D�KKAT ED�LECEK
		--SELECT * FROM GO3DB..LG_424_01_CLFLINE WHERE STFICHEREF = 12426
		--SELECT * FROM CEZVE..LG_324_ITEMS TGRCL WHERE TGRCL.LOGICALREF=   886
	
	 SET @BANKREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_BNCARD GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 specode FROM CEZVE..LG_324_BNCARD TGRCL WHERE TGRCL.LOGICALREF=   @BANKREF))
	 SET @BNACCREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_BANKACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CYPHCODE FROM CEZVE..LG_324_BANKACC TGRCL WHERE TGRCL.LOGICALREF=   @BNACCREF))
	 SET @CLIENTREF     = ( SELECT LOGICALREF FROM GO3DB..LG_424_CLCARD GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_324_CLCARD TGRCL WHERE TGRCL.LOGICALREF=   @CLIENTREF))

   
	 SET @BNACCOUNTREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_318_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @BNACCOUNTREF)) --2482
	 SET @ACCOUNTREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_318_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @ACCOUNTREF)) --2482
	 SET @VATRACCREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_318_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @VATRACCREF)) --2482
	 SET @BNTRCOSTACCREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_318_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @BNTRCOSTACCREF)) --2482
	 SET @BNTRCOSTACCREF2 = ( SELECT LOGICALREF FROM GO3DB..LG_424_EMUHACC GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_318_EMUHACC TGRCL WHERE TGRCL.LOGICALREF=   @BNTRCOSTACCREF2)) --2482
	----Birim referans�
	--SET @UOMREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_UNITSETL GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_324_UNITSETL TGRCL WHERE TGRCL.LOGICALREF=   @UOMREF)) --2482
	----Birim seti referans�
	--SET @USREF = ( SELECT LOGICALREF FROM GO3DB..LG_424_UNITSETF GOCL WITH(NOLOCK) WHERE GOCL.CODE IN (SELECT TOP 1 CODE FROM CEZVE..LG_324_UNITSETF TGRCL WHERE TGRCL.LOGICALREF=   @USREF)) --2482

 --   SET @INVOICEREF = 0  
	
INSERT INTO [GO3DB]..[LG_424_01_CLFLINE]
           ([CLIENTREF]
           ,[CLACCREF]
           ,[CLCENTERREF]
           ,[CASHCENTERREF]
           ,[CASHACCOUNTREF]
           ,[VIRMANREF]
           ,[SOURCEFREF]
           ,[DATE_]
           ,[DEPARTMENT]
           ,[BRANCH]
           ,[MODULENR]
           ,[TRCODE]
           ,[LINENR]
           ,[SPECODE]
           ,[CYPHCODE]
           ,[TRANNO]
           ,[DOCODE]
           ,[LINEEXP]
           ,[ACCOUNTED]
           ,[SIGN]
           ,[AMOUNT]
           ,[TRCURR]
           ,[TRRATE]
           ,[TRNET]
           ,[REPORTRATE]
           ,[REPORTNET]
           ,[EXTENREF]
           ,[PAYDEFREF]
           ,[ACCFICHEREF]
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
           ,[CANCELLED]
           ,[TRGFLAG]
           ,[TRADINGGRP]
           ,[LINEEXCTYP]
           ,[ONLYONEPAYLINE]
           ,[DISCFLAG]
           ,[DISCRATE]
           ,[VATRATE]
           ,[CASHAMOUNT]
           ,[DISCACCREF]
           ,[DISCCENREF]
           ,[VATRACCREF]
           ,[VATRCENREF]
           ,[PAYMENTREF]
           ,[VATAMOUNT]
           ,[SITEID]
           ,[RECSTATUS]
           ,[ORGLOGICREF]
           ,[INFIDX]
           ,[POSCOMMACCREF]
           ,[POSCOMMCENREF]
           ,[POINTCOMMACCREF]
           ,[POINTCOMMCENREF]
           ,[CHEQINFO]
           ,[CREDITCNO]
           ,[CLPRJREF]
           ,[STATUS]
           ,[EXIMFILEREF]
           ,[EXIMPROCNR]
           ,[MONTH_]
           ,[YEAR_]
           ,[FUNDSHARERAT]
           ,[AFFECTCOLLATRL]
           ,[GRPFIRMTRANS]
           ,[REFLVATACCREF]
           ,[REFLVATOTHACCREF]
           ,[AFFECTRISK]
           ,[BATCHNR]
           ,[APPROVENR]
           ,[BATCHNUM]
           ,[APPROVENUM]
           ,[EUVATSTATUS]
           ,[ORGLOGOID]
           ,[EXIMTYPE]
           ,[EIDISTFLNNR]
           ,[EISRVDSTTYP]
           ,[EXIMDISTTYP]
           ,[SALESMANREF]
           ,[BANKACCREF]
           ,[BNACCREF]
           ,[BNCENTERREF]
           ,[DEVIRPROCDATE]
           ,[DOCDATE]
           ,[INSTALREF]
           ,[DEVIR]
           ,[DEVIRMODULENR]
           ,[FTIME]
           ,[OFFERREF]
           ,[RETCCFCREF]
           ,[EMFLINEREF]
           ,[FROMEXCHDIFF]
           ,[CANDEDUCT]
           ,[DEDUCTIONPART1]
           ,[DEDUCTIONPART2]
           ,[UNDERDEDUCTLIMIT]
           ,[VATDEDUCTRATE]
           ,[VATDEDUCTACCREF]
           ,[VATDEDUCTOTHACCREF]
           ,[VATDEDUCTCENREF]
           ,[VATDEDUCTOTHCENREF]
           ,[CANTCREDEDUCT]
           ,[GUID]
           ,[PAIDINCASH]
           ,[BRUTAMOUNT]
           ,[NETAMOUNT]
           ,[BRUTAMOUNTTR]
           ,[NETAMOUNTTR]
           ,[BRUTAMOUNTREP]
           ,[NETAMOUNTREP]
           ,[BNLNTRCURR]
           ,[BNLNTRRATE]
           ,[BNLNTRNET]
           ,[PRINTDATE]
           ,[INCDEDUCTAMNT]
           ,[AFFECTCOST]
           ,[FOREXIM]
           ,[EXIMFILECODECLF]
           ,[SPECODE2]
           ,[SERVREASONDEF])
     VALUES
           (@CLIENTREF
           ,@CLACCREF
           ,@CLCENTERREF
           ,@CASHCENTERREF
           ,@CASHACCOUNTREF
           ,@VIRMANREF
           ,@SOURCEFREF
           ,@DATE_
           ,@DEPARTMENT
           ,@BRANCH
           ,@MODULENR
           ,@TRCODE
           ,@LINENR
           ,@SPECODE
           ,@CYPHCODE
           ,@TRANNO
           ,@DOCODE
           ,@LINEEXP
           ,@ACCOUNTED
           ,@SIGN
           ,@AMOUNT
           ,@TRCURR
           ,@TRRATE
           ,@TRNET
           ,@REPORTRATE
           ,@REPORTNET
           ,@EXTENREF
           ,@PAYDEFREF
           ,@ACCFICHEREF
           ,@PRINTCNT
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
           ,@CANCELLED
           ,@TRGFLAG
           ,@TRADINGGRP
           ,@LINEEXCTYP
           ,@ONLYONEPAYLINE
           ,@DISCFLAG
           ,@DISCRATE
           ,@VATRATE
           ,@CASHAMOUNT
           ,@DISCACCREF
           ,@DISCCENREF
           ,@VATRACCREF
           ,@VATRCENREF
           ,@PAYMENTREF
           ,@VATAMOUNT
           ,@SITEID
           ,@RECSTATUS
           ,@ORGLOGICREF
           ,@INFIDX
           ,@POSCOMMACCREF
           ,@POSCOMMCENREF
           ,@POINTCOMMACCREF
           ,@POINTCOMMCENREF
           ,@CHEQINFO
           ,@CREDITCNO
           ,@CLPRJREF
           ,@STATUS
           ,@EXIMFILEREF
           ,@EXIMPROCNR
           ,@MONTH_
           ,@YEAR_
           ,@FUNDSHARERAT
           ,@AFFECTCOLLATRL
           ,@GRPFIRMTRANS
           ,@REFLVATACCREF
           ,@REFLVATOTHACCREF
           ,@AFFECTRISK
           ,@BATCHNR
           ,@APPROVENR
           ,@BATCHNUM
           ,@APPROVENUM
           ,@EUVATSTATUS
           ,@ORGLOGOID
           ,@EXIMTYPE
           ,@EIDISTFLNNR
           ,@EISRVDSTTYP
           ,@EXIMDISTTYP
           ,@SALESMANREF
           ,@BANKACCREF
           ,@BNACCREF
           ,@BNCENTERREF
           ,@DEVIRPROCDATE
           ,@DOCDATE
           ,@INSTALREF
           ,@DEVIR
           ,@DEVIRMODULENR
           ,@FTIME
           ,@OFFERREF
           ,@RETCCFCREF
           ,@EMFLINEREF
           ,@FROMEXCHDIFF
           ,@CANDEDUCT
           ,@DEDUCTIONPART1
           ,@DEDUCTIONPART2
           ,@UNDERDEDUCTLIMIT
           ,@VATDEDUCTRATE
           ,@VATDEDUCTACCREF
           ,@VATDEDUCTOTHACCREF
           ,@VATDEDUCTCENREF
           ,@VATDEDUCTOTHCENREF
           ,@CANTCREDEDUCT
           ,@GUID
           ,@PAIDINCASH
           ,@BRUTAMOUNT
           ,@NETAMOUNT
           ,@BRUTAMOUNTTR
           ,@NETAMOUNTTR
           ,@BRUTAMOUNTREP
           ,@NETAMOUNTREP
           ,@BNLNTRCURR
           ,@BNLNTRRATE
           ,@BNLNTRNET
           ,@PRINTDATE
           ,@INCDEDUCTAMNT
           ,@AFFECTCOST
           ,@FOREXIM
           ,@EXIMFILECODECLF
           ,@SPECODE2
           ,@SERVREASONDEF)


		   
FETCH NEXT FROM processesDetail
INTO   @LOGICALREF,@CLIENTREF,@CLACCREF,@CLCENTERREF,@CASHCENTERREF,@CASHACCOUNTREF,@VIRMANREF,@SOURCEFREF,@DATE_,@DEPARTMENT,@BRANCH,@MODULENR,@TRCODE,@LINENR,@SPECODE
,@CYPHCODE,@TRANNO,@DOCODE,@LINEEXP,@ACCOUNTED,@SIGN,@AMOUNT,@TRCURR,@TRRATE,@TRNET,@REPORTRATE,@REPORTNET,@EXTENREF,@PAYDEFREF,@ACCFICHEREF,@PRINTCNT,@CAPIBLOCK_CREATEDBY,@CAPIBLOCK_CREADEDDATE
,@CAPIBLOCK_CREATEDHOUR,@CAPIBLOCK_CREATEDMIN,@CAPIBLOCK_CREATEDSEC,@CAPIBLOCK_MODIFIEDBY,@CAPIBLOCK_MODIFIEDDATE,@CAPIBLOCK_MODIFIEDHOUR,@CAPIBLOCK_MODIFIEDMIN,@CAPIBLOCK_MODIFIEDSEC
,@CANCELLED,@TRGFLAG,@TRADINGGRP,@LINEEXCTYP,@ONLYONEPAYLINE,@DISCFLAG,@DISCRATE,@VATRATE,@CASHAMOUNT,@DISCACCREF,@DISCCENREF,@VATRACCREF,@VATRCENREF,@PAYMENTREF,@VATAMOUNT
,@SITEID,@RECSTATUS,@ORGLOGICREF,@INFIDX,@POSCOMMACCREF,@POSCOMMCENREF,@POINTCOMMACCREF,@POINTCOMMCENREF,@CHEQINFO,@CREDITCNO,@CLPRJREF,@STATUS,@EXIMFILEREF,@EXIMPROCNR,@MONTH_,@YEAR_
,@FUNDSHARERAT,@AFFECTCOLLATRL,@GRPFIRMTRANS,@REFLVATACCREF,@REFLVATOTHACCREF,@AFFECTRISK,@BATCHNR,@APPROVENR,@BATCHNUM,@APPROVENUM,@EUVATSTATUS,@ORGLOGOID,@EXIMTYPE,@EIDISTFLNNR,@EISRVDSTTYP,@EXIMDISTTYP
,@SALESMANREF,@BANKACCREF,@BNACCREF,@BNCENTERREF,@DEVIRPROCDATE,@DOCDATE,@INSTALREF,@DEVIR,@DEVIRMODULENR,@FTIME
END

CLOSE processesDetail
DEALLOCATE processesDetail
END


GO


