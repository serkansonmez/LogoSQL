USE [TIGER]
GO
--SELECT * INTO LG_025_PEGGING_20250310 FROM LG_025_PEGGING
 DECLARE @PEGTYPE  smallint = 1
DECLARE @PEGREF   smallint
DECLARE @RELTYPE  smallint = 2
DECLARE @PRODORDREF  int  =0
DECLARE @SUBCONTREF  int  =0
DECLARE @PORDFICHEREF  int
DECLARE @PORDLINEREF  int
DECLARE @ITEMREF  int
DECLARE @AMOUNT  float
DECLARE @UOMREF  int  =0
DECLARE @CANCHANGE  smallint = 0
DECLARE @DISPLINEREF  int = 0
DECLARE @PRODLINEREF  int = 0
DECLARE @OTHERPEGREF  int = 0
DECLARE @PERIODNR  int = 1
DECLARE @MRPPROPREF  int = 0
DECLARE @PDEMFICHEREF  int = 0
DECLARE @PDEMLINEREF  int = 0
DECLARE @VARIANTREF  int
DECLARE @FICHETYPE  smallint = 0
DECLARE @PRODORDTYP  smallint = 0
DECLARE @VARIANTSAYI INT 
DECLARE @URETIMSAYI INT 

-- CURSOR TANIMLA
DECLARE ProdCursor CURSOR FOR 
SELECT LG_025_PRODORD.LOGICALREF, LG_025_PRODORD.ITEMREF, LG_025_PRODORD.PLNAMOUNT  --,LG_025_PRODORD.FICHENO,LG_025_PRODORD.*
FROM TIGER..LG_025_PRODORD 
LEFT JOIN TIGER..LG_025_PEGGING ON LG_025_PEGGING.PEGREF = LG_025_PRODORD.LOGICALREF
WHERE LG_025_PEGGING.LOGICALREF IS NULL 
AND FICHENO LIKE '2501.0007%'  
--ORDER BY LG_025_PRODORD.LOGICALREF DESC

-- CURSOR AÇ
OPEN ProdCursor
FETCH NEXT FROM ProdCursor INTO @PEGREF, @ITEMREF, @URETIMSAYI

WHILE @@FETCH_STATUS = 0
BEGIN
    -- VARIANT SAYISINI BUL
    SELECT @VARIANTSAYI  = COUNT(LOGICALREF) 
    FROM TIGER..LG_025_VARIANT 
    WHERE RECSTATUS=1 and ITEMREF = @ITEMREF
	--SELECT *   FROM TIGER..LG_025_VARIANT     WHERE ITEMREF = 2262

    -- EÐER VARIANTSAYI = 1 ÝSE ÝÞLEM YAP
    IF (@VARIANTSAYI = 1)
    BEGIN 
        SELECT @VARIANTREF = LOGICALREF 
        FROM TIGER..LG_025_VARIANT 
        WHERE ITEMREF = @ITEMREF

        SELECT @AMOUNT = AMOUNT, 
               @PORDLINEREF = LOGICALREF, 
               @PORDFICHEREF = ORDFICHEREF 
        FROM TIGER..LG_025_01_ORFLINE 
        WHERE STOCKREF = @ITEMREF 
        AND VARIANTREF = @VARIANTREF  

        -- SONUÇLARI GÖSTER
        PRINT 'ÝÞLENEN KAYIT: ' + CAST(@PEGREF AS NVARCHAR)
		
INSERT INTO [dbo].[LG_025_PEGGING]
           ([PEGTYPE]
           ,[PEGREF]
           ,[RELTYPE]
           ,[PRODORDREF]
           ,[SUBCONTREF]
           ,[PORDFICHEREF]
           ,[PORDLINEREF]
           ,[ITEMREF]
           ,[AMOUNT]
           ,[UOMREF]
           ,[CANCHANGE]
           ,[DISPLINEREF]
           ,[PRODLINEREF]
           ,[OTHERPEGREF]
           ,[PERIODNR]
           ,[MRPPROPREF]
           ,[PDEMFICHEREF]
           ,[PDEMLINEREF]
           ,[VARIANTREF]
           ,[FICHETYPE]
           ,[PRODORDTYP])
     VALUES
           (@PEGTYPE,  
            @PEGREF,  
            @RELTYPE,  
            @PRODORDREF, 
            @SUBCONTREF, 
            @PORDFICHEREF, 
            @PORDLINEREF,  
            @ITEMREF, 
            @AMOUNT,  
            @UOMREF,  
            @CANCHANGE,  
            @DISPLINEREF,  
            @PRODLINEREF, 
            @OTHERPEGREF,  
            @PERIODNR,  
            @MRPPROPREF,  
            @PDEMFICHEREF,  
            @PDEMLINEREF,  
            @VARIANTREF,  
            @FICHETYPE,  
            @PRODORDTYP)

        --SELECT @URETIMSAYI,
        --       @PEGTYPE,  
        --       @PEGREF,  
        --       @RELTYPE,  
        --       @PRODORDREF, 
        --       @SUBCONTREF, 
        --       @PORDFICHEREF, 
        --       @PORDLINEREF,  
        --       @ITEMREF, 
        --       @AMOUNT,  
        --       @UOMREF,  
        --       @CANCHANGE,  
        --       @DISPLINEREF,  
        --       @PRODLINEREF, 
        --       @OTHERPEGREF,  
        --       @PERIODNR,  
        --       @MRPPROPREF,  
        --       @PDEMFICHEREF,  
        --       @PDEMLINEREF,  
        --       @VARIANTREF,  
        --       @FICHETYPE,  
        --       @PRODORDTYP
    END

    -- BÝR SONRAKÝ KAYDI AL
    FETCH NEXT FROM ProdCursor INTO @PEGREF, @ITEMREF, @URETIMSAYI
END

-- CURSOR KAPAT VE TEMÝZLE
CLOSE ProdCursor
DEALLOCATE ProdCursor

/*

INSERT INTO [dbo].[LG_025_PEGGING]
           ([PEGTYPE]
           ,[PEGREF]
           ,[RELTYPE]
           ,[PRODORDREF]
           ,[SUBCONTREF]
           ,[PORDFICHEREF]
           ,[PORDLINEREF]
           ,[ITEMREF]
           ,[AMOUNT]
           ,[UOMREF]
           ,[CANCHANGE]
           ,[DISPLINEREF]
           ,[PRODLINEREF]
           ,[OTHERPEGREF]
           ,[PERIODNR]
           ,[MRPPROPREF]
           ,[PDEMFICHEREF]
           ,[PDEMLINEREF]
           ,[VARIANTREF]
           ,[FICHETYPE]
           ,[PRODORDTYP])
     VALUES
           (@PEGTYPE,  
            @PEGREF,  
            @RELTYPE,  
            @PRODORDREF, 
            @SUBCONTREF, 
            @PORDFICHEREF, 
            @PORDLINEREF,  
            @ITEMREF, 
            @AMOUNT,  
            @UOMREF,  
            @CANCHANGE,  
            @DISPLINEREF,  
            @PRODLINEREF, 
            @OTHERPEGREF,  
            @PERIODNR,  
            @MRPPROPREF,  
            @PDEMFICHEREF,  
            @PDEMLINEREF,  
            @VARIANTREF,  
            @FICHETYPE,  
            @PRODORDTYP)
GO

*/
