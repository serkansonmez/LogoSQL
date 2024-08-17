USE [ArgelasB2B_Default_v1]
GO

SELECT [LOGICALREF]
      ,[Stok Kodu]
      ,[Stok Adý]
      ,[Marka]
      ,[Ebat]
      ,[Tür]
      ,[Desen]
      ,[Dot]
      ,[LastikEtiketi]
      ,[Mevsim]
      ,[Depo Miktarý]
      ,[Birim Fiyat]
      ,[Envanter Tutarý]
      ,[UretimKodu]
      ,[DepoMiktariStr]
      ,[UreticiKodu]
      ,[PesinFiyat]
      ,[VadeliFiyat]
      ,[ParekendeFiyat]
      ,[Jant]
      ,[KdvDahilListeFiyati]
      ,[ETicaretBazFiyati]
      ,[Desi]
      ,[KargoFiyati]
      ,[TrendyolKomisyonOrani]
      ,[HesaplananTrendyolFiyati]
      ,[TrendyolKomisyonu]
      ,[TrendyolFiyatiManuel]
      ,[ManuelSatisFiyati]
      ,[MARKREF]
  FROM [dbo].[EmyEticaret]




--select Marka + ' ' + Desen + ' ' +  REPLACE(replace(Mevsim,'DORTMEVSIM','M+S 4 MEVSÝM'),'KIS','KIÞ') + ' LASTÝK' as YeniAlanAdi, * from [EmyEticaret]


