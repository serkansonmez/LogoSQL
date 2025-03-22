--   exec SP_UretimPlanlamaMailGonder
ALTER PROCEDURE SP_UretimPlanlamaMailGonder
AS
BEGIN
    DECLARE @Departman NVARCHAR(255),
            @StokKodu NVARCHAR(255),
            @StokAdi NVARCHAR(255),
            @EldekiMiktar INT,
            @BekleyenMiktar INT,
            @DepoKalan INT,
            @OncekiSatis INT,
            @MevcutSatis INT,
            @FarkAdet INT,
            @ArtisYuzde DECIMAL(10,2),
            @MailAdresi NVARCHAR(500),
            @MailKonusu NVARCHAR(255),
            @MailIcerik NVARCHAR(MAX)
    
    DECLARE @AyAdi NVARCHAR(20);
    SET @AyAdi =   
    CASE MONTH(GETDATE())
        WHEN 1 THEN 'OCAK'
        WHEN 2 THEN 'ÞUBAT'
        WHEN 3 THEN 'MART'
        WHEN 4 THEN 'NÝSAN'
        WHEN 5 THEN 'MAYIS'
        WHEN 6 THEN 'HAZÝRAN'
        WHEN 7 THEN 'TEMMUZ'
        WHEN 8 THEN 'AÐUSTOS'
        WHEN 9 THEN 'EYLÜL'
        WHEN 10 THEN 'EKÝM'
        WHEN 11 THEN 'KASIM'
        WHEN 12 THEN 'ARALIK'
    END;

    PRINT @AyAdi

    -- Mail konusu
    SET @MailKonusu = 'Üretim Planlama Stok Durumu'

    -- Mail içeriði baþlangýç
    SET @MailIcerik = 
    '<html>
    <body>
    <p>Sayýn Yetkili,</p>
    <p>Depo stok durumu aþaðýdaki gibidir:</p>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Departman</th>
            <th>Stok Kodu</th>
            <th>Stok Adý</th>
            <th>Eldeki Miktar</th>
            <th>Bekleyen Miktar</th>
            <th>Depo Kalan</th>
            <th>Önceki Satýþ</th>
            <th>Mevcut Satýþ</th>
            <th>Fark Adet</th>
            <th>Artýþ Yüzde</th>
        </tr>'

    -- Cursor Tanýmlama
    DECLARE UretimCursor CURSOR FOR
    SELECT 
        ISNULL(Departman, 'N/A'),
        ISNULL(StokKodu, 'N/A'),
        ISNULL(StokAdi, 'N/A'),
        ISNULL(EldekiMiktar, 0),
        ISNULL(BekleyenMiktar, 0),
        ISNULL(DepoKalan, 0),
        ISNULL(OncekiSatis, 0),
        ISNULL(MevcutSatis, 0),
        ISNULL(FarkAdet, 0),
        ISNULL(ArtisYuzde, 0.00)
    FROM VW_UretimPlanlama_25
    WHERE AyAdi = @AyAdi 
    AND DepoKalan < 0
    ORDER BY Departman, DepoKalan 

    OPEN UretimCursor
    FETCH NEXT FROM UretimCursor INTO 
        @Departman, @StokKodu, @StokAdi, @EldekiMiktar, @BekleyenMiktar, @DepoKalan,
        @OncekiSatis, @MevcutSatis, @FarkAdet, @ArtisYuzde

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Departman bazlý renkler
        DECLARE @RowColor NVARCHAR(10)
        IF @Departman = '2-Kahve'
            SET @RowColor = '#F4A460' -- Açýk Kahverengi
        ELSE IF @Departman = '3-Çay'
            SET @RowColor = '#98FB98' -- Açýk Yeþil
        ELSE IF @Departman = '1-Toz Ýçecek'
            SET @RowColor = '#ADD8E6' -- Açýk Mavi
        ELSE
            SET @RowColor = '#FFFFFF' -- Varsayýlan beyaz

        -- Mail içeriði
        SET @MailIcerik = @MailIcerik +
            ' <tr style="background-color:' + @RowColor + ';">
                <td>' + @Departman + '</td>
                <td>' + @StokKodu + '</td>
                <td>' + @StokAdi + '</td>
                <td style="text-align:right;">' + FORMAT(@EldekiMiktar, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@BekleyenMiktar, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@DepoKalan, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@OncekiSatis, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@MevcutSatis, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@FarkAdet, 'N0') + '</td>
                <td style="text-align:right;">' + FORMAT(@ArtisYuzde, 'N2') + '</td>
            </tr>'

        -- Sonraki satýrý getir
        FETCH NEXT FROM UretimCursor INTO 
            @Departman, @StokKodu, @StokAdi, @EldekiMiktar, @BekleyenMiktar, @DepoKalan,
            @OncekiSatis, @MevcutSatis, @FarkAdet, @ArtisYuzde
    END

    -- Cursor'u kapat ve temizle
    CLOSE UretimCursor
    DEALLOCATE UretimCursor

    -- Mail içeriðini bitir
    SET @MailIcerik = @MailIcerik + '  </table>
    <p>Bilginize.</p>
    </body>
    </html>'

    PRINT @MailIcerik

    -- Mail gönderme
    EXEC msdb.dbo.sp_send_dbmail 
        @profile_name = 'sql mail service',
		  @recipients = 'aerbey@altincezve.com.tr; osmanerbey@altincezve.com.tr; mahmuterbey@altincezve.com.tr',
        @blind_copy_recipients = 'serkansonmez16@hotmail.com',
        @subject = @MailKonusu,
        @body = @MailIcerik,
        @body_format = 'HTML'
END
