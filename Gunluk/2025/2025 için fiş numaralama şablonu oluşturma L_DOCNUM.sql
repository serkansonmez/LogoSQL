
decLARE @CARIREFERANS INT 
DECLARE @LOGICALREF INT
DECLARE @SONREFERANS INT
DECLARE @ESKIYILBASLANGIC DATETIME  = '20240101'
DECLARE @YENIYILBASLANGIC DATETIME  = '20250101'
DECLARE @YENIYILBITIS DATETIME  = '20251231'


DECLARE @KayitSayi INT


DECLARE processes CURSOR FOR

SELECT  LOGICALREF FROM [dbo].[L_LDOCNUM] WHERE EFFSDATE = @ESKIYILBASLANGIC AND FIRMID IN (6,7)

OPEN processes

FETCH NEXT FROM processes
INTO @LOGICALREF 
WHILE @@FETCH_STATUS = 0
BEGIN
--SELECT * INTO L_LDOCNUM_20250102 FROM L_LDOCNUM
      select @SONREFERANS= LASTLREF + 1 from [L_LDOCNUMSEQ] WHERE ID = 1
	  UPDATE [L_LDOCNUMSEQ] SET  LASTLREF = @SONREFERANS WHERE  ID = 1
	  INSERT INTO L_LDOCNUM
