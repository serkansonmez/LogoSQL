select CAPIBLOCK_MODIFIEDDATE,ServisRecete.UpdatedAt,  
 SUBSTRING(ServisRecete.CODE, 1 , CHARINDEX('[', ServisRecete.CODE) -1), 
* from ServisRecete  
 LEFT JOIN LG_022_BOMASTER ON LG_022_BOMASTER.CODE = SUBSTRING(ServisRecete.CODE, 1 , CHARINDEX('[', ServisRecete.CODE) -1)
 WHERE  CHARINDEX('[', ServisRecete.CODE) >1 AND CAPIBLOCK_MODIFIEDDATE>ServisRecete.UpdatedAt


 select * from ServisRecete  where code like '09 028%'


--SELECT * FROM LG_022_BOMASTER WHERE CAPIBLOCK_MODIFIEDDATE
create Procedure SP_ReceteGuncellenenleriSil as 
begin
-- 1- recete servis güncellenenler siliniyor.
delete from ServisRecete where Id in (
select ServisRecete.Id from ServisRecete  
 LEFT JOIN LG_022_BOMASTER ON LG_022_BOMASTER.CODE = SUBSTRING(ServisRecete.CODE, 1 , CHARINDEX('[', ServisRecete.CODE) -1)
 WHERE  CHARINDEX('[', ServisRecete.CODE) >1 AND CAPIBLOCK_MODIFIEDDATE>ServisRecete.UpdatedAt )

 end