USE [FercamB2B_Default_v1]
GO

SELECT  
       [MalzemeKodu]
      ,[UrunKodu] as MalzemeAdi
   from   [dbo].[VW_UretimPlanlama]
  WHERE dbo.GetNextOperation(MalzemeKodu,'Kesim')  is null and KesilenAdet>0
group by   [MalzemeKodu]
      ,[RotaKodu]
      ,[FirinRotaKodu]
      ,[UrunKodu]
    

	SELECT UrunRotaKodlariExcel.[�R�N ROTASI] ,UretimRotaBaglanti.RotaKodu ,
	'UPDATE UretimRotaBaglanti SET RotaKodu=''' + UrunRotaKodlariExcel.[�R�N ROTASI] + ''' where Id=' + cast(Id as varchar(20)) as StrSQL  , * from UretimRotaBaglanti
	left join UrunRotaKodlariExcel on UrunRotaKodlariExcel.REFERAnSLAR = FercamKodu 
	  WHERE UrunRotaKodlariExcel.[�R�N ROTASI] is not null and UretimRotaBaglanti.RotaKodu is null
	
	--select * from UrunRotaKodlariExcel where RotaKodu is not null