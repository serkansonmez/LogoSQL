select 'ENA' as TigerFirma,code,DEFINITION_ from lg_122_clcard where  SECTORMAINREF=1
UNION ALL
select 'acar' as TigerFirma,code,DEFINITION_ from lg_402_clcard where  SECTORMAINREF=1
UNION ALL
select 'Miya' as TigerFirma,code,DEFINITION_ from lg_052_clcard where  SECTORMAINREF=1
UNION ALL
select 'mac' as TigerFirma,code,DEFINITION_ from lg_092_clcard where  SECTORMAINREF=1
UNION ALL
select 'happysoul' as TigerFirma,code,DEFINITION_ from lg_319_clcard where  SECTORMAINREF=1


--UPDATE lg_122_clcard SET SECTORMAINREF=1   where  code = '320.010.E053'