-- exec SP_DenemeSuresiYaklasanlarMailGonder


ALTER PROCEDURE SP_DenemeSuresiYaklasanlarMailGonder
AS
BEGIN
    -- Deneme Süresi (2 Ay)
    DECLARE @Deneme TABLE (
        Adi NVARCHAR(50), 
        Soyadi NVARCHAR(50), 
        GirisTarihi DATE, 
        TcKimlikNo NVARCHAR(11),
        GecenSure NVARCHAR(50) -- Yeni kolon: Gecen Sure
    );
    INSERT INTO @Deneme
 SELECT 
    Adi, 
    Soyadi, 
    GirisTarihi, 
    TcKimlikNo,
   dbo.fnYilAyGun (GirisTarihi,GETDATE()) AS GecenSure
FROM Personel
WHERE GirisTarihi BETWEEN DATEADD(DAY, -60, GETDATE()) AND DATEADD(DAY, -35, GETDATE());

    -- Ýhbar Süresi (6 Ay)
    DECLARE @Ihbar TABLE (
        Adi NVARCHAR(50), 
        Soyadi NVARCHAR(50), 
        GirisTarihi DATE, 
        TcKimlikNo NVARCHAR(11),
        GecenSure NVARCHAR(50) -- Yeni kolon: Gecen Sure
    );
    INSERT INTO @Ihbar
    SELECT 
        Adi, 
        Soyadi, 
        GirisTarihi, 
        TcKimlikNo,
      dbo.fnYilAyGun (GirisTarihi,GETDATE()) AS GecenSure
    FROM Personel
    WHERE GirisTarihi BETWEEN DATEADD(DAY, -170, GETDATE()) AND DATEADD(DAY, -150, GETDATE());

    -- Kýdem Süresi (1 Yýl)
    DECLARE @Kidem TABLE (
        Adi NVARCHAR(50), 
        Soyadi NVARCHAR(50), 
        GirisTarihi DATE, 
        TcKimlikNo NVARCHAR(11),
        GecenSure NVARCHAR(50) -- Yeni kolon: Gecen Sure
    );
    INSERT INTO @Kidem
    SELECT 
        Adi, 
        Soyadi, 
        GirisTarihi, 
        TcKimlikNo,
      dbo.fnYilAyGun (GirisTarihi,GETDATE()) AS GecenSure
    FROM Personel
    WHERE GirisTarihi BETWEEN DATEADD(DAY, -355, GETDATE()) AND DATEADD(DAY, -325, GETDATE());

    -- HTML Ýçeriði Hazýrlama
    DECLARE @HtmlBody NVARCHAR(MAX);
    SET @HtmlBody = 
        '<h2>Deneme Süresi (2 Ay)</h2>' +
        '<table border="1"><tr><th>Adý</th><th>Soyadý</th><th>Giriþ Tarihi</th><th>TC Kimlik No</th><th>Geçen Süre</th></tr>';

    -- Deneme Süresi Ýçin HTML Satýrlarý
    DECLARE @Adi NVARCHAR(50), @Soyadi NVARCHAR(50), @GirisTarihi DATE, @TcKimlikNo NVARCHAR(11), @GecenSure NVARCHAR(50);
    DECLARE deneme_cursor CURSOR FOR SELECT Adi, Soyadi, GirisTarihi, TcKimlikNo, GecenSure FROM @Deneme;
    OPEN deneme_cursor;
    FETCH NEXT FROM deneme_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @HtmlBody = @HtmlBody + 
            '<tr><td>' + @Adi + '</td><td>' + @Soyadi + '</td><td>' + CONVERT(NVARCHAR(10), @GirisTarihi, 103) + 
            '</td><td>' + @TcKimlikNo + '</td><td>' + @GecenSure + '</td></tr>';
        FETCH NEXT FROM deneme_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    END;
    CLOSE deneme_cursor;
    DEALLOCATE deneme_cursor;

    -- Ýhbar Süresi Ýçin HTML Satýrlarý
    SET @HtmlBody = @HtmlBody + '</table><h2>Ýhbar Süresi (6 Ay)</h2><table border="1"><tr><th>Adý</th><th>Soyadý</th><th>Giriþ Tarihi</th><th>TC Kimlik No</th><th>Geçen Süre</th></tr>';
    DECLARE ihbar_cursor CURSOR FOR SELECT Adi, Soyadi, GirisTarihi, TcKimlikNo, GecenSure FROM @Ihbar;
    OPEN ihbar_cursor;
    FETCH NEXT FROM ihbar_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @HtmlBody = @HtmlBody + 
            '<tr><td>' + @Adi + '</td><td>' + @Soyadi + '</td><td>' + CONVERT(NVARCHAR(10), @GirisTarihi, 103) + 
            '</td><td>' + @TcKimlikNo + '</td><td>' + @GecenSure + '</td></tr>';
        FETCH NEXT FROM ihbar_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    END;
    CLOSE ihbar_cursor;
    DEALLOCATE ihbar_cursor;

    -- Kýdem Süresi Ýçin HTML Satýrlarý
    SET @HtmlBody = @HtmlBody + '</table><h2>Kýdem (1 Yýl)</h2><table border="1"><tr><th>Adý</th><th>Soyadý</th><th>Giriþ Tarihi</th><th>TC Kimlik No</th><th>Geçen Süre</th></tr>';
    DECLARE kidem_cursor CURSOR FOR SELECT Adi, Soyadi, GirisTarihi, TcKimlikNo, GecenSure FROM @Kidem;
    OPEN kidem_cursor;
    FETCH NEXT FROM kidem_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @HtmlBody = @HtmlBody + 
            '<tr><td>' + @Adi + '</td><td>' + @Soyadi + '</td><td>' + CONVERT(NVARCHAR(10), @GirisTarihi, 103) + 
            '</td><td>' + @TcKimlikNo + '</td><td>' + @GecenSure + '</td></tr>';
        FETCH NEXT FROM kidem_cursor INTO @Adi, @Soyadi, @GirisTarihi, @TcKimlikNo, @GecenSure;
    END;
    CLOSE kidem_cursor;
    DEALLOCATE kidem_cursor;

    -- HTML Kapanýþý
    SET @HtmlBody = @HtmlBody + '</table>';

    -- Mail Gönderme
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'fercam mail service',
		@recipients  = 'ik@fercam.com.tr',
 		@copy_recipients = 'rasit.hosgor@fercam.com.tr; ayasiryenigelenler@fercam.com.tr; uretim@fercam.com.tr',
        @blind_copy_recipients = 'serkan@serkansonmez.com',
        @importance = 'NORMAL',
        @subject = 'IK: Deneme, Kýdem, Ýhbar Süresi yaklaþanlar',
        @body_format= 'HTML',
        @body = @HtmlBody;

END;
