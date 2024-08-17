CREATE PROCEDURE SP_TrendyolAttributeInsert as 
declare @StokId int 
declare @LOGICALREF VARCHAR(30)
declare @STOKKODU  VARCHAR(30)
declare @MARKA  VARCHAR(30)
declare @JANT  VARCHAR(30)
declare @MEVSIM  VARCHAR(30)
declare @KESIT  VARCHAR(30)
declare @TUR  VARCHAR(30)
declare @TABAN  VARCHAR(30)
declare @YIL  VARCHAR(30)
declare @FREN  VARCHAR(30)
declare @YAKITVERIMI  VARCHAR(30)
declare  @AttId int 
declare @AttName varchar(30)
declare  @AttValueId int 
declare @AttValueName varchar(30)
 

declare  @LISTE Table (StokId int, LOGICALREF VARCHAR(30),STOKKODU  VARCHAR(30), MARKA  VARCHAR(30), JANT  VARCHAR(30), MEVSIM  VARCHAR(30),KESIT  VARCHAR(30),TUR  VARCHAR(30),TABAN  VARCHAR(30),YIL  VARCHAR(30), FREN  VARCHAR(30), YAKITVERIMI  VARCHAR(30))
INSERT INTO @LISTE
 
select   tbl_001_stok.a_id, eTicaret.LOGICALREF, eTicaret.[Stok Kodu], eTicaret.Marka, eTicaret.Jant, eTicaret.Mevsim, SUBSTRING(eTicaret.Ebat,1,3),eTicaret.Tür,'' AS TABAN,Dot,'' AS FREN, '' AS YAKITVERIMI  from tbl_001_stok
--left join tbl_001_EPazar_Stok on tbl_001_EPazar_Stok.StokId = tbl_001_stok.a_id
left join ArgelasB2B_Default_v1..EmyEticaret eTicaret on eTicaret.[Stok Kodu] = a_kod
where tbl_001_stok.a_id is not null and eTicaret.[Stok Kodu] is not null  --and tbl_001_stok.a_id= 7558
 
--select   tbl_001_stok.a_id, eTicaret.LOGICALREF, eTicaret.[Stok Kodu], eTicaret.Marka, eTicaret.Jant, eTicaret.Mevsim, SUBSTRING(eTicaret.Ebat,1,3),eTicaret.Tür,'' AS TABAN,Dot,'' AS FREN, '' AS YAKITVERIMI  from tbl_001_stok
 
--left join ArgelasB2B_Default_v1..EmyEticaret eTicaret on eTicaret.[Stok Kodu] = a_kod
--where   tbl_001_stok.a_id= 7558



 --SELECT * FROM @LISTE
----1 BEDEN
--insert into tbl_001_EPazar_TrendStokAttributes
--select NEWID() as ProductId,338 as AttId,'Beden' as AttName,6821 as AttValueId,'Tek Ebat' as AttValueName, tb.StokId  from @LISTE tb
--left join tbl_001_EPazar_TrendStokAttributes on tb.StokId = tbl_001_EPazar_TrendStokAttributes.AttCode
--where tbl_001_EPazar_TrendStokAttributes.AttCode is null
 

--SELECT AttId,AttName
--  FROM [dbo].[tbl_001_EPazar_TrendKategoriAttributes] where Required = 1
--  group by AttId,AttName

