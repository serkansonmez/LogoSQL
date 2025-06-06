USE [TIGER3_STEEL]
GO
/****** Object:  Trigger [dbo].[LG_STLINE_INS_120_01]    Script Date: 19.03.2021 16:38:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[LG_STLINE_INS_120_01] ON [dbo].[LG_120_01_STLINE]
FOR INSERT
AS
DECLARE @c_lService         SMALLINT
DECLARE @c_SubContract      SMALLINT
DECLARE @c_PStatPlanned     SMALLINT
DECLARE @c_PStatRealized    SMALLINT
DECLARE @c_TrWarehouse      SMALLINT
DECLARE @c_TrWorkStation    SMALLINT
DECLARE @c_RepairOn         SMALLINT
DECLARE @c_RepairOff        SMALLINT
DECLARE @repairTotals       SMALLINT
DECLARE @new_logicalRef     INT
DECLARE @new_ItemRef        INT
DECLARE @new_VariantRef     INT
DECLARE @new_TransDate      DATETIME
DECLARE @new_Month          SMALLINT
DECLARE @new_Year           SMALLINT
DECLARE @new_TrCode         SMALLINT
DECLARE @new_CancFlag       SMALLINT
DECLARE @new_LineType       SMALLINT
DECLARE @new_BilledFlag     SMALLINT
DECLARE @new_DecPrDiff      SMALLINT
DECLARE @new_LProdStat      SMALLINT
DECLARE @new_SourceType     SMALLINT
DECLARE @new_SourceIndex    SMALLINT
DECLARE @new_DestType       SMALLINT
DECLARE @new_DestIndex      SMALLINT
DECLARE @new_SourceWSRef    INT
DECLARE @new_DestWSRef      INT
DECLARE @new_Amount         FLOAT
DECLARE @new_Price          FLOAT
DECLARE @new_PrPrice        FLOAT
DECLARE @new_Unit1CFact     FLOAT
DECLARE @new_Unit2CFact     FLOAT
DECLARE @new_VatPer         FLOAT
DECLARE @new_LineNet        FLOAT
DECLARE @new_DistCost       FLOAT
DECLARE @new_DistAddExp     FLOAT
DECLARE @new_DiffPrice      FLOAT
DECLARE @new_DiffRepPrice   FLOAT
DECLARE @new_ReportRate     FLOAT
DECLARE @new_TrRate         FLOAT
DECLARE @new_VatIncFlag     SMALLINT
DECLARE @new_InvoiceRef     INT
DECLARE @new_OrdTransRef    INT
DECLARE @new_DistOrdLineRef INT
DECLARE @new_StFicheRef     INT
DECLARE @new_IOCode         SMALLINT
DECLARE @new_RlsAmount      FLOAT
DECLARE @new_POrdClsPlnAmnt FLOAT
DECLARE @new_Status         SMALLINT
DECLARE @new_PrevRef        INT
DECLARE @new_UOMRef         INT
DECLARE @new_OffTrRef       INT
DECLARE @new_OffRef         INT
DECLARE @new_sourceLink     INT
DECLARE @dummy              INT
DECLARE @new_doReserve      SMALLINT
DECLARE @c_LExpense         SMALLINT
DECLARE @c_LDiscount        SMALLINT
SELECT @c_lService      = 4,
       @c_SubContract   = 11,
       @c_PStatPlanned  = 1,
       @c_PStatRealized = 0,
       @c_RepairOn      = 1,
       @c_RepairOff     = 0,
       @c_TrWarehouse   = 0,
       @c_TrWorkStation = 1,
       @c_LExpense      = 3,
       @c_LDiscount     = 2
SET @repairTotals = @c_RepairOff
SELECT @new_logicalRef = I.LOGICALREF,
       @new_ItemRef = I.STOCKREF,
       @new_VariantRef = I.VARIANTREF,
       @new_TransDate = I.DATE_,
       @new_Month = I.MONTH_,
       @new_Year  = I.YEAR_,
       @new_TrCode = I.TRCODE,
       @new_CancFlag = I.CANCELLED,
       @new_LineType = I.LINETYPE,
       @new_BilledFlag = I.BILLED,
       @new_DecPrDiff = I.DECPRDIFF,
       @new_LProdStat = I.LPRODSTAT,
       @new_SourceType = I.SOURCETYPE,
       @new_SourceIndex = I.SOURCEINDEX,
       @new_DestType = I.DESTTYPE,
       @new_DestIndex = I.DESTINDEX,
       @new_SourceWSRef = I.SOURCEWSREF,
       @new_DestWSRef = I.DESTWSREF,
       @new_Amount = I.AMOUNT,
       @new_Price = I.PRICE,
       @new_Unit1CFact = I.UINFO1,
       @new_Unit2CFact = I.UINFO2,
       @new_VatPer = I.VAT,
       @new_LineNet = I.LINENET,
       @new_DistCost = I.DISTCOST,
       @new_DistAddExp = I.DISTADDEXP,
       @new_DiffPrice = I.DIFFPRICE,
       @new_DiffRepPrice = I.DIFFREPPRICE,
       @new_ReportRate = I.REPORTRATE,
       @new_VatIncFlag = I.VATINC,
       @new_InvoiceRef = I.INVOICEREF,
       @new_OrdTransRef = I.ORDTRANSREF,
       @new_DistOrdLineRef = I.DISTORDLINEREF,
       @new_StFicheRef = I.STFICHEREF,
       @new_IOCode = I.IOCODE,
       @new_RlsAmount = I.PLNAMOUNT,
       @new_POrdClsPlnAmnt = I.PORDCLSPLNAMNT,
       @new_Status = I.STATUS,
       @new_PrevRef   = I.PREVLINEREF,
       @new_doReserve = I.DORESERVE,
       @new_UOMRef    = I.UOMREF,
       @new_OffTrRef    = I.OFFTRANSREF,
       @new_OffRef      = I.OFFERREF,
    @new_sourceLink  = I.SOURCELINK
FROM INSERTED I
IF (@new_CancFlag = 0 AND @new_OrdTransRef <> 0) AND (@new_LineType <> @c_lExpense) AND (@new_LineType <> @c_LDiscount)
 EXECUTE LG_UPDSHIPPEDAMOUNT_120_01 @new_logicalRef, @new_OrdTransRef, @new_sourceLink,
                                    @new_Amount, @new_transDate, @new_Unit1CFact, @new_Unit2CFact, 1
IF ((@new_LineType = @c_lService) OR (@new_LineType = @c_SubContract))
    EXECUTE LG_UPDATESRVFORTRANS_120_01 @new_ItemRef, @new_TransDate,
                                        @new_TrCode, @new_CancFlag,
                                        @new_SourceIndex, @new_VatIncFlag,
                                        @new_OrdTransRef,
                                        @new_Unit1CFact, @new_Unit2CFact,
                                        @new_VatPer, @new_DistCost,
                                        @new_DistAddExp, @new_Price,
                                        @new_ReportRate, @new_Amount,
                                        1, @new_Status,
                                        @new_Month, @new_Year, @new_OffTrRef, @new_OffRef, @new_BilledFlag
ELSE
    EXECUTE LG_STKHANDLENUMBERS_120_01 @new_ItemRef, @new_VariantRef, @new_TransDate,
                                       @new_TrCode, 1, @new_CancFlag,
                                       @new_LineType, @new_BilledFlag,
                                       @new_DecPrDiff, @new_LProdStat,
                                       @new_SourceType, @new_DestType,
                                       @new_SourceWSRef, @new_DestWSRef,
                                       @new_SourceIndex, @new_DestIndex,
                                       @new_Amount, @new_Price,
                                       @new_Unit1CFact, @new_Unit2CFact,
                                       @new_VatPer, @new_DistCost,
                                       @new_DistAddExp, @new_DiffPrice,
                                       @new_DiffRepPrice, @new_ReportRate,
                                       @new_VatIncFlag, @new_InvoiceRef,
                                       @new_OrdTransRef, @new_DistOrdLineRef,
                                       @new_StFicheRef, @new_IOCode,
                                       @new_RlsAmount, @new_POrdClsPlnAmnt,
                                       @new_Status, @new_doReserve,
                                       @new_Month, @new_Year, @new_UOMRef, @new_OffTrRef, @new_OffRef
EXECUTE LG_UPDATEMRPITMCHNG_120 @new_ItemRef, @new_VariantRef, @new_PrevRef

-- buradan itibaren eklenecek
if (@new_logicalRef>0 AND (@new_TrCode =1  or @new_TrCode=3)   ) --satınalma fatura-irsaliye
begin
     DECLARE @varmi int = 0
	 select @varmi = count(*) from  LG_120_PRCLIST   WHERE CARDREF = @new_ItemRef
	 if (@varmi>0)
	 begin
	   -- tüm kartlar update ediliyor.
	      update LG_120_PRCLIST set PRICE = @new_Price * 1.00 WHERE CARDREF = @new_ItemRef
	 end
	 else 
	 begin

	  INSERT INTO  [LG_120_PRCLIST]  
SELECT  @new_ItemRef AS [CARDREF]
      ,'' [CLIENTCODE]
      ,[CLSPECODE]
      ,[PAYPLANREF]
      ,@new_Price * 1.00 AS  [PRICE]
      ,[UOMREF]
      ,[INCVAT]
      ,[CURRENCY]
      ,[PRIORITY]
      ,[PTYPE]
      ,[MTRLTYPE]
      ,[LEADTIME]
      ,'20210101' AS [BEGDATE]
      ,'20310101' AS [ENDDATE]
      ,[CONDITION]
      ,[SHIPTYP]
      ,[SPECIALIZED]
      ,[CAPIBLOCK_CREATEDBY]
      , GETDATE() AS [CAPIBLOCK_CREADEDDATE]
      ,DATEPART(HOUR,GETDATE())     [CAPIBLOCK_CREATEDHOUR]
      ,DATEPART(MINUTE,GETDATE()) [CAPIBLOCK_CREATEDMIN]
      ,DATEPART(SECOND,GETDATE()) [CAPIBLOCK_CREATEDSEC]
      ,GETDATE()  as [CAPIBLOCK_MODIFIEDBY]
      ,DATEPART(HOUR,GETDATE()) [CAPIBLOCK_MODIFIEDDATE]
      ,DATEPART(HOUR,GETDATE())  [CAPIBLOCK_MODIFIEDHOUR]
      ,DATEPART(MINUTE,GETDATE())  [CAPIBLOCK_MODIFIEDMIN]
      ,DATEPART(SECOND,GETDATE()) [CAPIBLOCK_MODIFIEDSEC]
      ,[SITEID]
      ,[RECSTATUS]
      ,[ORGLOGICREF]
      ,[WFSTATUS]
      ,[UNITCONVERT]
      ,[EXTACCESSFLAGS]
      ,[CYPHCODE]
      ,[ORGLOGOID]
      ,[TRADINGGRP]
      ,[BEGTIME]
      ,[ENDTIME]
      ,[DEFINITION_]
      ,[CODE]
      ,[GRPCODE]
      ,[ORDERNR]
      ,[GENIUSPAYTYPE]
      ,[GENIUSSHPNR]
      ,[PRCALTERTYP1]
      ,[PRCALTERLMT1]
      ,[PRCALTERTYP2]
      ,[PRCALTERLMT2]
      ,[PRCALTERTYP3]
      ,[PRCALTERLMT3]
      ,[ACTIVE]
      ,[PURCHCONTREF]
      ,[BRANCH]
      ,[COSTVAL]
      ,[CLTRADINGGRP]
      ,[CLCYPHCODE]
      ,[CLSPECODE2]
      ,[CLSPECODE3]
      ,[CLSPECODE4]
      ,[CLSPECODE5]
      ,[GLOBALID]
      ,[VARIANTCODE]
      ,[WFLOWCRDREF]
      ,NEWID ( )   as [GUID]
      ,[PROJECTREF]
      ,[MARKREF]
      ,[TRSPECODE]
  FROM [dbo].[LG_120_PRCLIST] where LOGICALREF = 2

	 end
	   
end