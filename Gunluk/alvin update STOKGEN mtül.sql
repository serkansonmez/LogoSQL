select * from STOKGEN where stk like '%10118%3110'

update  STOKGEN set stb = 'MT�L' where ((stk like '150.01%') or (stk like '150.02%') or (stk like '150.03%') or   (stk like '150.05%') )     
--and STB <> 'MT�L'

--select * into STOKGEN_20231130 from STOKGEN