SELECT @SONREFERANS AS [LOGICALREF]
      ,[DOCIDEN]
      ,[APPMODULE]
      ,[FIRMID]
      ,[DIVISID]
      ,[WHID]
      ,[FACTID]
      ,[GROUPID]
      ,[ROLEID]
      ,[USERID]
      ,[FIRSTNUM]
      ,[LASTNUM]
      ,@YENIYILBASLANGIC AS  [EFFSDATE]
      ,@YENIYILBITIS AS [EFFEDATE]
      ,[NUMFORM]
      ,0 AS [LASTASGND]
      ,[OWNCODE]
      ,[SEGMENTS1_SEGSTART]
      ,[SEGMENTS1_SEGEND]
      ,[SEGMENTS1_SEGLEN]
      ,[SEGMENTS1_SEGATTRB]
      ,[SEGMENTS1_FILLCH]
      ,[SEGMENTS1_SEGFORM]
      ,[SEGMENTS1_INCREM]
      ,[SEGMENTS1_TXTLANG]
      ,[SEGMENTS1_RESVD1]
      ,[SEGMENTS1_RESVD2]
      ,[SEGMENTS2_SEGSTART]
      ,[SEGMENTS2_SEGEND]
      ,[SEGMENTS2_SEGLEN]
      ,[SEGMENTS2_SEGATTRB]
      ,[SEGMENTS2_FILLCH]
      ,[SEGMENTS2_SEGFORM]
      ,[SEGMENTS2_INCREM]
      ,[SEGMENTS2_TXTLANG]
      ,[SEGMENTS2_RESVD1]
      ,[SEGMENTS2_RESVD2]
      ,[SEGMENTS3_SEGSTART]
      ,[SEGMENTS3_SEGEND]
      ,[SEGMENTS3_SEGLEN]
      ,[SEGMENTS3_SEGATTRB]
      ,[SEGMENTS3_FILLCH]
      ,[SEGMENTS3_SEGFORM]
      ,[SEGMENTS3_INCREM]
      ,[SEGMENTS3_TXTLANG]
      ,[SEGMENTS3_RESVD1]
      ,[SEGMENTS3_RESVD2]
      ,[SEGMENTS4_SEGSTART]
      ,[SEGMENTS4_SEGEND]
      ,[SEGMENTS4_SEGLEN]
      ,[SEGMENTS4_SEGATTRB]
      ,[SEGMENTS4_FILLCH]
      ,[SEGMENTS4_SEGFORM]
      ,[SEGMENTS4_INCREM]
      ,[SEGMENTS4_TXTLANG]
      ,[SEGMENTS4_RESVD1]
      ,[SEGMENTS4_RESVD2]
      ,[SEGMENTS5_SEGSTART]
      ,[SEGMENTS5_SEGEND]
      ,[SEGMENTS5_SEGLEN]
      ,[SEGMENTS5_SEGATTRB]
      ,[SEGMENTS5_FILLCH]
      ,[SEGMENTS5_SEGFORM]
      ,[SEGMENTS5_INCREM]
      ,[SEGMENTS5_TXTLANG]
      ,[SEGMENTS5_RESVD1]
      ,[SEGMENTS5_RESVD2]
      ,[SEGMENTS6_SEGSTART]
      ,[SEGMENTS6_SEGEND]
      ,[SEGMENTS6_SEGLEN]
      ,[SEGMENTS6_SEGATTRB]
      ,[SEGMENTS6_FILLCH]
      ,[SEGMENTS6_SEGFORM]
      ,[SEGMENTS6_INCREM]
      ,[SEGMENTS6_TXTLANG]
      ,[SEGMENTS6_RESVD1]
      ,[SEGMENTS6_RESVD2]
      ,[SEGMENTS7_SEGSTART]
      ,[SEGMENTS7_SEGEND]
      ,[SEGMENTS7_SEGLEN]
      ,[SEGMENTS7_SEGATTRB]
      ,[SEGMENTS7_FILLCH]
      ,[SEGMENTS7_SEGFORM]
      ,[SEGMENTS7_INCREM]
      ,[SEGMENTS7_TXTLANG]
      ,[SEGMENTS7_RESVD1]
      ,[SEGMENTS7_RESVD2]
      ,[SEGMENTS8_SEGSTART]
      ,[SEGMENTS8_SEGEND]
      ,[SEGMENTS8_SEGLEN]
      ,[SEGMENTS8_SEGATTRB]
      ,[SEGMENTS8_FILLCH]
      ,[SEGMENTS8_SEGFORM]
      ,[SEGMENTS8_INCREM]
      ,[SEGMENTS8_TXTLANG]
      ,[SEGMENTS8_RESVD1]
      ,[SEGMENTS8_RESVD2]
      ,[SEGMENTS9_SEGSTART]
      ,[SEGMENTS9_SEGEND]
      ,[SEGMENTS9_SEGLEN]
      ,[SEGMENTS9_SEGATTRB]
      ,[SEGMENTS9_FILLCH]
      ,[SEGMENTS9_SEGFORM]
      ,[SEGMENTS9_INCREM]
      ,[SEGMENTS9_TXTLANG]
      ,[SEGMENTS9_RESVD1]
      ,[SEGMENTS9_RESVD2]
      ,[SEGMENTS10_SEGSTART]
      ,[SEGMENTS10_SEGEND]
      ,[SEGMENTS10_SEGLEN]
      ,[SEGMENTS10_SEGATTRB]
      ,[SEGMENTS10_FILLCH]
      ,[SEGMENTS10_SEGFORM]
      ,[SEGMENTS10_INCREM]
      ,[SEGMENTS10_TXTLANG]
      ,[SEGMENTS10_RESVD1]
      ,[SEGMENTS10_RESVD2]
      ,[SEGMENTS11_SEGSTART]
      ,[SEGMENTS11_SEGEND]
      ,[SEGMENTS11_SEGLEN]
      ,[SEGMENTS11_SEGATTRB]
      ,[SEGMENTS11_FILLCH]
      ,[SEGMENTS11_SEGFORM]
      ,[SEGMENTS11_INCREM]
      ,[SEGMENTS11_TXTLANG]
      ,[SEGMENTS11_RESVD1]
      ,[SEGMENTS11_RESVD2]
      ,[SEGMENTS12_SEGSTART]
      ,[SEGMENTS12_SEGEND]
      ,[SEGMENTS12_SEGLEN]
      ,[SEGMENTS12_SEGATTRB]
      ,[SEGMENTS12_FILLCH]
      ,[SEGMENTS12_SEGFORM]
      ,[SEGMENTS12_INCREM]
      ,[SEGMENTS12_TXTLANG]
      ,[SEGMENTS12_RESVD1]
      ,[SEGMENTS12_RESVD2]
      ,[SEGMENTS13_SEGSTART]
      ,[SEGMENTS13_SEGEND]
      ,[SEGMENTS13_SEGLEN]
      ,[SEGMENTS13_SEGATTRB]
      ,[SEGMENTS13_FILLCH]
      ,[SEGMENTS13_SEGFORM]
      ,[SEGMENTS13_INCREM]
      ,[SEGMENTS13_TXTLANG]
      ,[SEGMENTS13_RESVD1]
      ,[SEGMENTS13_RESVD2]
      ,[SEGMENTS14_SEGSTART]
      ,[SEGMENTS14_SEGEND]
      ,[SEGMENTS14_SEGLEN]
      ,[SEGMENTS14_SEGATTRB]
      ,[SEGMENTS14_FILLCH]
      ,[SEGMENTS14_SEGFORM]
      ,[SEGMENTS14_INCREM]
      ,[SEGMENTS14_TXTLANG]
      ,[SEGMENTS14_RESVD1]
      ,[SEGMENTS14_RESVD2]
      ,[SEGMENTS15_SEGSTART]
      ,[SEGMENTS15_SEGEND]
      ,[SEGMENTS15_SEGLEN]
      ,[SEGMENTS15_SEGATTRB]
      ,[SEGMENTS15_FILLCH]
      ,[SEGMENTS15_SEGFORM]
      ,[SEGMENTS15_INCREM]
      ,[SEGMENTS15_TXTLANG]
      ,[SEGMENTS15_RESVD1]
      ,[SEGMENTS15_RESVD2]
      ,[SEGMENTS16_SEGSTART]
      ,[SEGMENTS16_SEGEND]
      ,[SEGMENTS16_SEGLEN]
      ,[SEGMENTS16_SEGATTRB]
      ,[SEGMENTS16_FILLCH]
      ,[SEGMENTS16_SEGFORM]
      ,[SEGMENTS16_INCREM]
      ,[SEGMENTS16_TXTLANG]
      ,[SEGMENTS16_RESVD1]
      ,[SEGMENTS16_RESVD2]
      ,[PLACECODE]
      ,[WORKAREA]
      ,[SPECODE]
      ,[WORKID]
      ,[PLACEREF]
  FROM [dbo].[L_LDOCNUM] WHERE LOGICALREF = @LOGICALREF
	   
FETCH NEXT FROM processes
INTO @LOGICALREF 
END

CLOSE processes
DEALLOCATE processes

--return @FIFO_FIYATI
--end




