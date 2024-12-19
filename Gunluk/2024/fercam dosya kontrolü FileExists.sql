SELECT name
FROM sys.assemblies;

 SELECT dbo.FileExists('C:\Temp\a.txt1');
 
SELECT  dbo.FileExists('D:\LOGO\UYGULAMALAR\FercamProd\FileCheckSql.dll');

CREATE FUNCTION dbo.FileExists(@filePath NVARCHAR(MAX))
RETURNS BIT
AS EXTERNAL NAME FileCheck.[FileCheck].FileExists;

sp_configure 'clr strict security', 0;
RECONFIGURE;


SELECT dbo.FileExists('D:\LOGO\UYGULAMALAR\FercamProd\FileCheckSql.dll') AS FileExistenceTest;