USE [ArgelasB2B_Default_v1]
GO

SELECT [LOGICALREF]
      ,[Stok Kodu]
      ,[Stok Ad�]
      ,[Marka]
      ,[Ebat]
      ,[T�r]
      ,[Desen]
      ,[Dot]
      ,[LastikEtiketi]
      ,[Mevsim]
      ,[Depo Miktar�]
      ,[Birim Fiyat]
      ,[Envanter Tutar�]
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




--select Marka + ' ' + Desen + ' ' +  REPLACE(replace(Mevsim,'DORTMEVSIM','M+S 4 MEVS�M'),'KIS','KI�') + ' LAST�K' as YeniAlanAdi, * from [EmyEticaret]


