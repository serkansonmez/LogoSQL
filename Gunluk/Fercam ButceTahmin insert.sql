select GELIRGIDER, MUSTERITURU from VW_PERFORMANSTOPLAM_24 group by MUSTERITURU,GELIRGIDER

declare @Ay int = 12
declare @Yil int = 2024 
insert into ButceTahmin
SELECT 
     GELIRGIDER AS  [GelirGider]
      ,MUSTERITURU AS [GelirGiderAlt1]
      ,@Yil [Yil]
      ,@Ay [Ay]
      ,0 [M2]
      ,0 [Toplam]
      ,0 [DovizToplam]
      ,0 [OrtalamaFiyat]
  from (select GELIRGIDER, MUSTERITURU from VW_PERFORMANSTOPLAM_24 group by MUSTERITURU,GELIRGIDER)
tblListe 
left join ButceTahmin on ButceTahmin.Ay = @Ay and Yil = @Yil and ButceTahmin.GelirGider = GELIRGIDER AND 
MUSTERITURU = ButceTahmin.GelirGiderAlt1
WHERE ButceTahmin.ID is null

--select*  from ButceTahmin where Yil = 2023