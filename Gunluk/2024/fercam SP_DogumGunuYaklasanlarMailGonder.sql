
--  exec SP_DogumGunuYaklasanlarMailGonder

alter procedure SP_DogumGunuYaklasanlarMailGonder
AS
BEGIN
 


declare @Kime varchar(1024)
declare @Bilgi varchar(2048)
declare @Gizli varchar(512)
declare @Oncelik varchar(255)
declare @Konu varchar(1024)

declare @GunTarihi datetime = getdate()
declare @AdiSoyadi varchar(200)
declare @Tarih varchar(100)

declare @AciklamaRenk varchar(20)

declare @BolumAdi varchar(100)
declare @PersonelStatusu varchar(20)
declare @DogumTarihi varchar(100) 
declare @MevcutYas varchar(5)
declare @YeniYas varchar(5)


DECLARE @Counter int 

declare @Body 	varchar(max) = ''
declare @BodyDetail 	varchar(max) = ''

 
set @Body = '
   
<html lang="tr">
<head>
 
 
</head>
<body>

<h1 class="post-tile entry-title" itemprop="headline" style="color: #40454d; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 24px; line-height: 1.3em; margin: 0px 0px 10px;">
PERSONEL DOÐUM GÜNÜ LÝSTESÝ (+7 GÜN)</h1>
<div>
<table style="background-color: white; border-collapse: collapse; border-spacing: 0px; color: #6d6d6d; font-family: &quot;Titillium Web&quot;; font-size: 14px; margin-bottom: 0px; margin-top: 0px; width: 609px;"><tbody style="margin-bottom: 0px;">
<tr>
<td><strong>Adý Soyadý</strong></td>
<td><strong>Personel Statüsü</strong></td>
<td><strong>Doðum Tarihi</strong></td>
<td><strong>Mevcut Yaþ</strong></td>
<td><strong>Yeni Yaþ</strong></td>
</tr>


'
 
	
DECLARE processes CURSOR FOR



 

SELECT 
  Adi + ' ' +  Soyadi as AdiSoyadi,case when AktifPasif = '1' then 'Aktif' else 'Pasif' end AktifPasif,
  CONVERT(varchar, DogumTarihi, 103) AS DogumTarihi,  
  FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi) / 365.25) AS MevcutYas
 ,FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi+7) / 365.25) AS YeniYas
FROM 
  Personel    EMP
WHERE 1 = (FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi+7) / 365.25))
          -
          (FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi) / 365.25))
 order by AktifPasif , DogumTarihi
--  select AdiSoyadi,
--BolumAdi,
--PersonelStatusu ,
--DogumTarihi ,
--MevcutYas ,
--YeniYas from #temp
OPEN processes

FETCH NEXT FROM processes
INTO @AdiSoyadi,@PersonelStatusu,@DogumTarihi,@MevcutYas,@YeniYas
WHILE @@FETCH_STATUS = 0
BEGIN
	
    
    
    Set @Oncelik = 'Normal'
    set @Konu = 'PDKS : Personel Yaklaþan Doðum günleri'
   
 
 
  
    set @BodyDetail = ''
  --  if @Aciklama = 'Normal Giriþ' set @AciklamaRenk = '#ffffff'
    --else  	set @AciklamaRenk = '#ffff00'
		set @AciklamaRenk = '#ffffff'
 set @Body = @Body + '<tr style="background-attachment: initial; background-clip: initial; background-image: initial; background-origin: initial; background-position: initial; background-repeat: initial; background-size: initial;">
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @AdiSoyadi + '</td>
 			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @PersonelStatusu + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @DogumTarihi + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @MevcutYas + '</td>
			 <td bgcolor="' + @AciklamaRenk + '" height="25" style="border: 1px solid rgb(229, 229, 229); margin-bottom: 0px; padding: 10px;" width="428">' + @YeniYas + '</td>
			</tr>'
   
FETCH NEXT FROM processes
INTO @AdiSoyadi,@PersonelStatusu,@DogumTarihi,@MevcutYas,@YeniYas
END

CLOSE processes
DEALLOCATE processes

    set @Body = @Body + '
   
					</tbody>
					</table>
					</div>
					'
select @Body
set @counter =0

 SELECT @counter = count( Adi   )
FROM 
 
  Personel    EMP
WHERE 1 = (FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi+7) / 365.25))
          -
          (FLOOR(DATEDIFF(dd,EMP.DogumTarihi,@GunTarihi) / 365.25))

 if (@counter> 0)
 begin
	  exec msdb.dbo.sp_send_dbmail
        @profile_name = 'fercam mail service',
		@recipients  = 'ik@fercam.com.tr',
 		@copy_recipients = 'rasit.hosgor@fercam.com.tr; ayasiryenigelenler@fercam.com.tr; uretim@fercam.com.tr',
		@blind_copy_recipients =  'serkan@serkansonmez.com',
		@importance   = 'NORMAL',
		@subject    =  @Konu,
        @body_format= 'HTML',
		@body    = @Body
	end

	END