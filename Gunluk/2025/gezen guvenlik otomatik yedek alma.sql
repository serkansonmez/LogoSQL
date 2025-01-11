-- xp_cmdshell'i etkinle�tirme (E�er kapal�ysa)
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- Yedekleme klas�r�n� tan�mla
DECLARE @BackupPath NVARCHAR(MAX) = 'C:\DatabaseBackups\';

-- Yedekleme klas�r�ndeki dosyalar� sil
DECLARE @DeleteCommand VARCHAR(MAX);
SET @DeleteCommand = CAST('IF EXIST "' + @BackupPath + '*" DEL /Q "' + @BackupPath + '*"' AS VARCHAR(MAX));
EXEC xp_cmdshell @DeleteCommand;

-- T�m veritabanlar�n�n yede�ini al
DECLARE @DatabaseName NVARCHAR(MAX);
DECLARE @BackupFileName NVARCHAR(MAX);
DECLARE @BackupCommand NVARCHAR(MAX);

DECLARE DatabaseCursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') -- Sistem veritabanlar�n� hari� tut

OPEN DatabaseCursor;

FETCH NEXT FROM DatabaseCursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Yedek dosya ad�n� olu�tur
    SET @BackupFileName = @BackupPath + @DatabaseName + '_DB_' + FORMAT(GETDATE(), 'yyyyMMdd') + '.bak';
    
    -- Yedekleme komutunu olu�tur
    SET @BackupCommand = 'BACKUP DATABASE [' + @DatabaseName + '] TO DISK = ''' + @BackupFileName + ''' WITH INIT, COMPRESSION';
    
    -- Yedekleme komutunu �al��t�r
    EXEC sp_executesql @BackupCommand;
    
    FETCH NEXT FROM DatabaseCursor INTO @DatabaseName;
END;

CLOSE DatabaseCursor;
DEALLOCATE DatabaseCursor;

-- xp_cmdshell'i devre d��� b�rakma (Opsiyonel)
-- EXEC sp_configure 'xp_cmdshell', 0;
-- RECONFIGURE;
