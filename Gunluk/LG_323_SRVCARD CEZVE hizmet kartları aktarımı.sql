 
 insert into  CEZVE..LG_323_SRVCARD
SELECT [LG_424_SRVCARD].[ACTIVE]
      ,[LG_424_SRVCARD].[CARDTYPE]
      ,[LG_424_SRVCARD].[CODE]
      ,[LG_424_SRVCARD].[DEFINITION_]
      ,[LG_424_SRVCARD].[SPECODE]
      ,[LG_424_SRVCARD].[CYPHCODE]
      ,[LG_424_SRVCARD].[VAT]
      ,[LG_424_SRVCARD].[EXTENREF]
      ,[LG_424_SRVCARD].[PAYMENTREF]
      ,[LG_424_SRVCARD].[UNITSETREF]
      ,[LG_424_SRVCARD].[CAPIBLOCK_CREATEDBY]
      ,[LG_424_SRVCARD].[CAPIBLOCK_CREADEDDATE]
      ,[LG_424_SRVCARD].[CAPIBLOCK_CREATEDHOUR]
      ,[LG_424_SRVCARD].[CAPIBLOCK_CREATEDMIN]
      ,[LG_424_SRVCARD].[CAPIBLOCK_CREATEDSEC]
      ,[LG_424_SRVCARD].[CAPIBLOCK_MODIFIEDBY]
      ,[LG_424_SRVCARD].[CAPIBLOCK_MODIFIEDDATE]
      ,[LG_424_SRVCARD].[CAPIBLOCK_MODIFIEDHOUR]
      ,[LG_424_SRVCARD].[CAPIBLOCK_MODIFIEDMIN]
      ,[LG_424_SRVCARD].[CAPIBLOCK_MODIFIEDSEC]
      ,[LG_424_SRVCARD].[SITEID]
      ,[LG_424_SRVCARD].[RECSTATUS]
      ,[LG_424_SRVCARD].[ORGLOGICREF]
      ,[LG_424_SRVCARD].[WFSTATUS]
      ,[LG_424_SRVCARD].[RETURNVAT]
      ,[LG_424_SRVCARD].[IMPORTEXPNS]
      ,[LG_424_SRVCARD].[AFFECTCOST]
      ,[LG_424_SRVCARD].[ADDTAXREF]
      ,[LG_424_SRVCARD].[DISTTYPE]
      ,[LG_424_SRVCARD].[EXTACCESSFLAGS]
      ,[LG_424_SRVCARD].[USEDINPERIODS]
      ,[LG_424_SRVCARD].[CANDEDUCT]
      ,[LG_424_SRVCARD].[DEDUCTIONPART1]
      ,[LG_424_SRVCARD].[DEDUCTIONPART2]
       
  FROM GO3DB. [dbo].[LG_424_SRVCARD]

LEFT JOIN CEZVE..LG_323_SRVCARD ON LG_323_SRVCARD.CODE = LG_424_SRVCARD.CODE 
WHERE LG_323_SRVCARD.CODE is null

--SELECT * INTO LG_323_SRVCARD_20240119 FROM LG_323_SRVCARD

 