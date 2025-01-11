-- xp_cmdshell'i etkinleþtirme (Eðer kapalýysa)
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- Yedekleme klasörünü tanýmla
DECLARE @BackupPath NVARCHAR(MAX) = 'C:\DatabaseBackups\';

-- Yedekleme klasöründeki dosyalarý sil
DECLARE @DeleteCommand VARCHAR(MAX);
SET @DeleteCommand = CAST('IF EXIST "' + @BackupPath + '*" DEL /Q "' + @BackupPath + '*"' AS VARCHAR(MAX));
EXEC xp_cmdshell @DeleteCommand;

-- Tüm veritabanlarýnýn yedeðini al
DECLARE @DatabaseName NVARCHAR(MAX);
DECLARE @BackupFileName NVARCHAR(MAX);
DECLARE @BackupCommand NVARCHAR(MAX);

DECLARE DatabaseCursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') -- Sistem veritabanlarýný hariç tut

OPEN DatabaseCursor;

FETCH NEXT FROM DatabaseCursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Yedek dosya adýný oluþtur
    SET @BackupFileName = @BackupPath + @DatabaseName + '_DB_' + FORMAT(GETDATE(), 'yyyyMMdd') + '.bak';
    
    -- Yedekleme komutunu oluþtur
    SET @BackupCommand = 'BACKUP DATABASE [' + @DatabaseName + '] TO DISK = ''' + @BackupFileName + ''' WITH INIT, COMPRESSION';
    
    -- Yedekleme komutunu çalýþtýr
    EXEC sp_executesql @BackupCommand;
    
    FETCH NEXT FROM DatabaseCursor INTO @DatabaseName;
END;

CLOSE DatabaseCursor;
DEALLOCATE DatabaseCursor;

-- xp_cmdshell'i devre dýþý býrakma (Opsiyonel)
-- EXEC sp_configure 'xp_cmdshell', 0;
-- RECONFIGURE;
