--select * from LG_120_ITEMS WHERE CODE LIKE '%020V' 
declare @ItemCode varchar(100) = '150.2344.CP.0020V'
declare @dEn Int 
declare @dYukseklik Int 
declare @dBoy Integer 
declare @dAdet as Integer
declare @CONFACT1 as FLOAT
declare @CONFACT2 as FLOAT
declare @Sonuc as FLOAT
declare @Ozgul as FLOAT
declare @MalzemeTuru varchar(100) = substring( @ItemCode,9,2)

SELECT TOP 1  @CONFACT1=ITMUNITA.CONVFACT1, @CONFACT2=ITMUNITA.CONVFACT2 FROM LG_120_ITEMS ITEMS INNER JOIN LG_120_ITMUNITA ITMUNITA ON ITEMS.LOGICALREF = ITMUNITA.ITEMREF  WHERE  (ITMUNITA.LINENR = 3) AND (ITEMS.CODE= @ItemCode) 
   
   SET @CONFACT1  =1
   SET @CONFACT2  =1
 
 
 
  
 
   if  @MalzemeTuru=  'CP' 
   begin
        set @dYukseklik = 0
   END   
   set @Sonuc = 0
   set @ozgul = 0
   if @ItemCode ='150.1001.LM.CP' or @ItemCode = '150.1003.LM.CP' 
     begin
        set @Ozgul=281 
     end
       else
	   begin
         set  @Ozgul = 785
	  end
    
   if @dEn > 0 and @dYukseklik > 0 
    begin
      set @SONUC = @dEn * @dYukseklik * @dBoy * @dAdet
      set @SONUC = @SONUC * @ozgul
      set @SONUC = @SONUC / 100000000
    end
   else

      if @dEn > 0 
	  begin
         set @SONUC = dEn * dEn
         set @SONUC = SONUC * dBoy * dAdet * 62
         set @SONUC = SONUC / 10000000
		 end
      else
	  begin
         set @SONUC = dAdet * dBoy * CONFACT1
         set @SONUC = SONUC / CONFACT2
      end        
   end if

   select  @SONUC
   
 