DECLARE MainProc CURSOR FOR

 
-- formüllü olanlar geliyor
select StokId , LOGICALREF, STOKKODU  , MARKA   , JANT   , MEVSIM   ,KESIT  ,TUR   ,TABAN   ,YIL   , FREN  , YAKITVERIMI from @LISTE
 
 
OPEN MainProc
FETCH NEXT FROM MainProc
INTO @StokId , @LOGICALREF, @STOKKODU  , @MARKA   , @JANT   , @MEVSIM   ,@KESIT  ,@TUR   ,@TABAN   ,@YIL   , @FREN  , @YAKITVERIMI
WHILE @@FETCH_STATUS = 0
BEGIN
       --     select @StokId , @LOGICALREF, @STOKKODU  , @MARKA   , @JANT   , @MEVSIM   ,@KESIT  ,@TUR   ,@TABAN   ,@YIL   , @FREN  , @YAKITVERIMI
			DECLARE DetailProc CURSOR FOR
			SELECT AttId,AttName
				  FROM [dbo].[tbl_001_EPazar_TrendKategoriAttributes] -- where Required = 1 -- zorunlu olanlar
				  group by AttId,AttName
 
 
			OPEN DetailProc
			FETCH NEXT FROM DetailProc
			INTO @AttId,@AttName
			WHILE @@FETCH_STATUS = 0
			BEGIN
			-- select @AttId,@AttName
			        set @AttValueId = 0
					set @AttValueName = ''
					 

					if  @AttName = 'Jant Çapý'  
					begin
					  
					     SELECT @AttValueId=AttValueId,@AttValueName =  AttValueName from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and AttValueName= @JANT
						--select  @AttValueId ,@AttValueName
					end
					else if  @AttName = 'Yýl'  
					begin
					     SELECT @AttValueId=AttValueId,@AttValueName =  AttValueName from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and AttValueName= @YIL
					end
				    else if  @AttName = 'Mevsim'  
					begin
					     if (@MEVSIM='YAZ')
						 begin
						      set @AttValueId = 7881
							  set @AttValueName = 'Yaz'
						 end 
						 else if (@MEVSIM='DORTMEVSIM')
						 begin
						      set @AttValueId = 7879
							  set @AttValueName = '4 Mevsim'
						 end 
						  else if (@MEVSIM='KIS')
						 begin
						      set @AttValueId = 7880
							  set @AttValueName = 'Kýþ'
						 end 
					     --SELECT @AttValueId=AttValueId,@AttValueName =  AttValueName from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and lower(AttValueName)= lower(@MEVSIM)
					end
					else if  @AttName = 'Araç Tipi'   --zorunlu deðil
					begin
					     SELECT @AttValueId=AttValueId,@AttValueName =  AttValueName from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and lower(AttValueName) = lower(replace(@TUR,'I','i'))
					end
					else  -- diðerleri için 
					begin
					    set @AttValueId = 0
					    select @AttValueName =  OZDEGCODE from  VW_TigerMalzemeOzellikleri where OZKODNAME = @AttName and left(@LOGICALREF, charindex('-', @LOGICALREF) - 1) = LOGICALREF
					    SELECT @AttValueId=AttValueId from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and  AttValueName = @AttValueName
						if (@AttValueId=0)  -- eðer ana parametrede yoksa daha önceki stoklardan arama yapýlýyor...
						begin
						    SELECT top 1 @AttValueId=AttValueId  from [tbl_001_EPazar_TrendStokAttributes] WHERE @AttId = @AttId and  AttValueName = @AttValueName
						end
					end
 

					if (@AttValueId>0)
					begin
						 insert into tbl_001_EPazar_TrendStokAttributes
						select NEWID() as ProductId,@AttId,@AttName,@AttValueId,@AttValueName, tb.StokId  from @LISTE tb
						left join tbl_001_EPazar_TrendStokAttributes on tb.StokId = tbl_001_EPazar_TrendStokAttributes.AttCode and tbl_001_EPazar_TrendStokAttributes.AttId = @AttId and tbl_001_EPazar_TrendStokAttributes.AttValueId = @AttValueId
						where tbl_001_EPazar_TrendStokAttributes.AttCode is null and tb.StokId = @StokId  
						 
                    end
			FETCH NEXT FROM DetailProc
			INTO @AttId,@AttName
			END
			CLOSE DetailProc
			DEALLOCATE DetailProc



    -- select @BOMLINEREF,@ITEMCODE,@MAINCHARREF,@CARDREF
FETCH NEXT FROM MainProc
INTO  @StokId , @LOGICALREF, @STOKKODU  , @MARKA   , @JANT   , @MEVSIM   ,@KESIT  ,@TUR   ,@TABAN   ,@YIL   , @FREN  , @YAKITVERIMI
END
CLOSE MainProc
DEALLOCATE MainProc


--select  * from tbl_001_stok where a_kod =  '10101010200750-20'

--select * from ArgelasB2B_Default_v1..EmyEticaret
--select * from tbl_001_EPazar_TrendStokAttributes
--delete from tbl_001_EPazar_TrendStokAttributes where ProductId in (
--'D980A2F4-B97E-4A14-9BE9-420F672895A5',
--'EEC518E5-7534-42D5-8E6D-53B622DCD9E6')
-- select * from tbl_001_EPazar_TrendStokAttributes where AttCode = '7558'

-- select * from tbl_001_EPazar_TrendStokAttributes WHERE AttValueName <> 'Tek Ebat' and AttCode <> '' order by AttCode

-- select * from tbl_001_EPazar_TrendStokAttributes WHERE AttValueName <> 'Tek Ebat' and AttCode <> '' and AttValueId = 0

select * from tbl_001_EPazar_TrendKategoriAttributes where AttValueName = '16'


SELECT AttValueId,   AttValueName from [tbl_001_EPazar_TrendKategoriAttributes] WHERE @AttId = @AttId and AttValueName= 16

select a_model,a_marka,a_int_sfiyat, * from tbl_001_stok where a_id = 7558
 update tbl_001_stok set a_sfliste= 99, a_afliste = 98,a_intpfiyat=97 where a_id = 7558

select Id,Name from tbl_001_EPazar_TrendMarka where name like lower(replace('CONTINENTAL','I','i')) 


SELECT * from tbl_001_Ayarlar

update tbl_001_EPazar_Siparis set SatisSiparisRef = null, SatisSiparisNo = null  where ID = 2
select * from  tbl_001_EPazar_Siparis
select * from tbl_001_EPazar_TrendSipmas
select * from tbl_001_EPazar_TrendShipmentAddress


SELECT [StokKodu],[StokAdi],[SeriLotKodu],[DepoMiktari],Slref,AmbarAdi FROM  TIGER3.[dbo].[Emy_lot_DepoDurum] where  StokKodu= '10101010165650' 