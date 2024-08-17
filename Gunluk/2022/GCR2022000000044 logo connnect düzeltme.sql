SELECT
 tab.name AS  TableName , SUM(pa.rows)  AS  TableRows
FROM
sys.tables tab
INNER JOIN sys.partitions pa
ON pa.object_id = tab.object_id
INNER JOIN sys.schemas sch
ON tab.schema_id = sch.schema_id
WHERE tab.name like '%614%' and
tab.is_ms_shipped = 0 AND pa.index_id IN (1,0)
GROUP BY  sch.name,tab.name
 
ORDER BY  sch.name +'.'+ tab.name

--   select * from  dbo.LG_614_APPROVAL where (docnr like '%044' or docnr like '%045') and LOGICALREF IN (2963,
2967)


--eski
UPDATE LG_614_APPROVAL SET RESPONSESTATUS = 1 WHERE  LOGICALREF = 2963
--Yeni
UPDATE LG_614_APPROVAL SET RESPONSESTATUS = 0 WHERE  LOGICALREF = 2963