

SELECT 
 
ROW_NUMBER() over (order by Grup ,Rota      ) as Id,
Grup + cast(Rota as varchar(20)) as RotaKodu,
isnull(temper,0) as Kesim,
isnull(F4,0) as Bando,
isnull(F5,0) as SuJeti,
isnull(F6,0) as Cnc,
isnull(F7,0) as Delik,
isnull(F8,0) as Serigraf,
isnull(F9,0) as Firin,
isnull(F10,'') as Resiztans,
isnull(F11,0) as Paketleme,
isnull(F13,0) as ProsesSayi,
isnull(F14,0) as UretimOrtalamaDk

into UretimRotaTanim 
from ExcelUretimTanim -- where rota is null

--select * from   ExcelUretimTanim 