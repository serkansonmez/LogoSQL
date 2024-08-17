--select WFLOWCRDREF, * from LG_324_01_ORFICHE   where FICHENO = '015204'
 
WITH tblVade AS ( 
    SELECT FORMAT(CAST(DUEDATE AS DATE)  , 'dd.MM.yyyy') AS FormattedDate, Q1.LOGICALREF
    FROM LG_324_01_ORFLINE Q1
    WHERE LOGICALREF IN (
        SELECT TOP 1 LOGICALREF
        FROM LG_324_01_ORFLINE Q2
        WHERE Q1.ORDFICHEREF = Q2.ORDFICHEREF
        ORDER BY DUEDATE DESC 
    )
)
--SELECT FormattedDate FROM tblVade group by FormattedDate;
--2. aþama iþ akýþlarýna insert edilmesi
INSERT INTO LG_324_WORKFLOWCARD
SELECT tblVade2.FormattedDate [CODE]
      ,tblVade2.FormattedDate [NAME]
      ,mastertbl.[SPECODE]
      ,mastertbl.[CYPHCODE]
      ,mastertbl.[WORKPLACE]
      ,mastertbl.[ACTIONTYPE]
      ,mastertbl.[ACTIVE]
      ,mastertbl.[PRIORITY]
      ,mastertbl.[WFUSERNR]
      ,mastertbl.[WFROLEREF]
      ,mastertbl.[CONDITION]
      ,mastertbl.[BEGDATE]
      ,mastertbl.[ENDDATE]
      ,mastertbl.[CAPIBLOCK_CREATEDBY]
      ,mastertbl.[CAPIBLOCK_CREADEDDATE]
      ,mastertbl.[CAPIBLOCK_CREATEDHOUR]
      ,mastertbl.[CAPIBLOCK_CREATEDMIN]
      ,mastertbl.[CAPIBLOCK_CREATEDSEC]
      ,mastertbl.[CAPIBLOCK_MODIFIEDBY]
      ,mastertbl.[CAPIBLOCK_MODIFIEDDATE]
      ,mastertbl.[CAPIBLOCK_MODIFIEDHOUR]
      ,mastertbl.[CAPIBLOCK_MODIFIEDMIN]
      ,mastertbl.[CAPIBLOCK_MODIFIEDSEC]
      ,mastertbl.[SITEID]
      ,mastertbl.[RECSTATUS]
      ,mastertbl.[ORGLOGICREF]
      ,mastertbl.[TEXTINC]
      ,mastertbl.[WFSTATUS]
      ,mastertbl.[NEXTWFREF]
      ,mastertbl.[STATUSGRPA]
      ,mastertbl.[STATUSGRPB]
      ,mastertbl.[STATUSGRPC]
      ,mastertbl.[STATUSGRPD]
      ,mastertbl.[STATUSGRPE]
      ,mastertbl.[STATUSGRPF]
  FROM (SELECT FormattedDate FROM tblVade group by FormattedDate) tblVade2 
  left join [dbo].[LG_324_WORKFLOWCARD]   on [LG_324_WORKFLOWCARD].CODE = tblVade2.FormattedDate 
  left join [dbo].[LG_324_WORKFLOWCARD] mastertbl   on mastertbl.LOGICALREF = 4
  where [LG_324_WORKFLOWCARD].LOGICALREF is null ;


SELECT FORMAT(CAST(DUEDATE AS DATE)  , 'dd.MM.yyyy') AS FormattedDate, Q1.ORDFICHEREF
,LG_324_WORKFLOWCARD.LOGICALREF AS LG_324_WORKFLOWCARD_LOGICALREF
,'UPDATE LG_324_01_ORFICHE SET WFLOWCRDREF=' + CAST(LG_324_WORKFLOWCARD.LOGICALREF AS VARCHAR(20)) + ' WHERE LOGICALREF='
+ CAST(LG_324_01_ORFICHE.LOGICALREF AS VARCHAR(20))
    FROM LG_324_01_ORFLINE Q1
	left JOIN LG_324_01_ORFICHE ON LG_324_01_ORFICHE.LOGICALREF = Q1.ORDFICHEREF
	left JOIN LG_324_WORKFLOWCARD ON LG_324_WORKFLOWCARD.CODE = FORMAT(CAST(DUEDATE AS DATE)  , 'dd.MM.yyyy') 
    WHERE Q1.LOGICALREF IN (
        SELECT TOP 1 LOGICALREF
        FROM LG_324_01_ORFLINE Q2
        WHERE Q1.ORDFICHEREF = Q2.ORDFICHEREF
        ORDER BY DUEDATE DESC )

  --WHERE [LG_324_WORKFLOWCARD].LOGICALREF = 4


--UPDATE LG_324_01_ORFICHE SET WFLOWCRDREF= 4 WHERE LOGICALREF = 2181