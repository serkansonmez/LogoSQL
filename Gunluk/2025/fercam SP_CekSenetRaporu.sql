USE [TIGER]
GO

/****** Object:  View [dbo].[VW_CekSenetRaporu_25]    Script Date: 21.01.20' + @Yil + ' 13:45:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--select sum(Tutar) from VW_CekSenetRaporu_25 where Durum = 'Kendi �ekimiz' 


 -- exec [SP_CekSenetRaporu] '20250121'

alter PROCEDURE [dbo].[SP_CekSenetRaporu]
    @Tarih DATETIME
AS
BEGIN
    SET NOCOUNT ON;
     SET @Tarih = DATEFROMPARTS(YEAR(@Tarih), 12, 31);
    -- View ad�n� dinamik olarak olu�tur
    DECLARE @Yil NVARCHAR(4) = CAST(YEAR(@Tarih) - 2000 AS NVARCHAR(4));
    DECLARE @ViewName NVARCHAR(50) = 'VW_BorcYaslandirmaListesi_' + @Yil;

	 -- Dinamik sorguyu olu�tur ve �al��t�r
    DECLARE @SQL  NVARCHAR(MAX), @SQL1  NVARCHAR(4000),@SQL2  NVARCHAR(4000),@SQL3  NVARCHAR(4000);
 
    SET @SQL1 = '

WITH CEKLISTE AS  
(  SELECT  CSCARD.LOGICAlREF AS Referans,  DOC,  case WHEN DOC IN(1,2) THEN ''M��teri'' else ''Kendi'' end as [BelgeTuru],   
CASE WHEN DOC=1 THEN ''�ek'' WHEN DOC=2 THEN ''Senet'' WHEN DOC=3 THEN ''Kendi �ekimiz'' WHEN DOC=4 THEN ''Bor� Senedimiz'' ELSE ''Tan�ms�z'' END AS Tip, 
CASE WHEN DOC=1 AND CURRSTAT=1 THEN ''Portfoyde''      WHEN DOC=1 AND CURRSTAT=2 THEN ''Ciro Edildi''     
WHEN DOC=1 AND CURRSTAT=3 THEN ''Teminatta''      WHEN DOC=1 AND CURRSTAT=4 THEN ''Tahsile Verildi''      
WHEN DOC=1 AND CURRSTAT=6 THEN ''�ade Edildi''      WHEN DOC=1 AND CURRSTAT=8 THEN ''Tahsil Edildi''      
WHEN DOC=1 AND CURRSTAT=11 THEN ''Kar��l�ks�z''      WHEN DOC=2 AND CURRSTAT=1 THEN ''Portfoyde''     
WHEN DOC=2 AND CURRSTAT=2 THEN ''Ciro Edildi''     WHEN DOC=2 AND CURRSTAT=5 THEN ''Tahsilde''     
WHEN DOC=2 AND CURRSTAT=3 THEN ''Teminatta''      WHEN DOC=2 AND CURRSTAT=4 THEN ''Tahsile Verildi''      
WHEN DOC=2 AND CURRSTAT=6 THEN ''�ade Edildi''      WHEN DOC=2 AND CURRSTAT=7 THEN ''Kar��l�ks�z''     
WHEN DOC=2 AND CURRSTAT=8 THEN ''Tahsil Edildi''     WHEN DOC=3 AND CURRSTAT=6 THEN ''�ade Edildi''      
WHEN DOC=3 AND CURRSTAT=8 THEN ''Tahsil Edildi''      WHEN DOC=3 AND CURRSTAT=9 THEN ''Kendi �ekimiz''      
WHEN DOC=4 AND CURRSTAT=10 THEN ''Bor� Senedimiz''      WHEN CURRSTAT =99 THEN ''Hen�z Giriliyor''   
ELSE ''Tan�ms�z'' END AS [SonDurum],   
Durumu=(SELECT TOP 1 STATUS FROM  LG_0' + @Yil + '_01_CSTRANS WITH (NOLOCK) WHERE CSREF=CSCARD.LOGICALREF  AND DATE_<= @Tarih 
ORDER BY  LOGICALREF DESC),   Durum_Tan�m=(SELECT DEFINITION_ FROM LG_0' + @Yil + '_BANKACC WITH (NOLOCK) 
WHERE LOGICALREF IN (SELECT TOP 1 CARDREF FROM  LG_0' + @Yil + '_01_CSTRANS WHERE CSREF=CSCARD.LOGICALREF  AND DATE_<= @Tarih ORDER BY  LOGICALREF DESC)),  [TCVergiNo]=CSCARD.TAXNR,   PORTFOYNO AS PortfoyNo,   NEWSERINO AS SeriNo,   OWING AS Borclu,  
(SELECT TOP 1 CLCARD.DEFINITION_      FROM  LG_0' + @Yil + '_01_CSTRANS CSTRANS, LG_0' + @Yil + '_CLCARD CLCARD   

WHERE CSTRANS.CARDREF = CLCARD.LOGICALREF  AND CSTRANS.CSREF = CSCARD.LOGICALREF     
ORDER BY CSTRANS.LOGICALREF DESC) AS [Ciro Eden Ke�ideci],    MUHABIR AS [Muhabir],   
CSCARD.CITY AS [Sehir],   YEAR (DUEDATE) AS [VadeYil],   CASE MONTH(DUEDATE) WHEN 1 THEN ''01.OCAK'' 
WHEN 2 THEN ''02.SUBAT'' WHEN 3 THEN ''03.MART'' WHEN 4 THEN ''04.NISAN'' WHEN 5 THEN ''05.MAYIS'' 
WHEN 6 THEN ''06.HAZIRAN'' WHEN 7 THEN ''07.TEMMUZ''  WHEN 8 THEN ''08.AGUSTOS'' WHEN 9 THEN ''09.EYLUL'' 
WHEN 10 THEN ''10.EKIM'' WHEN 11 THEN ''11.KASIM'' WHEN 12 THEN ''12.ARALIK'' ELSE '''' END AS [VadeAy],   
DUEDATE AS [Vade],   SETDATE AS [GirisTarihi],   YEAR (SETDATE) AS [GirisYil],   
CASE MONTH(SETDATE) WHEN 1 THEN ''01.OCAK'' WHEN 2 THEN ''02.SUBAT'' WHEN 3 THEN ''03.MART''
WHEN 4 THEN ''04.NISAN'' WHEN 5 THEN ''05.MAYIS'' WHEN 6 THEN ''06.HAZIRAN'' WHEN 7 THEN ''07.TEMMUZ''  
WHEN 8 THEN ''08.AGUSTOS'' WHEN 9 THEN ''09.EYLUL'' WHEN 10 THEN ''10.EKIM'' WHEN 11 THEN ''11.KASIM''
WHEN 12 THEN ''12.ARALIK'' ELSE '''' END AS [GirisAyi],   '
SET @SQL2 = '
CASE WHEN DOC IN(1,2) THEN (CASE WHEN TRCURR IN (0,160) THEN AMOUNT ELSE TRNET END) ELSE (CASE WHEN TRCURR IN (0,160) THEN AMOUNT ELSE TRNET END)*-1 END  AS [Tutar],   CASE WHEN TRCURR = 0 THEN ''TL''      ELSE (Select CURCODE  FROM L_CURRENCYLIST WHERE CURTYPE = CSCARD.TRCURR AND FIRMNR = 0' + @Yil + ') END AS Doviz,   
[CekBankaAdi]=CSCARD.BANKNAME,    IBAN=CSCARD.IBAN,    [CekBankaHesapNo]=cscard.BNACCOUNTNO,    [CekBankaSubeKodu]=CSCARD.BNBRANCHNO    ,LG_SLSMAN.DEFINITION_ AS SatisElemani  FROM  LG_0' + @Yil + '_01_CSCARD CSCARD WITH(NOLOCK)   LEFT JOIN LG_SLSMAN ON LG_SLSMAN.LOGICALREF = CSCARD.SALESMANREF AND LG_SLSMAN.FIRMNR = 0' + @Yil + '  )  
SELECT   Referans,   Durum= CASE       WHEN DOC=1 AND Durumu=1 THEN ''Portfoyde''      
WHEN DOC=1 AND Durumu=2 THEN ''Ciro Edildi''    
WHEN DOC=1 AND Durumu=3 THEN ''Teminatta''      
WHEN DOC=1 AND Durumu=4 THEN ''Tahsile Verildi''      
WHEN DOC=1 AND Durumu=6 THEN ''�ade Edildi''      
WHEN DOC=1 AND Durumu=8 THEN ''Tahsil Edildi''      
WHEN DOC=1 AND Durumu=11 THEN ''Kar��l�ks�z''      
WHEN DOC=2 AND Durumu=1 THEN ''Portfoyde'' '
SET @SQL3 = '
WHEN DOC=2 AND Durumu=2 THEN ''Ciro Edildi''     
WHEN DOC=2 AND Durumu=5 THEN ''Tahsilde''     
WHEN DOC=2 AND Durumu=3 THEN ''Teminatta''      
WHEN DOC=2 AND Durumu=4 THEN ''Tahsile Verildi''      
WHEN DOC=2 AND Durumu=6 THEN ''�ade Edildi''      
WHEN DOC=2 AND Durumu=7 THEN ''Kar��l�ks�z''     
WHEN DOC=2 AND Durumu=8 THEN ''Tahsil Edildi''     
WHEN DOC=3 AND Durumu=6 THEN ''�ade Edildi''      WHEN DOC=3 AND Durumu=8 THEN ''Tahsil Edildi''      
WHEN DOC=3 AND Durumu=9 THEN ''Kendi �ekimiz''      WHEN DOC=4 AND Durumu=10 THEN ''Bor� Senedimiz''      
WHEN Durumu =99 THEN ''Hen�z Giriliyor'' END,     [BelgeTuru],Tip,[SonDurum],PortfoyNo,SeriNo,  
CASE WHEN DOC=3 THEN [CekBankaAdi] ELSE Borclu END AS Borclu,  [CiroEdenKesideci]=CASE       
WHEN DOC=1 AND Durumu=1 THEN [Ciro Eden Ke�ideci]     WHEN DOC=1 AND Durumu=2 THEN [Ciro Eden Ke�ideci]     
WHEN DOC=1 AND Durumu=3 THEN Durum_Tan�m     WHEN DOC=1 AND Durumu=4 THEN Durum_Tan�m     
WHEN DOC=1 AND Durumu=6 THEN [Ciro Eden Ke�ideci]      WHEN DOC=1 AND Durumu=8 THEN [Ciro Eden Ke�ideci]      
WHEN DOC=1 AND Durumu=11 THEN [Ciro Eden Ke�ideci]       WHEN DOC=2 AND Durumu=1 THEN [Ciro Eden Ke�ideci]     
WHEN DOC=2 AND Durumu=2 THEN [Ciro Eden Ke�ideci]     WHEN DOC=2 AND Durumu=5 THEN Durum_Tan�m     
WHEN DOC=2 AND Durumu=3 THEN Durum_Tan�m      WHEN DOC=2 AND Durumu=4 THEN Durum_Tan�m      
WHEN DOC=2 AND Durumu=6 THEN [Ciro Eden Ke�ideci]     WHEN DOC=2 AND Durumu=7 THEN [Ciro Eden Ke�ideci]      
WHEN DOC=2 AND Durumu=8 THEN [Ciro Eden Ke�ideci]     WHEN DOC=3 AND Durumu=6 THEN [Ciro Eden Ke�ideci]      
WHEN DOC=3 AND Durumu=8 THEN [Ciro Eden Ke�ideci]      WHEN DOC=3 AND Durumu=9 THEN [Ciro Eden Ke�ideci]     
WHEN DOC=4 AND Durumu=10 THEN [Ciro Eden Ke�ideci]      WHEN Durumu =99 THEN [Ciro Eden Ke�ideci] END,  [TcVergiNo],      
[CekBankaAdi],      IBAN,      [CekBankaHesapNo],      [CekBankaSubeKodu],     Muhabir,Sehir,[VadeYil],[VadeAy],Vade,[GirisTarihi],
[GirisYil],[GirisAyi],Tutar,Doviz,SatisElemani  
FROM CEKLISTE WHERE ISNULL(Durumu,0) > 0 and Vade<=@Tarih
 '
 BEGIN TRY
      SET @sql = CAST(@sql1 AS NVARCHAR(MAX)) + CAST(@sql2 AS NVARCHAR(MAX)) + CAST(@sql3 AS NVARCHAR(MAX))
	  PRINT @SQL3
	  PRINT @SQL
        EXEC sp_executesql @SQL, N'@Tarih DATETIME', @Tarih;
    END TRY
    BEGIN CATCH
        -- Hata durumunda bir mesaj d�nd�r
        PRINT 'Hata olu�tu: ' + ERROR_MESSAGE();
    END CATCH

END