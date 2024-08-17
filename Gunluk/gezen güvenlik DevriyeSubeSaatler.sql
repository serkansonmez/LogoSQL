USE [GezenWeb_Default_v1]
GO

SELECT [DevriyeSaatlerId]
      ,[DevriyeSaatler].[Saat]
      ,[DevriyeSaatler].[DevriyeAktif]
	  ,'update DevriyeSubeSaatler set DevriyeAktif=' + cast( [DevriyeSaatler].DevriyeAktif as varchar(20)) + ' where DevriyeSubeSaatlerId=' + cast(DevriyeSubeSaatler.DevriyeSubeSaatlerId as varchar(20))
  FROM [dbo].[DevriyeSaatler]

left join DevriyeSubeSaatler on DevriyeSubeSaatler.Saat = [DevriyeSaatler].Saat


