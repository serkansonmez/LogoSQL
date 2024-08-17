 
 insert into  GO3DB..LG_424_SRVCARD
SELECT [LG_324_SRVCARD].[ACTIVE]
      ,[LG_324_SRVCARD].[CARDTYPE]
      ,[LG_324_SRVCARD].[CODE]
      ,[LG_324_SRVCARD].[DEFINITION_]
      ,[LG_324_SRVCARD].[SPECODE]
      ,[LG_324_SRVCARD].[CYPHCODE]
      ,[LG_324_SRVCARD].[VAT]
      ,[LG_324_SRVCARD].[EXTENREF]
      ,[LG_324_SRVCARD].[PAYMENTREF]
      ,[LG_324_SRVCARD].[UNITSETREF]
      ,[LG_324_SRVCARD].[CAPIBLOCK_CREATEDBY]
      ,[LG_324_SRVCARD].[CAPIBLOCK_CREADEDDATE]
      ,[LG_324_SRVCARD].[CAPIBLOCK_CREATEDHOUR]
      ,[LG_324_SRVCARD].[CAPIBLOCK_CREATEDMIN]
      ,[LG_324_SRVCARD].[CAPIBLOCK_CREATEDSEC]
      ,[LG_324_SRVCARD].[CAPIBLOCK_MODIFIEDBY]
      ,[LG_324_SRVCARD].[CAPIBLOCK_MODIFIEDDATE]
      ,[LG_324_SRVCARD].[CAPIBLOCK_MODIFIEDHOUR]
      ,[LG_324_SRVCARD].[CAPIBLOCK_MODIFIEDMIN]
      ,[LG_324_SRVCARD].[CAPIBLOCK_MODIFIEDSEC]
      ,[LG_324_SRVCARD].[SITEID]
      ,[LG_324_SRVCARD].[RECSTATUS]
      ,[LG_324_SRVCARD].[ORGLOGICREF]
      ,[LG_324_SRVCARD].[WFSTATUS]
      ,[LG_324_SRVCARD].[RETURNVAT]
      ,[LG_324_SRVCARD].[IMPORTEXPNS]
      ,[LG_324_SRVCARD].[AFFECTCOST]
      ,[LG_324_SRVCARD].[ADDTAXREF]
      ,[LG_324_SRVCARD].[DISTTYPE]
      ,[LG_324_SRVCARD].[EXTACCESSFLAGS]
      ,[LG_324_SRVCARD].[USEDINPERIODS]
      ,[LG_324_SRVCARD].[CANDEDUCT]
      ,[LG_324_SRVCARD].[DEDUCTIONPART1]
      ,[LG_324_SRVCARD].[DEDUCTIONPART2]


	  ,0 [EXEMPTFROMTAXDECL]
      ,0 [CURRDIFF]
      ,0 [DEDUCTCODE]
      ,0 [PROJECTREF]
      ,0 [DEFINITION2]
      ,0 [PARENTSRVREF]
      ,0 [LOWLEVELCODES1]
      ,0 [LOWLEVELCODES2]
      ,0 [LOWLEVELCODES3]
      ,0 [LOWLEVELCODES4]
      ,0 [LOWLEVELCODES5]
      ,0 [LOWLEVELCODES6]
      ,0 [LOWLEVELCODES7]
      ,0 [LOWLEVELCODES8]
      ,0 [LOWLEVELCODES9]
      ,0 [LOWLEVELCODES10]
      ,'' [SPECODE2]
      ,''  [SPECODE3]
      ,'' [SPECODE4]
      ,'' [SPECODE5]
      ,0 [MULTIADDTAX]
      ,0 [GTIPCODE]
      ,0 [CPACODE]
      ,0 [PUBLICCOUNTRYREF]
      ,0 [OPPOSESRVREF]
      ,0 [VEHICLEEXP]
      ,0 [VEHICLERENT]
      ,0 [TEXTINC]
      ,0 [TEXTINCENG]
       
  FROM CEZVE. [dbo].[LG_324_SRVCARD]

LEFT JOIN GO3DB..LG_424_SRVCARD ON LG_424_SRVCARD.CODE = LG_324_SRVCARD.CODE 
WHERE LG_424_SRVCARD.CODE is null


-- SELECT *   FROM GO3DB..LG_424_SRVCARD WHERE CODE LIKE '152.01%'
-- SELECT *   FROM cezve..LG_324_SRVCARD WHERE CODE LIKE '152.01%'