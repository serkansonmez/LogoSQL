USE [GezenWeb_Default_v1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GunlukDevriyeAtilmayanNoktalarBetonTesisleri]    Script Date: 23.02.2025 14:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from OlayTutanak where OnayDurumId = 2 and MailGondermeTarihi is not null 

--update OlayTutanak set MailGondermeTarihi = null where OlayTutanakId = 7
--select * from OlayTutanak with (readpast)
--   exec [dbo].[SP_DenetlemeKontrolMailGonder]

alter procedure [dbo].[SP_DenetlemeKontrolMailGonder]     
 AS
BEGIN
 
  SET NOCOUNT ON;

declare @Kime varchar(1024)
declare @Bilgi varchar(2048)
declare @Gizli varchar(512)
declare @Oncelik varchar(255)
declare @Konu varchar(1024)

select @Kime=ParametreDegeri from GenelParametreler where ParametreTuru =  'OlayTutanakBildirimKime'
select @Bilgi=ParametreDegeri from GenelParametreler where ParametreTuru =  'OlayTutanakBildirimBilgi'

declare @GunTarihi datetime = getdate()



declare @AciklamaRenk varchar(20)

declare @AdiSoyadi varchar(200)
declare @TcKimlikNo varchar(20)
declare @SubeAdi varchar(200)
declare @YoneticiEmail varchar(200)
 

declare @Tarih datetime
declare @DevriyeSubeAdi varchar(2000)
declare @DenetlenenAdiSoyadi varchar(200)
declare @KontrolHususDurum varchar(200)
declare @Durum varchar(200)
declare @DenetleyenAdiSoyadi varchar(200)
declare @DenetleyenPersonelAciklama varchar(200)

declare @OlayTutanakId varchar(20)
declare @TutanakAciklama varchar(1000)

declare @StrSql nvarchar(2000)

DECLARE @Counter int 

declare @Body 	varchar(max) = ''
declare @BodyDetail 	varchar(max) = ''

set @Body = '
   
<html lang="tr">
<head>
 
 
</head>
<body>

<h1 class="post-tile entry-title" itemprop="headline" style="color: #40454d; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 24px; line-height: 1.3em; margin: 0px 0px 10px;">
Denetleme Kontrol Listesi </h1>
<div>
<table style="background-color: white; border-collapse: collapse; border-spacing: 0px; color: #6d6d6d; font-family: &quot;Titillium Web&quot;; font-size: 14px; margin-bottom: 0px; margin-top: 0px; width: 609px;"><tbody style="margin-bottom: 0px;">
<tr>
<td><strong>Tarih</strong></td>
<td><strong>Şube Adı</strong></td>
<td><strong>Denetlenen</strong></td>

<td><strong>Kontrol Edilen Husus</strong></td>
<td><strong>Durum</strong></td>

<td><strong>Denetleyen</strong></td>
<td><strong>Denetleyen Açıklama</strong></td>
  
</tr>


'

set @counter = 0

  
SELECT  
      @counter =  count(Tarih)
      
      
     
  FROM [dbo].[VW_DenetlemeKontrolMailListesi] where Datediff(HH,@GunTarihi,GETDATE()) between 0 and 24
 



if @counter>0
begin 
	
DECLARE processes CURSOR FOR

SELECT [Tarih]
      ,[DevriyeSubeAdi]
      ,[DenetlenenAdiSoyadi]
      ,[KontrolHususDurum]
      ,[Durum]
      ,[DenetleyenAdiSoyadi]
      ,[DenetleyenPersonelAciklama]
  FROM [dbo].[VW_DenetlemeKontrolMailListesi] where Datediff(HH,Tarih,GETDATE()) between 0 and 24
  
order by [DevriyeSubeAdi] , [Tarih]



OPEN processes

FETCH NEXT FROM processes
INTO @Tarih,@DevriyeSubeAdi,@DenetlenenAdiSoyadi ,@KontrolHususDurum ,@Durum,@DenetleyenAdiSoyadi,@DenetleyenPersonelAciklama
WHILE @@FETCH_STATUS = 0
BEGIN
	
    
    
    Set @Oncelik = 'Normal'
    set @Konu = 'DENETLEME KONTROL FORMU LİSTESİ'
   
    set @BodyDetail = ''
    if @Durum = 'Başarılı' set @AciklamaRenk = '#ffffff'
    else  	set @AciklamaRenk = '#ffff00'
		--set @AciklamaRenk = '#ffffff'
	 
 set @Body = @Body + '<tr style="background-attachment: initial; background-clip: initial; background-image: initial; background-origin: initial; background-position: initial; background-repeat: initial; background-size: initial;">

			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="100">' + CONVERT(VARCHAR(30), @Tarih, 103) + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @DevriyeSubeAdi + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @DenetlenenAdiSoyadi    + '</td>
 			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @KontrolHususDurum + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @Durum + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @DenetleyenAdiSoyadi + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="40">' + @DenetleyenPersonelAciklama + '</td>

 
			</tr>'
      --update  OlayTutanak set MailKime='serkansonmez16@gmail.com',MailBilgi='serkansonmez16@hotmail.com',MailGondermeTarihi= getdate()   where  OlayTutanakId=3
	                        --        select @AciklamaRenk,@IslemZamani,@AdiSoyadi,@TcKimlikNo,@SubeAdi,@Aciklama
	 
		EXECUTE sp_executesql @StrSql
		set @counter = 1
FETCH NEXT FROM processes
INTO  @Tarih,@DevriyeSubeAdi,@DenetlenenAdiSoyadi ,@KontrolHususDurum ,@Durum,@DenetleyenAdiSoyadi,@DenetleyenPersonelAciklama
END

CLOSE processes
DEALLOCATE processes

    set @Body = @Body + '
   
					</tbody>
					</table>
					</div>
					'
  --select @Body

	 if (@counter> 0)
	 begin
		  exec msdb.dbo.sp_send_dbmail
			@profile_name = 'Gezen Mail Servisi',
	 	 --	@recipients  = 'c.kiran@bursabeton.com.tr',
		 --   @copy_recipients = 'hl.sevin@bursabeton.com.tr; c.gulce@bursabeton.com.tr; o.karakaya@bursabeton.com.tr; ik@bursabeton.com.tr; umutbarisgezen@gezenhizmet.com; operasyon@gezenhizmet.com',
			@blind_copy_recipients =  'serkansonmez16@hotmail.com',
			@importance   = 'NORMAL',
			@subject    =  @Konu,
			@body_format= 'HTML',
			@body    = @Body
	end
end

END
 