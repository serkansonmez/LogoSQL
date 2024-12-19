create procedure  SP_CncKesimHareketToKesimHareket as 
begin
declare @CncKesimHareketId int 
declare @CncDosyaAdi varchar(100)
declare @PlakaEn float
declare @PlakaBoy float
declare @PlanlananPlakaAdet int

declare @KesilenPlakaAdet int
declare @KesilenPlakaAdetOnceki int
declare @KesilenPlakaAdetKalan int
declare @RowUpdatedTime datetime
declare @IslemYapilanDosya varchar(100)
declare @DosyaSiraNo int 
declare @KesimHareketId int
declare @optimizasyonKodu varchar(200) 

DECLARE processes CURSOR FOR

SELECT [CncKesimHareketId]
      ,[CncDosyaAdi]
      ,[PlakaEn]
      ,[PlakaBoy]
      ,[PlanlananPlakaAdet]
      ,[CncKesimHareket].[KesilenPlakaAdet]
      ,[RowUpdatedTime]
      ,[IslemYapilanDosya]
      ,[DosyaSiraNo]
      ,[CncKesimHareket].[KesimHareketId]
FROM [dbo].[CncKesimHareket]  with(nolock) 
left join KesimHareket with(nolock) on KesimHareket.KesimHareketId = [CncKesimHareket].KesimHareketId
where [CncKesimHareket].KesimHareketId is null  --  and (CncDosyaAdi= 'M0000950' or CncDosyaAdi= 'M0000895')
order by CAST(STUFF(STUFF(IslemYapilanDosya, 5, 0, '-'), 8, 0, '-') AS DATE),PlanlananPlakaAdet
--   select * from KesimHareket
-- select * from [CncKesimHareket]

OPEN processes
 
FETCH NEXT FROM processes
INTO  @CncKesimHareketId,@CncDosyaAdi,@PlakaEn,@PlakaBoy,@PlanlananPlakaAdet,@KesilenPlakaAdet,@RowUpdatedTime,@IslemYapilanDosya,@DosyaSiraNo,@KesimHareketId
WHILE @@FETCH_STATUS = 0
BEGIN
      
	--  select @CncKesimHareketId,@CncDosyaAdi,@PlakaEn,@PlakaBoy,@PlanlananPlakaAdet,@KesilenPlakaAdet,@RowUpdatedTime,@IslemYapilanDosya,@DosyaSiraNo,@KesimHareketId
	--1 optimizasyon kodu bulunacak
	select @optimizasyonKodu = optimizasyonKodu from Optimizasyon where CncDosyaAdi = @CncDosyaAdi
	--select *  from Optimizasyon where CncDosyaAdi = 'M00000950'
	--2 KesilenPlakaAdet güncel deðerini bulacaðýz
	set @KesilenPlakaAdetOnceki =0
	select top 1 @KesilenPlakaAdetOnceki =KesilenPlakaAdet from [CncKesimHareket]  with(nolock) where 
	                CncDosyaAdi=@CncDosyaAdi and PlakaEn=@PlakaEn and PlakaBoy=@PlakaBoy and PlanlananPlakaAdet=@PlanlananPlakaAdet and CncKesimHareketId<@CncKesimHareketId 
					and @DosyaSiraNo= DosyaSiraNo
					order by   CAST(STUFF(STUFF(IslemYapilanDosya, 5, 0, '-'), 8, 0, '-') AS DATE) ,KesilenPlakaAdet desc
    set @KesilenPlakaAdetKalan = @KesilenPlakaAdet - @KesilenPlakaAdetOnceki
	if (@optimizasyonKodu is not null)
	begin
	   -- select @optimizasyonKodu, @KesilenPlakaAdetKalan,@KesilenPlakaAdetOnceki,@KesilenPlakaAdet,@PlanlananPlakaAdet,@CncDosyaAdi,@IslemYapilanDosya
	 
	INSERT INTO [dbo].[KesimHareket]
           ([IseBaslangicSaati]
           ,[KullaniciId]
           ,[OptimizasyonKodu]
           ,[KesilenPlakaAdet]
           ,[DurusSuresiDk]
           ,[PersonelId1]
           ,[PersonelId2]
           ,[IsIstasyonlariId]
           ,[Aciklama]
           ,[Lot1]
           ,[Lot2]
           ,[Lot3])
     VALUES
           (@RowUpdatedTime
           ,2
           ,@optimizasyonKodu
           ,@KesilenPlakaAdetKalan
           ,0
           ,9
           ,0
           ,2 --<IsIstasyonlariId, int,>
           ,@CncDosyaAdi --<Aciklama, nvarchar(250),>
           ,'' --<Lot1, nvarchar(50),>
           ,'' --<Lot2, nvarchar(50),>
           ,'' ) --<Lot3, nvarchar(50),>)

		   SELECT @KesimHareketId = SCOPE_IDENTITY()

		   UPDATE [CncKesimHareket] SET KesimHareketId=@KesimHareketId WHERE CncKesimHareketId=@CncKesimHareketId
     end
FETCH NEXT FROM processes
INTO @CncKesimHareketId,@CncDosyaAdi,@PlakaEn,@PlakaBoy,@PlanlananPlakaAdet,@KesilenPlakaAdet,@RowUpdatedTime,@IslemYapilanDosya,@DosyaSiraNo,@KesimHareketId
END

 


CLOSE processes
DEALLOCATE processes

  end
 --update CncKesimHareket set KesimHareketId = null WHERE KesimHareketId = 65 and CncDosyaAdi not like '%895%'


 --select * from [CncKesimHareket]










 


