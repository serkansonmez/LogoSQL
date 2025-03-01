/* select CLIENTREF,* from LG_120_01_ORFICHE

 select PAY.CODE from LG_120_CLCARD CL WITH(NOLOCK)
 LEFT JOIN LG_120_PAYPLANS PAY WITH(NOLOCK) ON  CL.PAYMENTREF = PAY.LOGICALREF 
 where CL.LOGICALREF = 467
select* from lg_120_VARIANT WHERE LOGICALREF= 1024
select  LOGICALREF  from LG_120_VRNTCHARASGN WHERE ITEMREF= 993 AND [VARIANTREF]=  1027 AND [CHARVALREF] =1024 AND  CHARCODEREF = 1
 */
 select  *  from LG_120_VRNTCHARASGN WHERE ITEMREF= 963 AND [VARIANTREF]=  1024 AND [CHARVALREF] =1020 AND  CHARCODEREF = 1
 SELECT * FROM LG_120_ITEMS WHERE LOGICALREF = 963
-- EXEC [SP_VaryantUret] 993,5,7,8

ALTER PROCEDURE [dbo].[SP_VaryantUret] 
( @ItemRef int, @X int, @Y int, @Z int)
as
 
 
--Parametreler
--DECLARE @ItemRef INT = 993
--DECLARE @X INT = 63 
--DECLARE @Y INT = 63
--DECLARE @Z INT = 64

declare @Varmi int = 0
/*
Set @FirmaKodu=106
Set @OnayMekanizmaId=1
Set @OnayDokumanId=1
*/
 
--1.Önce Varyant tablosunda var mı, varsa direkt geri dönülecek
declare @varyantKodu varchar(100) = cast( @X as varchar(20)) + 'X'  +  cast( @y as varchar(20)) + 'X' +  cast( @Z as varchar(20))
declare @varyantRef int  =0
declare @CharValRef_X int  =0
declare @CharValRef_Y int  =0
declare @CharValRef_Z int  =0

-- SABİTLER CHARCODE tablosundaki
DECLARE @CharCodeRef_X int = 1  
DECLARE @CharCodeRef_Y int = 2  
DECLARE @CharCodeRef_Z int = 3  

DECLARE @CharAsgn_X int = 0
DECLARE @CharAsgn_Y int = 0
DECLARE @CharAsgn_Z int = 0
 --CHARSET 
DECLARE @ValNoRef int = 1  

select @varyantRef  = LOGICALREF FROM LG_120_VARIANT WHERE CODE = @varyantKodu
if @varyantRef =0
begin
   --Variant tablosuna kayıt insert ediliyor.
insert into [LG_120_VARIANT]
SELECT  @ItemRef [ITEMREF]
      ,[CARDTYPE]
      ,@varyantKodu [CODE]
      ,[NAME]
      ,[ACTIVE]
      ,[SPECODE]
      ,[CYPHCODE]
      ,[UNITSETREF]
      ,[QCCSETREF]
      ,[TEXTINC]
      ,[SITEID]
      ,[RECSTATUS]
      ,[ORGLOGICREF]
      ,1 [CAPIBLOCK_CREATEDBY]
      ,getdate() [CAPIBLOCK_CREADEDDATE]
      ,datepart(hh,getdate() ) [CAPIBLOCK_CREATEDHOUR]
      ,datepart(MM,getdate() )[CAPIBLOCK_CREATEDMIN]
      ,datepart(ss,getdate() )[CAPIBLOCK_CREATEDSEC]
      ,null [CAPIBLOCK_MODIFIEDBY]
      ,null [CAPIBLOCK_MODIFIEDDATE]
      ,null [CAPIBLOCK_MODIFIEDHOUR]
      ,null [CAPIBLOCK_MODIFIEDMIN]
      ,null [CAPIBLOCK_MODIFIEDSEC]
      ,[USEDINPERIODS]
      ,[ORGLOGOID]
      ,[CREATEDIN]
      ,NEWID() [GUID]
      ,[NAME2]
      ,[SPECODE2]
      ,[SPECODE3]
      ,[SPECODE4]
      ,[SPECODE5]
      ,[STGRPCODE]
      ,[PRODUCERCODE]
      ,[IMAGEINC]
      ,[GTIPCODE]
      ,[PORDAMNTTOLERANCE]
      ,[SORDAMNTTOLERANCE]
  FROM [dbo].[LG_120_VARIANT] WHERE LOGICALREF = 1
 select top 1 @varyantRef= LOGICALREF  from [LG_120_VARIANT] where code = @varyantKodu and ITEMREF = @ItemRef
