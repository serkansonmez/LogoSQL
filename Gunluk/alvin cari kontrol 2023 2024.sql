select * from 
from �REN_PVC_2023T..CARIGEN TBL23
--CROSS JOIN AlvinB2B_Default_v1..  [VW_IREN_ASAS_2024_dbstok]
--   WHERE tbl23.stk = '150.06.10279.1454'
left JOIN   �REN_PVC_2024T..CARIGEN TBL24 ON TBL23.CRK = TBL24.CRK
WHERE TBL24.CRK IS NULL