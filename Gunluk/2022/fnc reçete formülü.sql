-- select * from fnc_UrunAgaci(47822,2401)


alter function fnc_UrunAgaci (@ITEMREF int ,@VARIANTREF int) 
RETURNS @Result TABLE (BomlineRef int, ItemCode varchar(50),ItemName varchar(150),NextBomlineRef int,Itemref int ,ParentBomlineRef int )  as
begin
--DECLARE @ITEMREF INT = 47822
--DECLARE @VARIANTREF INT = 2401
DECLARE @VALIDREVREF INT

 

--SELECT *  FROM LG_002_BOMASTER WHERE LOGICALREF IN ( 447,454,450,501,461)
SELECT @VALIDREVREF= VALIDREVREF  FROM LG_002_BOMASTER WHERE MAINPRODREF = @ITEMREF

declare  @MainAssign table (CharCodeRef int, CharValRef int)
declare  @DeletedRows table (Id int )
declare  @NextId table (Id int )
insert into @MainAssign
select   CharCodeRef ,CharValRef from LG_002_VRNTCHARASGN where ITEMREF = @ITEMREF AND VARIANTREF = @VARIANTREF

--select  * from LG_002_VRNTCHARASGN where ITEMREF = 47822 AND VARIANTREF = 2401
-- FORMUL TABLOSUNDA KAYITLARI OLMAYANLAR DÝÐER LÝSTEYE DEÐERLER gelecek
--SELECT   BOMLREF, LG_002_BOMLINE.LOGICALREF,LG_002_ITEMS.CODE,MAINCHARREF,CARDREF FROM LG_002_BOMLINE 
--LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
--LEFT JOIN LG_002_BOMVRNTFORMULA  ON BOMLREF = LG_002_BOMLINE.LOGICALREF
--WHERE BOMREVREF = @VALIDREVREF AND LG_002_BOMVRNTFORMULA.LOGICALREF IS NULL

declare @BOMLINEREF INT
declare @ITEMCODE VARCHAR(50)
declare @MAINCHARREF INT
declare @CARDREF INT
declare @NextBomlineRef int 

declare @CharCodeRef int 
declare @CharValRef int

DECLARE MainProc CURSOR FOR

 
-- formüllü olanlar geliyor
SELECT     LG_002_BOMLINE.LOGICALREF,LG_002_ITEMS.CODE,MAINCHARREF,CARDREF FROM LG_002_BOMLINE 
LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
LEFT JOIN LG_002_BOMVRNTFORMULA  ON BOMLREF = LG_002_BOMLINE.LOGICALREF
WHERE BOMREVREF = @VALIDREVREF AND LG_002_BOMVRNTFORMULA.LOGICALREF IS not NULL
 
 
OPEN MainProc
FETCH NEXT FROM MainProc
INTO @BOMLINEREF,@ITEMCODE,@MAINCHARREF,@CARDREF
WHILE @@FETCH_STATUS = 0
BEGIN
      
			DECLARE DetailProc CURSOR FOR
			SELECT CharCodeRef ,CharValRef   from   @MainAssign
 
 
			OPEN DetailProc
			FETCH NEXT FROM DetailProc
			INTO @CharCodeRef ,@CharValRef
			WHILE @@FETCH_STATUS = 0
			BEGIN
					if (@CharCodeRef=@MAINCHARREF and @CharValRef<>@CARDREF) 
					begin
					      insert into @DeletedRows
					     select  @BOMLINEREF
					end
			FETCH NEXT FROM DetailProc
			INTO @CharCodeRef ,@CharValRef
			END
			CLOSE DetailProc
			DEALLOCATE DetailProc



    -- select @BOMLINEREF,@ITEMCODE,@MAINCHARREF,@CARDREF
FETCH NEXT FROM MainProc
INTO @BOMLINEREF,@ITEMCODE,@MAINCHARREF,@CARDREF
END
CLOSE MainProc
DEALLOCATE MainProc
insert into @Result
select LG_002_BOMLINE.LOGICALREF,  LG_002_ITEMS.code,LG_002_ITEMS.name,NEXTLEVREVREF , ITEMREF, 0 as Level_ from LG_002_BOMLINE 
LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
where BOMREVREF = @VALIDREVREF  AND LG_002_BOMLINE.LOGICALREF NOT IN (SELECT DISTINCT Id from @DeletedRows)


 DECLARE @LEVEL int = 0
 declare @NextBomlineRef2 int 
-- NExt için döngü baþlýyor

DECLARE NextProc CURSOR FOR

SELECT NextBomlineRef FROM @Result WHERE NextBomlineRef>0 and ParentBomlineRef>=@LEVEL

OPEN NextProc
FETCH NEXT FROM NextProc
INTO @NextBomlineRef
WHILE @@FETCH_STATUS = 0
BEGIN
     insert into @Result
     select BomlineRef , ItemCode ,ItemName,NextBomlineRef ,Itemref  ,@NextBomlineRef as Level_ from fnc_UrunAgaciDetay(@NextBomlineRef) 
	
	-- update @Result set  Level_ = -1 where NextBomlineRef=@NextBomlineRef
--	insert into @Result
--select LG_002_BOMLINE.LOGICALREF,  LG_002_ITEMS.code,LG_002_ITEMS.name,NEXTLEVREVREF , ITEMREF , @level from LG_002_BOMLINE 
--LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
--where BOMREVREF = @NextBomlineRef

FETCH NEXT FROM NextProc
INTO @NextBomlineRef
END
CLOSE NextProc
DEALLOCATE NextProc
 
return 

end

--select *, LG_002_BOMLINE.LOGICALREF,  LG_002_ITEMS.code,LG_002_ITEMS.name,NEXTLEVREVREF , ITEMREF ,LG_002_ITEMS.ty   from LG_002_BOMLINE 
-- LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
-- where BOMREVREF =443
--select * from fnc_UrunAgaci(47822,2401)