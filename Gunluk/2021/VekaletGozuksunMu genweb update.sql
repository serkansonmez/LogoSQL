select VekaletGozuksunMu,* from UcretPersonel where Adi like 'serhat%' and Soyadi = 'karataþ'


select * from  UcretPersonel where Id =7568

--update UcretPersonel set VekaletGozuksunMu  = '1' where Id =1819

SELECT  Adi + ' ' + Soyadi AS AdiSoyadi, TcKimlikNo FROM UcretPersonel where VekaletGozuksunMu = '1'

SELECT * FROM TIGER2_DB.DBO.L_CAPIFIRM WHERE   NAME LIKE 'SAD%'