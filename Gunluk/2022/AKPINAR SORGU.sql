DECLARE @ITEMREF INT = 47822
DECLARE @VARIANTREF INT = 2401
DECLARE @VALIDREVREF INT



--select * from LG_002_ITEMS WHERE LOGICALREF = 47822

select * from LG_002_VARIANT WHERE ITEMREF =@ITEMREF AND LOGICALREF = @VARIANTREF
--select * from LG_002_VARIANT WHERE ITEMREF =47822


SELECT @VALIDREVREF= VALIDREVREF  FROM LG_002_BOMASTER WHERE MAINPRODREF = @ITEMREF


SELECT @VALIDREVREF,@VARIANTREF,LG_002_ITEMS.CODE, LG_002_ITEMS.NAME, @VALIDREVREF,* FROM LG_002_BOMLINE 
LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.LOGICALREF = LG_002_BOMLINE.ITEMREF
WHERE BOMREVREF = @VALIDREVREF
select * from LG_002_VRNTCHARASGN 
LEFT JOIN LG_002_BOMVRNTFORMULA ON LG_002_BOMVRNTFORMULA.CARDREF = LG_002_VRNTCHARASGN.CHARVALREF AND LG_002_BOMVRNTFORMULA.MAINITEMREF = @ITEMREF 
WHERE ITEMREF=@ITEMREF AND VARIANTREF=@VARIANTREF AND LG_002_BOMVRNTFORMULA.LOGICALREF IS NOT NULL 
--47822 ANA �R�N
 SELECT * FROM LG_002_BOMVRNTFORMULA  WHERE BOMLREF = 37054
 -- select * from LG_002_VRNTCHARASGN WHERE ITEMREF = 47822 AND VARIANTREF = 2401
 --SELECT * FROM LG_002_CHARCODE WHERE LOGICALREF = 20
 -- SELECT * FROM LG_002_CHARVAL WHERE CHARCODEREF = 32

--SELECT * FROM LG_002_ITEMS WHERE LOGICALREF = 192

--SELECT 
--BOMMASTER.LOGICALREF, BOMMASTER.MAINPRODREF
-- FROM 
--LG_002_BOMASTER BOMMASTER WITH(NOLOCK) 
-- WHERE 
--(BOMMASTER.LOGICALREF = 7910)

--select * from LG_002_ITEMS WHERE LOGICALREF = 47822