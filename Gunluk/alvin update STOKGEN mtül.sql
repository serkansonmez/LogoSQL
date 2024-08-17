select * from STOKGEN where stk like '%10118%3110'

update  STOKGEN set stb = 'MTÜL' where ((stk like '150.01%') or (stk like '150.02%') or (stk like '150.03%') or   (stk like '150.05%') )     
--and STB <> 'MTÜL'

--select * into STOKGEN_20231130 from STOKGEN