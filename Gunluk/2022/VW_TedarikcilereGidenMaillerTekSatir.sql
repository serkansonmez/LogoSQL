USE [EnaFlow_DB]
GO

/****** Object:  View [dbo].[VW_TedarikcilereGidenMaillerTekSatir]    Script Date: 6.04.2022 09:33:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER view [dbo].[VW_TedarikcilereGidenMaillerTekSatir] as 
SELECT Main.OnayTalepleriId,
      isnull( LEFT(Main.Siparisler,Len(Main.Siparisler)-1),'') As kime
FROM
    (
        SELECT DISTINCT ST2.OnayTalepleriId, 
            (
                SELECT ST1.kime + ',' AS [text()]
                FROM VW_TedarikcilereGidenMailler ST1
                WHERE ST1.OnayTalepleriId = ST2.OnayTalepleriId and   ST2.kime is not null
                ORDER BY ST1.OnayTalepleriId
                FOR XML PATH ('')
            ) Siparisler
        FROM dbo.VW_TedarikcilereGidenMailler ST2 
    ) [Main]  where OnayTalepleriId is not null


	--select * from VW_TedarikcilereGidenMailler
GO


