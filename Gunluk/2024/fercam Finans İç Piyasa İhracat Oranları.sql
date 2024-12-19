   
   DECLARE @RaporSablonlariId INT
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @Kod1 NVARCHAR(50)
    DECLARE @Kod1Aciklama NVARCHAR(50)
    DECLARE @Kod2 NVARCHAR(50)
    DECLARE @Kod2Aciklama NVARCHAR(50)
    DECLARE @Kod3 NVARCHAR(50)
    DECLARE @Kod3Aciklama NVARCHAR(50)
	truncate table TempResults
    DECLARE cur CURSOR FOR
    SELECT RaporSablonlariId, Kod1, Kod1Aciklama, Kod2, Kod2Aciklama, Kod3, Kod3Aciklama, SqlKodu
    FROM RaporSablonlari where Kod1= '01' and (Kod2='01' or Kod2 = '02')

    OPEN cur
    FETCH NEXT FROM cur INTO @RaporSablonlariId, @Kod1, @Kod1Aciklama, @Kod2, @Kod2Aciklama, @Kod3, @Kod3Aciklama, @SQL

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Dinamik SQL'i geçici tabloya ekle
        SET @SQL = '
            INSERT INTO TempResults (M2, CARITUR, FISNO, TARIH, DOVIZTUTAR, AY, YIL, TRRATE, SOURCEINDEX, DISCPER, VAT, OUTPUTIDCODE, AMOUNT, TOTAL, LINENET, CARIKODU,CARIADI,MALZEMEKODU,MALZEMEADI,MASRAFMERKEZIKODU,MASRAFMERKEZIADI,BIRIMFIYAT, Kod1, Kod1Aciklama, Kod2, Kod2Aciklama, Kod3, Kod3Aciklama)
            SELECT M2, CARITUR, FISNO, TARIH, DOVIZTUTAR, AY, YIL, TRRATE, SOURCEINDEX, DISCPER, VAT, OUTPUTIDCODE, AMOUNT, TOTAL, LINENET,CARIKODU,CARIADI,MALZEMEKODU,MALZEMEADI,MASRAFMERKEZIKODU,MASRAFMERKEZIADI,BIRIMFIYAT,
                   ''' + @Kod1 + ''', ''' + @Kod1Aciklama + ''', ''' + @Kod2 + ''', ''' + @Kod2Aciklama + ''', ''' + @Kod3 + ''', ''' + @Kod3Aciklama + '''
            FROM (' + @SQL + ') AS subquery'

        EXEC sp_executesql @SQL

        FETCH NEXT FROM cur INTO @RaporSablonlariId, @Kod1, @Kod1Aciklama, @Kod2, @Kod2Aciklama, @Kod3, @Kod3Aciklama, @SQL
    END

    CLOSE cur
    DEALLOCATE cur
	DECLARE @ToplamTutar FLOAT

-- Toplam tutarý hesapla
SELECT @ToplamTutar = SUM(LINENET) FROM TempResults

-- Her satýrýn toplam tutar içindeki yüzdesini hesapla ve sonucu göster

create view VW_FinansIcPiyasaIhracatOran as
SELECT ROW_NUMBER() over (Order By Kod2Aciklama ) as Id,
 Kod2Aciklama as Tur, 
    SUM(LINENET) AS Toplam, 
   
   round( (SUM(LINENET) / (SELECT   SUM(LINENET) FROM TempResults) ) * 100,2) AS YuzdeOrani
FROM TempResults
GROUP BY Kod2Aciklama
	 



	 