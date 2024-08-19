alter  Procedure [dbo].SP_DogumGunuMailGonder as
declare @body1 varchar(4000)
 declare @AdiSoyadi varchar(50)
  declare @EPosta varchar(150)
declare @bosluk varchar(100) = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
 


DECLARE processes CURSOR FOR

select DISTINCT
Adi + ' ' + Soyadi as AdiSoyadi
 ,Kullanicilar.EMail
from UcretPersonel 
left join Kullanicilar on Kullanicilar.TcKimlikNo = UcretPersonel.TcKimlikNo
where 
DATEPART(d,DogumTarihi)=DATEPART(d,GETDATE()) AND DATEPART(m,DogumTarihi)=DATEPART(m,GETDATE())

OPEN processes
FETCH NEXT FROM processes
INTO 
@AdiSoyadi,@EPosta
WHILE @@FETCH_STATUS = 0
BEGIN



	

		set @body1 = '<head>
		<style>
		.container {
		  position: relative;
		  text-align: center;
		  color: white;
		}

		.bottom-left {
		  position: absolute;
		  bottom: 8px;
		  left: 16px;
		}

		.top-left {
		  position: absolute;
		  top: 8px;
		  left: 16px;
		}

		.top-right {
		  position: absolute;
		  top: 8px;
		  right: 16px;
		}

		.bottom-right {
		  position: absolute;
		  bottom: 8px;
		  right: 16px;
		}

		.centered {
		  position: absolute;
		  top: 40%;
		  left: 50%;
		  transform: translate(-40%, -50%);
		}
		</style>

		<table width="800px" border="0"  height="500px"  background="http://genweb.gencer.com:9009/makbuz/images/DogumGunuTebrigi.jpg">
		<tr>
		<td>
		</td>
		</tr>

		<tr>

		<td>
 
		<p style="color:red">' + @bosluk + '<b>Sn. ' + @AdiSoyadi + '</b></p>
		<p style="color:red">' + @bosluk + '<b>Krc Elektro Market ailesi olarak doðum gününüzü en içten dileklerimizle kutlar,</b> </p>
		<p style="color:red">' + @bosluk + '<b>sevdiklerinizle birlikte nice mutlu yýllar dileriz.</b></p>

		</td>

		</tr>
		<tr>
		<td>
		</td>
		</tr>


		<tr>
		<td>
		</td>
		</tr>
		</table>
		'
/*
		EXEC msdb.dbo.sp_send_dbmail

		@profile_name='sql mail service',

		@recipients=@EPosta,
		@blind_copy_recipients = 'serkansonmez16@hotmail.com',

		@subject = 'Doðum Günü Tebriði',

		@body = @body1,

		@body_format = 'HTML'
*/

INSERT INTO [dbo].[MailTablosu]
           ([TabloAdi]
           ,[TabloId]
           ,[Gonderen]
           ,[Kime]
           ,[Bilgi]
           ,[Gizli]
           ,[Oncelik]
           ,[Konu]
           ,[Mesaj]
           ,[KayitZamani]
           ,[KaydedenKullanici]
           ,[UlasimZamani]
           ,[UlasimDurumu]
           ,[UlasimDurumuAciklama])
     VALUES
           ('Kullanicilar'
           ,'0'
           ,'Noreply@krcelektromarket.com.tr' 
           ,@EPosta
           ,''
           ,'oznur.kaya@krcelektromarket.com.tr'
           ,'Normal'
           ,'Doðum günü Tebriði'
           ,@body1
           ,getdate()
           ,1
           ,null
           ,0
           ,'Bekliyor')

 
FETCH NEXT FROM processes
INTO @AdiSoyadi,@EPosta
END
CLOSE processes
DEALLOCATE processes


 

 