end


--2. Varyant Bulunamadı, şimdi de charval tablosunda boyutlar var mı diye kontrol yapılacak
select @CharValRef_X= LOGICALREF  from LG_120_CHARVAL WHERE CODE =  cast( @X as varchar(20))  AND CHARCODEREF = @CharCodeRef_X
if (@CharValRef_X=0)
begin
  --X bulunamadı kayıt açılıyor...
  INSERT INTO [dbo].[LG_120_CHARVAL]([CHARCODEREF],[VALNO],[CODE],[NAME],[NAME2])
  VALUES (@CharCodeRef_X,@ValNoRef,cast( @X as varchar(20)),'','')
  select @CharValRef_X = LOGICALREF  from  [LG_120_CHARVAL] WHERE [CHARCODEREF] = @CharValRef_X and [VALNO] = @ValNoRef
end
 
select @CharValRef_Y= LOGICALREF  from LG_120_CHARVAL WHERE CODE =  cast( @Y as varchar(20)) AND CHARCODEREF = @CharCodeRef_Y
if (@CharValRef_Y=0)
begin
  --Y bulunamadı kayıt açılıyor...
  INSERT INTO [dbo].[LG_120_CHARVAL]([CHARCODEREF],[VALNO],[CODE],[NAME],[NAME2])
  VALUES (@CharCodeRef_Y,@ValNoRef,cast( @Y as varchar(20)),'','')
  select @CharValRef_Y = LOGICALREF  from  [LG_120_CHARVAL] WHERE [CHARCODEREF] = @CharValRef_Y and [VALNO] = @ValNoRef
end
select @CharValRef_Z= LOGICALREF  from LG_120_CHARVAL WHERE CODE =  cast( @Z as varchar(20))  AND CHARCODEREF = @CharCodeRef_Z
if (@CharValRef_Z=0)
begin
  --Z bulunamadı kayıt açılıyor...
  INSERT INTO [dbo].[LG_120_CHARVAL]([CHARCODEREF],[VALNO],[CODE],[NAME],[NAME2])
  VALUES (@CharCodeRef_Z,@ValNoRef,cast( @Z as varchar(20)),'','')
  select @CharValRef_Z = LOGICALREF  from  [LG_120_CHARVAL] WHERE [CHARCODEREF] = @CharValRef_Z and [VALNO] = @ValNoRef
end

--SELECT * FROM LG_120_VRNTCHARASGN WHERE ITEMREF = 993 and VARIANTREF = 1024 and CHARVALREF= 1020 and CHARCODEREF = 1

--   variant assign LG_120_VRNTCHARASGN tablosuna kayıt ekleniyor
DECLARE @STR varchar(2048) = 'select @CharAsgn_X= LOGICALREF  from LG_120_VRNTCHARASGN WHERE ITEMREF= ' + cast(@ItemRef as varchar(20)) + ' AND [VARIANTREF]=  ' + cast(@varyantRef as varchar(20)) + ' AND [CHARVALREF] =' + cast(@CharValRef_X as varchar(20)) + ' AND  CHARCODEREF = ' + cast(@CharCodeRef_X as varchar(20))  
select @STR
select @CharAsgn_X= LOGICALREF  from LG_120_VRNTCHARASGN WHERE ITEMREF= @ItemRef AND [VARIANTREF]= @varyantRef AND [CHARVALREF] =@CharValRef_X AND  CHARCODEREF = @CharCodeRef_X 
if (@CharAsgn_X=0)
begin
print @ItemRef
print @varyantRef
print @CharValRef_X
print @CharCodeRef_X
print @CharAsgn_X
  --X bulunamadı kayıt açılıyor...
	INSERT INTO [dbo].[LG_120_VRNTCHARASGN]
	([ITEMREF],[VARIANTREF],[CHARCODEREF],[CHARVALREF],[LINENR],[SITEID],[RECSTATUS],[ORGLOGICREF],[ORGLOGOID])
	VALUES 	(@ItemRef,@varyantRef,@CharCodeRef_X,@CharValRef_X,1,0,1,0,'')
