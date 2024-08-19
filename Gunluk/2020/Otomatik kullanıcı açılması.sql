select Adi,Soyadi,TckimlikNo, 
dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Adi))) + '.' +  
dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Soyadi))) 

from UcretPersonel



select * from Kullanicilar where kodu like 