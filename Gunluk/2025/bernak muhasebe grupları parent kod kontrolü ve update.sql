 select * FROM [Ginsoft_web].[dbo].[MuhasebeGruplari]  WHERE FirmalarId= 4 and HesapKodu like   '7%0.68%'

 update [Ginsoft_web].[dbo].[MuhasebeGruplari]  set 
 GrupKodu = '760 - OPERASYON G�DERLER�',
 GrupKodu2 = '760.07 - D��ER S�GORTA G�DERLER�',
 HesapKodu = '760.68.01'
 where Id = 34046