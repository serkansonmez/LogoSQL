-- exec SP_DenemeSuresiYaklasanlarMailGonder


ALTER PROCEDURE SP_DenemeSuresiYaklasanlarMailGonder
AS
BEGIN
    -- Deneme S�resi (2 Ay)
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

    -- �hbar S�resi (6 Ay)
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

    -- K�dem S�resi (1 Y�l)
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

    -- HTML ��eri�i Haz�rlama
    DECLARE @HtmlBody NVARCHAR(MAX);
    SET @HtmlBody = 
        '<h2>Deneme S�resi (2 Ay)</h2>' +
        '<table border="1"><tr><th>Ad�</th><th>Soyad�</th><th>Giri� Tarihi</th><th>TC Kimlik No</th><th>Ge�en S�re</th></tr>';

    -- Deneme S�resi ��in HTML Sat�rlar�
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

    -- �hbar S�resi ��in HTML Sat�rlar�
    SET @HtmlBody = @HtmlBody + '</table><h2>�hbar S�resi (6 Ay)</h2><table border="1"><tr><th>Ad�</th><th>Soyad�</th><th>Giri� Tarihi</th><th>TC Kimlik No</th><th>Ge�en S�re</th></tr>';
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

    -- K�dem S�resi ��in HTML Sat�rlar�
    SET @HtmlBody = @HtmlBody + '</table><h2>K�dem (1 Y�l)</h2><table border="1"><tr><th>Ad�</th><th>Soyad�</th><th>Giri� Tarihi</th><th>TC Kimlik No</th><th>Ge�en S�re</th></tr>';
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

    -- HTML Kapan���
    SET @HtmlBody = @HtmlBody + '</table>';

    -- Mail G�nderme
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'fercam mail service',
		@recipients  = 'ik@fercam.com.tr',
 		@copy_recipients = 'rasit.hosgor@fercam.com.tr; ayasiryenigelenler@fercam.com.tr; uretim@fercam.com.tr',
        @blind_copy_recipients = 'serkan@serkansonmez.com',
        @importance = 'NORMAL',
        @subject = 'IK: Deneme, K�dem, �hbar S�resi yakla�anlar',
        @body_format= 'HTML',
        @body = @HtmlBody;

END;
