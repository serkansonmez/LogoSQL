USE [GO3DB]
GO

INSERT INTO [LG_424_SRVUNITA]
SELECT  

        [LG_424_SRVCARD].LOGICALREF AS  [SRVREF]
      ,1 [LINENR]
      ,29 [UNITLINEREF]
      ,0 [PRIORITY]
  FROM  [LG_424_SRVCARD]
  LEFT JOIN  [LG_424_SRVUNITA]  ON [LG_424_SRVUNITA].SRVREF = [LG_424_SRVCARD].LOGICALREF

WHERE [LG_424_SRVUNITA].SRVREF IS NULL


