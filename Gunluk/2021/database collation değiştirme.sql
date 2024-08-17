-- Set to single-user mode
ALTER DATABASE krcb2b_Default_v1
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

USE master;
GO
ALTER DATABASE krcb2b_Default_v1
COLLATE Turkish_CI_AS ;
GO
 
--bakalým olmusmu
SELECT name, collation_name
FROM sys.databases
WHERE name = N'krcb2b_Default_v1';
GO


-- Set to multi-user mode
ALTER DATABASE krcb2b_Default_v1
SET MULTI_USER WITH ROLLBACK IMMEDIATE;
GO 