end
select @CharAsgn_Y= LOGICALREF  from LG_120_VRNTCHARASGN WHERE ITEMREF= @ItemRef AND [VARIANTREF]= @varyantRef AND [CHARVALREF] =@CharValRef_Y AND  CHARCODEREF = @CharCodeRef_Y   
if (@CharAsgn_Y=0)
begin
  --X bulunamadı kayıt açılıyor...
	INSERT INTO [dbo].[LG_120_VRNTCHARASGN]
	([ITEMREF],[VARIANTREF],[CHARCODEREF],[CHARVALREF],[LINENR],[SITEID],[RECSTATUS],[ORGLOGICREF],[ORGLOGOID])
	VALUES 	(@ItemRef,@varyantRef,@CharCodeRef_Y,@CharValRef_Y,2,0,1,0,'')
end
select @CharAsgn_Z= LOGICALREF  from LG_120_VRNTCHARASGN WHERE ITEMREF= @ItemRef AND [VARIANTREF]= @varyantRef AND [CHARVALREF] =@CharValRef_Z AND  CHARCODEREF = @CharCodeRef_Z 
if (@CharAsgn_Z=0)
begin
  --X bulunamadı kayıt açılıyor...
	INSERT INTO [dbo].[LG_120_VRNTCHARASGN]
	([ITEMREF],[VARIANTREF],[CHARCODEREF],[CHARVALREF],[LINENR],[SITEID],[RECSTATUS],[ORGLOGICREF],[ORGLOGOID])
	VALUES 	(@ItemRef,@varyantRef,@CharCodeRef_Z,@CharValRef_Z,3,0,1,0,'')
end
-- ITEMUNITA tablosuna varyant olarak kayıt yapılıyor...
SET @Varmi = 0
SELECT TOP 1 @Varmi = LOGICALREF FROM LG_120_ITMUNITA WHERE ITEMREF = @ItemRef AND [VARIANTREF]= @varyantRef
if @Varmi =0
begin
INSERT INTO LG_120_ITMUNITA
SELECT  [ITEMREF]
      ,[LINENR]
      ,[UNITLINEREF]
      ,[BARCODE]
      ,[MTRLCLAS]
      ,[PURCHCLAS]
      ,[SALESCLAS]
      ,[MTRLPRIORITY]
      ,[PURCHPRIORTY]
      ,[SALESPRIORITY]
      ,[WIDTH]
      ,[LENGTH]
      ,[HEIGHT]
      ,[AREA]
      ,[VOLUME_]
      ,[WEIGHT]
      ,[WIDTHREF]
      ,[LENGTHREF]
      ,[HEIGHTREF]
      ,[AREAREF]
      ,[VOLUMEREF]
      ,[WEIGHTREF]
      ,[GROSSVOLUME]
      ,[GROSSWEIGHT]
      ,[GROSSVOLREF]
      ,[GROSSWGHTREF]
      ,[CONVFACT1]
      ,[CONVFACT2]
      ,[EXTACCESSFLAGS]
      ,[SITEID]
      ,[RECSTATUS]
      ,[ORGLOGICREF]
      ,[BARCODE2]
      ,[BARCODE3]
      ,[WBARCODE]
      ,[WBARCODESHIFT]
      ,@varyantRef as [VARIANTREF]
      ,[GLOBALID]
  FROM [dbo].[LG_120_ITMUNITA]
WHERE VARIANTREF = 0 AND ITEMREF = @ItemRef
end 

