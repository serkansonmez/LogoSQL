----
--select * from fnc_UrunAgaciDetay(443) 
--select * from fnc_UrunAgaciDetay(450) 
--select * from fnc_UrunAgaciDetay(446) 
--select * from fnc_UrunAgaciDetay(497)
--select * from fnc_UrunAgaciDetay(496)
--select * from fnc_UrunAgaciDetay(494)
--select * from fnc_UrunAgaciDetay(493) 
--select * from fnc_UrunAgaciDetay(482) 
--select * from fnc_UrunAgaciDetay(476) 
--select * from fnc_UrunAgaciDetay(457) 
--select * from fnc_UrunAgaciDetay(456) 
--select * from fnc_UrunAgaciDetay(453) 
--select * from fnc_UrunAgaciDetay(452) 
--select * from fnc_UrunAgaciDetay(451) 

ALTER function fnc_UrunAgaciDetay (@NextBomlineRef int  ) 
RETURNS @Result TABLE (BomlineRef int, ItemCode varchar(50),ItemName varchar(150),NextBomlineRef int, ItemRef int,MasterBomlineRef int )  as
begin
DECLARE @ITEMREF INT = 0
DECLARE @VARIANTREF INT = 0
DECLARE @VALIDREVREF INT = @NextBomlineRef

select  @ITEMREF= ITEMREF  from  LG_002_BOMLINE WHERE LOGICALREF = @NextBomlineRef
 

declare  @MainAssign table (CharCodeRef int, CharValRef int)
declare  @DeletedRows table (Id int )
insert into @MainAssign
select   CharCodeRef ,CharValRef from LG_002_VRNTCHARASGN where ITEMREF = @ITEMREF 

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
select LG_002_BOMLINE.LOGICALREF,  LG_002_ITEMS.code,LG_002_ITEMS.name,NEXTLEVREVREF,ITEMREF,@VALIDREVREF AS Level_  from LG_002_BOMLINE 
LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
where BOMREVREF = @VALIDREVREF  AND LG_002_BOMLINE.LOGICALREF NOT IN (SELECT DISTINCT Id from @DeletedRows) and DEFCOSTTYPE<>0


 
return 

end