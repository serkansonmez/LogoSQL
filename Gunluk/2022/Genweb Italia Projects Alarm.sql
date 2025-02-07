USE [GINSOFT_NET_PROD]
GO
/****** Object:  StoredProcedure [dbo].[SP_SehzadeEpiasUretimGunlukRaporMailGonder]    Script Date: 21.03.2022 22:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [SP_ItalyaExpiryMailGonder]
alter procedure [dbo].[SP_ItalyaExpiryMailGonder]
AS
BEGIN
 


declare @Kime varchar(1024)
declare @Bilgi varchar(2048)
declare @Gizli varchar(512)
declare @Oncelik varchar(255)
declare @Konu varchar(1024)

declare @GunTarihi datetime = getdate()
declare @AdiSoyadi varchar(200)


declare @AciklamaRenk varchar(20)
declare @ExpiryType varchar(100) 
declare @Ref int 
declare @ProjectNameCode varchar(200) 

declare @ExpiryDate varchar(100) 

declare  @MevcutYil int 
declare @ArtisYuzde decimal(10,2)
declare @PtfTutar decimal(10,2)


DECLARE @Counter int = 0


declare @Body 	varchar(max) = ''
declare @BodyDetail 	varchar(max) = ''
 
select @Counter = isnull(count(*),0) from VW_ItaliaLogbookExcelImportAlert
if @Counter=0 
begin
   return
end
set @Body = '
   
<html lang="tr">
<head>
 
 
</head>
<body>

<h1 class="post-tile entry-title" itemprop="headline" style="color: #40454d; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 24px; line-height: 1.3em; margin: 0px 0px 10px;">
ITALIA LOGBOOK EXPIRY LIST ( ' +  LEFT(CONVERT(VARCHAR, GETDATE()-1, 103), 10) + ' ) </h1>
<div>
<table style="background-color: white; border-collapse: collapse; border-spacing: 0px; color: #6d6d6d; font-family: &quot;Titillium Web&quot;; font-size: 14px; margin-bottom: 0px; margin-top: 0px; width: 609px;"><tbody style="margin-bottom: 0px;">
<tr>
<td><strong>Expiry Type</strong></td>
<td><strong>Ref</strong></td>
<td><strong>Project Name/Code</strong></td>
<td><strong>Expiry Date</strong></td>
</tr>


'



	
DECLARE processes CURSOR FOR

select ExpiryType,Ref,ProjectNameCode,ExpiryDate from VW_ItaliaLogbookExcelImportAlert
OPEN processes

FETCH NEXT FROM processes
INTO @ExpiryType, @Ref,@ProjectNameCode,@ExpiryDate
WHILE @@FETCH_STATUS = 0
BEGIN
	
    
    
    Set @Oncelik = 'Normal'
    set @Konu = 'ALARM : ITALIA LOGBOOK'
  
    set @BodyDetail = ''
         if (@ArtisYuzde<0)
		     set @AciklamaRenk = '#ffe6e6'
		 else 
		    set @AciklamaRenk = '#ffffff'
			--LEFT(CONVERT(VARCHAR, @ExpiryDate, 103), 12) 
 set @Body = @Body + '<tr style="background-attachment: initial; background-clip: initial; background-image: initial; background-origin: initial; background-position: initial; background-repeat: initial; background-size: initial;">
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @ExpiryType + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + cast(@Ref as varchar(20))+ '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @ProjectNameCode + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' +   convert(varchar,  @ExpiryDate, 105)   + '</td>
			  
			</tr>'
   
FETCH NEXT FROM processes
INTO @ExpiryType, @Ref,@ProjectNameCode,@ExpiryDate
END

CLOSE processes
DEALLOCATE processes

    set @Body = @Body + '
   
					</tbody>
					</table>
					</div>
					'
select @Body
 
 if (@counter> 0)
 begin
	  exec msdb.dbo.sp_send_dbmail
        @profile_name = 'sql mail service',
	 	--@recipients  = 'serkan.sonmez@gncr.com',
	  	@recipients  = 'lorenzo.nettuno@gncr.com; eray.agirman@gncr.com; hamza.yuksel@gncr.com; ozan.malkoc@gncr.com; serkan.ucar@gncr.com; deniz.basar@gncr.com ',
	  	@copy_recipients = 'tugrul.ertugrul@gncr.com; merthan@gencer.com; cemil.cetin@gncr.com',
		@blind_copy_recipients =  'serkan.sonmez@gncr.com',
		@importance   = 'NORMAL',
		@subject    =  @Konu,
        @body_format= 'HTML',
		@body    = @Body
	end

	END