SET @Varmi = 0
SELECT TOP 1 @Varmi = LOGICALREF FROM [LG_120_INVDEF] WHERE ITEMREF = @ItemRef AND [VARIANTREF]= @varyantRef
if @Varmi =0
begin
-- LG_120_INVDEF tablosuna insert ediliyor...
INSERT INTO [LG_120_INVDEF]
SELECT  [INVENNO]
      ,[ITEMREF]
      ,[MINLEVEL]
      ,[MAXLEVEL]
      ,[SAFELEVEL]
      ,[LOCATIONREF]
      ,[PERCLOSEDATE]
      ,[ABCCODE]
      ,[MINLEVELCTRL]
      ,[MAXLEVELCTRL]
      ,[SAFELEVELCTRL]
      ,[NEGLEVELCTRL]
      ,[IOCTRL]
      ,@varyantRef as [VARIANTREF]
      ,[OUTCTRL]
  FROM [dbo].[LG_120_INVDEF]
  WHERE VARIANTREF = 0 AND ITEMREF =  @ItemRef
end


SET @Varmi = 0
SELECT TOP 1 @Varmi = LOGICALREF FROM LG_120_ITMFACTP WHERE ITEMREF = @ItemRef AND [VARIANTREF]= @varyantRef
if @Varmi =0
begin
--[LG_120_ITMFACTP] insert işlemi
insert into LG_120_ITMFACTP
SELECT  [FACTORYNR]
      ,[ITEMREF]
      ,[SPECIALIZED]
      ,[PROCURECLASS]
      ,[LOWLEVELCODE]
      ,[DIVLOTSIZE]
      ,[MRPCNTRL]
      ,[PLANPOLICY]
      ,[LOTSIZINGMTD]
      ,[FIXEDLOTSIZE]
      ,[YIELD]
      ,[MINORDERQTY]
      ,[MAXORDERQTY]
      ,[MULTORDERQTY]
      ,[MINORDERDAY]
      ,[MAXORDERDAY]
      ,[REORDERPOINT]
      ,[AUTOMTRISSUE]
      ,[PLANNERREF]
      ,[BUYERREF]
      ,[SELADMINREF]
      ,[CSTANALYSTREF]
      ,[DEFSERILOTNO]
      ,[AUTOLOTOUTMTD]
      ,[LOTPARTY]
      ,[OUTLOTSIZE]
      ,[COUNTFORMPS]
      ,[LOTSIZINGMTD2]
      ,[FIXEDLOTSIZE2]
      ,[YIELD2]
      ,[MINORDERQTY2]
      ,[MAXORDERQTY2]
      ,[MULTORDERQTY2]
      ,[CHECKALLINVENS]
      ,[PRODUCTIONFACT]
      ,[PROCUREINVEN]
      ,@varyantRef as [VARIANTREF]
  FROM [dbo].[LG_120_ITMFACTP]
    WHERE VARIANTREF = 0 AND ITEMREF =  @ItemRef
	end
/*
DECLARE pro037 CURSOR FOR
SELECT 
       [AdimSiraNo]
      ,[OnaylayanGrubuId],id
  FROM [OnayMekanizmaAdimlari] WHERE FirmaKodu = @FirmaKodu and 
  OnayMekanizmaId=@OnayMekanizmaId

OPEN pro037
FETCH NEXT FROM pro037
INTO @AdimSiraNo,@OnaylayanGrubuId,@OnayMekanizmaAdimlariId
WHILE @@FETCH_STATUS = 0
BEGIN
   INSERT INTO [OnayIslemleri]
           ([OnayDokumanId]
           ,[DokumanTakipNo]
           ,[OnayMekanizmaId]
           ,[AdimSiraNo]
           ,[DurumKodu]
           ,[KaydedenKullaniciId]
           ,[Aciklama]
           ,[Tarih]
           ,OnayMekanizmaAdimlariId
           ,BankaTemsilcisiId
           ,DeadlineDate)
     VALUES
           (@OnayDokumanId
           ,0
           ,@OnayMekanizmaId
           ,@AdimSiraNo
           ,'BEK'
           ,0
           ,NULL
           ,NULL
           ,@OnayMekanizmaAdimlariId
           ,0
           ,NULL)


FETCH NEXT FROM pro037
INTO  @AdimSiraNo,@OnaylayanGrubuId,@OnayMekanizmaAdimlariId
END
CLOSE pro037
DEALLOCATE pro037
*/





