DECLARE @UsersId int 
DECLARE @RowCreatedTime datetime 
DECLARE @SiparisTarih datetime 
DECLARE @SiparisFisNo varchar(20)
DECLARE @TigerFirmaNo int 
DECLARE @TigerFirmaDonem int 
DECLARE @IrsaliyeTarih datetime 
declare @IrsaliyeReferans int
declare @TigerCariHesapKodu varchar(20)
declare @SoforBilgi varchar(20)
declare @KontrolEdenUserId int



DECLARE processes CURSOR FOR

--1.önce fiþler aktarýlýyor.
select 1 as UsersId,GETDATE() RowCreatedTime,DATE_ as SiparisTarih,FICHENO as SiparisFisNo,324 as TigerFirmaNo,1  as TigerFirmaDonem,null as IrsaliyeTarih,
null as IrsaliyeReferans,CL.CODE as TigerCariHesapKodu, null as SoforBilgi,1 as KontrolEdenUserId
from cezve..lg_324_01_ORFICHE ORF WITH(NOLOCK) 
left join cezve..LG_324_CLCARD CL WITH(NOLOCK) on CL.LOGICALREF = ORF.CLIENTREF
left join SatinalmaIrsaliyeFisi WITH(NOLOCK) on SatinalmaIrsaliyeFisi.TigerFirmaNo = 324 AND SatinalmaIrsaliyeFisi.SiparisFisNo = orf.FICHENO
where trcode =2 and SatinalmaIrsaliyeFisi.SatinalmaIrsaliyeFisiId is null

	OPEN processes
 
	FETCH NEXT FROM processes
	INTO  @UsersId,@RowCreatedTime,@SiparisTarih,@SiparisFisNo,@TigerFirmaNo,@TigerFirmaDonem,@IrsaliyeTarih,@IrsaliyeReferans,@TigerCariHesapKodu,@SoforBilgi,@KontrolEdenUserId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	      insert into  SatinalmaIrsaliyeFisi
		     select  @UsersId,@RowCreatedTime,@SiparisTarih,@SiparisFisNo,@TigerFirmaNo,@TigerFirmaDonem,@IrsaliyeTarih,@IrsaliyeReferans,@TigerCariHesapKodu,@SoforBilgi,@KontrolEdenUserId 
		  DECLARE @SatinalmaIrsaliyeFisiId INT;
		  SET @SatinalmaIrsaliyeFisiId = SCOPE_IDENTITY();	
		   SELECT ITMV.ITEMS_CODE as TigerMalzemeHesapKodu,UNITSETF_NAME AS Birim,ORFL.AMOUNT as SiparisMiktar from cezve..lg_324_01_ORFICHE ORF WITH(NOLOCK) 
		   left join cezve..lg_324_01_ORFLINE ORFL WITH(NOLOCK) ON ORFL.ORDFICHEREF = ORF.LOGICALREF
		   left join cezve..LG_324_ITEMS ITM WITH(NOLOCK) ON ORFL.STOCKREF = ITM.LOGICALREF
		   left join cezve..LV_324_ITEMS ITMV WITH(NOLOCK) ON ITMV.ITEMS_CODE = ITM.CODE
		   WHERE ORF.FICHENO =@SiparisFisNo
		--2.daha sonra satýrlar aktarýlýyor.

    FETCH NEXT FROM processes
	INTO  @UsersId,@RowCreatedTime,@SiparisTarih,@SiparisFisNo,@TigerFirmaNo,@TigerFirmaDonem,@IrsaliyeTarih,@IrsaliyeReferans,@TigerCariHesapKodu,@SoforBilgi,@KontrolEdenUserId
	END

	CLOSE processes
	DEALLOCATE processes



 