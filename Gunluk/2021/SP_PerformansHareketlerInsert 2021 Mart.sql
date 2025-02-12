USE [SuperIk_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_PerformansHareketlerInsert]    Script Date: 21.03.2021 22:09:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [SP_PerformansHareketlerInsert] 1,4,1

ALTER PROCEDURE [dbo].[SP_PerformansHareketlerInsert] 
( @UserId int, @FirmalarId int, @PerformansDonemiId int)
as
begin
--declare @UserId int = 1
--declare @FirmalarId int = 1
--declare @PerformansDonemiId int = 1 
--declare @OrganizasyonSemasiId int = 1

if (@PerformansDonemiId = 6)
begin 

insert into PerformansHareketler   

SELECT '0' as [RowDeleted]
      ,getdate() as  [RowUpdatedTime]
      ,1 as [RowUpdatedBy]
      ,@FirmalarId as [FirmalarId]
      ,@PerformansDonemiId as [PerformansDonemiId]
      ,PerformansSablonu.OrganizasyonSemasiId as [OrganizasyonSemasiId]
      ,UcretPersonel.Id [UcretPersonelId]
      ,PerformansSablonu.[PerformansAnaHedefleriId] as [PerformansAnaHedefleriId]
      ,OrganizasyonSemasi.[UnvanlarId] as [UnvanlarId]
      ,PerformansHedefleri.Id as [PerformansHedefleriId]
      ,PerformansSablonu.[PuanlayanOrganizasyonSemasiId]
      ,PuanlayanPersonel.Id as [PuanlayanUcretPersonelId]
      ,PerformansSablonu.Agirlik as [Agirlik]
      ,0 as [PuanTanitimiId]
      ,null as [PuanlamaTarihi]
      ,null as Yorum
  FROM PerformansSablonu
  left join PerformansDonemleri on PerformansDonemleri.Id = @PerformansDonemiId
  left join OrganizasyonSemasi on OrganizasyonSemasi.Id = PerformansSablonu.OrganizasyonSemasiId 
  left join Unvanlar on Unvanlar.Id = OrganizasyonSemasi.UnvanlarId
  left join Subeler on Subeler.Id = OrganizasyonSemasi.SubelerId
  left join UcretPersonel on UcretPersonel.Id = OrganizasyonSemasi.UcretPersonelId
  left join OrganizasyonSemasi PuanlayanPozisyon on PuanlayanPozisyon.Id = PerformansSablonu.PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel PuanlayanPersonel on PuanlayanPersonel.Id = PuanlayanPozisyon.UcretPersonelId
  left join PerformansHedefleri on PerformansHedefleri.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId and PerformansHedefleri.UnvanlarId = OrganizasyonSemasi.UnvanlarId
  left join PerformansAnaHedefleri on PerformansAnaHedefleri.Id = PerformansSablonu.PerformansAnaHedefleriId 
 
  left join PerformansHareketler on 
                   PerformansHareketler.FirmalarId = PerformansSablonu.FirmalarId and 
				   PerformansHareketler.PerformansDonemiId = PerformansSablonu.PerformansDonemiId and 
				   PerformansHareketler.OrganizasyonSemasiId = PerformansSablonu.OrganizasyonSemasiId and  
				   PerformansHareketler.PuanlayanOrganizasyonSemasiId = PerformansSablonu.PuanlayanOrganizasyonSemasiId and  
				   PerformansHareketler.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId
  where PerformansHareketler.Id is null and PerformansAnaHedefleri.AltHedeflerAktif='1' and PerformansSablonu.PerformansAnaHedefleriId in (4)
  and PuanlayanPersonel.Id is not null

   return
end




--1. ilk olarak Marka eksiği olanların şablonu oluşacak


declare @kontrolPersonelID int 
declare @OrganizasyonSemasiId int
declare @UcretPersonelId int
--declare @FirmalarId int

declare @PuanlayanPersonelId int
declare @YetkidenOrganizasyonId int
declare @EklenecekPersonelId int
declare @EklenecekOrganizasyonSemasiId int
declare @VW_PerformansSablonuId int
 

declare @Adi varchar(100)
declare @Soyadi varchar(100)

declare @PuanlayanOrganizasyonSemasiId int
declare @KalanReferans int 


 
declare @PerformansAnaHedefleriId int
declare @Toplam float
declare @Adet float
--declare @PerformansDonemiId int
 

declare @YeniOran float

DECLARE processes CURSOR FOR
select 
-- (select count(*) from VW_PerformansSablonu where VW_PerformansSablonu.OrganizasyonSemasiId=OrganizasyonSemasi.Id and VW_PerformansSablonu.PerformansAnaHedefleriId=3),*,
OrganizasyonSemasi.Id,FirmalarId,UcretPersonelId
 from OrganizasyonSemasi
left join MarkaCiroOran on OrganizasyonSemasi.MarkaCiroOranId = MarkaCiroOran.Id
where  MarkaCiroOran.MarkaAdi is not null  -- and OrganizasyonSemasi.Id = 1293

OPEN processes
FETCH NEXT FROM processes
INTO 
@OrganizasyonSemasiId,@FirmalarId,@UcretPersonelId
WHILE @@FETCH_STATUS = 0
BEGIN
     
			DECLARE prcs2 CURSOR FOR
			       select  Id,Adi,Soyadi, OrgSemasiId from 
					(select  UcretPersonel.Id,Adi,Soyadi,0 as OrgSemasiId from OrganizasyonSemasi
					left join MarkaCiroOran on OrganizasyonSemasi.MarkaCiroOranId = MarkaCiroOran.Id
					left join UcretPersonel on OrganizasyonSemasi.UcretPersonelId = UcretPersonel.Id
					where  MarkaCiroOran.MarkaAdi is not null 
					group by UcretPersonel.Id,Adi,Soyadi 
					UNION ALL 
					SELECT VW_OrganizasyonSemasi.UcretPersonelId,Adisoyadi,'Yetki',VW_OrganizasyonSemasi.Id  FROM VW_OrganizasyonSemasi 
					left join  Kullanici_Yetkileri on YetkiTableId= VW_OrganizasyonSemasi.Id and YetkiTurleriId=1 and kullaniciId = 1
					where Kullanici_Yetkileri.Id is not null) tbl
					--where Id<>@UcretPersonelId
			OPEN prcs2
			FETCH NEXT FROM prcs2
			INTO 
			@EklenecekPersonelId,@Adi,@Soyadi,@YetkidenOrganizasyonId
			WHILE @@FETCH_STATUS = 0
			BEGIN
			 
			       set @VW_PerformansSablonuId=0
				   select @VW_PerformansSablonuId=VW_PerformansSablonu.Id,@kontrolPersonelID= PuanlayanPersonelId from VW_PerformansSablonu where VW_PerformansSablonu.FirmalarId=@FirmalarId and 
															VW_PerformansSablonu.OrganizasyonSemasiId=@OrganizasyonSemasiId and 
															VW_PerformansSablonu.PuanlayanPersonelId=@EklenecekPersonelId and 
															VW_PerformansSablonu.PerformansAnaHedefleriId=3
							   						 
				    if (@VW_PerformansSablonuId=0)
					begin  
					     select top 1  @EklenecekOrganizasyonSemasiId= Id from VW_OrganizasyonSemasi where MarkaCiroOranId is not null and UcretPersonelId = @EklenecekPersonelId
					      --select * from   VW_OrganizasyonSemasi where MarkaCiroOranId is not null
					    -- yoksa kayıt açılacak
						  if (@Soyadi='Yetki')
						  begin
							   set @EklenecekOrganizasyonSemasiId =@YetkidenOrganizasyonId
						  end 
						  insert into PerformansSablonu
						 select 
						    @FirmalarId 
							,@PerformansDonemiId AS [PerformansDonemiId]
							,@OrganizasyonSemasiId AS [OrganizasyonSemasiId]
							,3 [PerformansAnaHedefleriId]
							,@EklenecekOrganizasyonSemasiId[PuanlayanOrganizasyonSemasiId]
							,0 as [Agirlik] 

							  
					end	
					else 
					begin
					     
					      if (@kontrolPersonelID=@UcretPersonelId)
						  begin

						    --  select @kontrolPersonelID ,@UcretPersonelId
						      delete from  PerformansSablonu where Id = @VW_PerformansSablonuId 
						  end 
					end
				  


			FETCH NEXT FROM prcs2
			INTO  @EklenecekPersonelId,@Adi,@Soyadi,@YetkidenOrganizasyonId
			END
			CLOSE prcs2
			DEALLOCATE prcs2
			-- yüzde hesabı
			

 
				DECLARE prcsYuzde CURSOR FOR


				select   FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,round(sum(Agirlik),2),count(Agirlik) from 
				PerformansSablonu 
				where PerformansAnaHedefleriId = 3 and OrganizasyonSemasiId = @OrganizasyonSemasiId
				group by FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId 
				--having round(sum(Agirlik),2)<>100


				OPEN prcsYuzde
				FETCH NEXT FROM prcsYuzde
				INTO 
				@FirmalarId,@PerformansDonemiId,@OrganizasyonSemasiId,@PerformansAnaHedefleriId,@Toplam,@Adet
				WHILE @@FETCH_STATUS = 0
				BEGIN
						set @YeniOran = 100 / @Adet
						update PerformansSablonu set Agirlik = @YeniOran where Id in (

						select Id from PerformansSablonu where FirmalarId= @FirmalarId and PerformansDonemiId=@PerformansDonemiId
						and  OrganizasyonSemasiId=@OrganizasyonSemasiId and PerformansAnaHedefleriId=@PerformansAnaHedefleriId)

				FETCH NEXT FROM prcsYuzde
				INTO  @FirmalarId,@PerformansDonemiId,@OrganizasyonSemasiId,@PerformansAnaHedefleriId,@Toplam,@Adet
				END
				CLOSE prcsYuzde
				DEALLOCATE prcsYuzde


			-- end yüzde hesabı


FETCH NEXT FROM processes
INTO  @OrganizasyonSemasiId,@FirmalarId,@UcretPersonelId
END
CLOSE processes
DEALLOCATE processes





--select * from PerformansHareketler

--select * from PerformansHareketlerAnaHedefli
--2.Normal Performans Hareket tablosu insert edilecek
insert into PerformansHareketler   

SELECT '0' as [RowDeleted]
      ,getdate() as  [RowUpdatedTime]
      ,1 as [RowUpdatedBy]
      ,@FirmalarId as [FirmalarId]
      ,@PerformansDonemiId as [PerformansDonemiId]
      ,PerformansSablonu.OrganizasyonSemasiId as [OrganizasyonSemasiId]
      ,UcretPersonel.Id [UcretPersonelId]
      ,PerformansSablonu.[PerformansAnaHedefleriId] as [PerformansAnaHedefleriId]
      ,OrganizasyonSemasi.[UnvanlarId] as [UnvanlarId]
      ,PerformansHedefleri.Id as [PerformansHedefleriId]
      ,PerformansSablonu.[PuanlayanOrganizasyonSemasiId]
      ,PuanlayanPersonel.Id as [PuanlayanUcretPersonelId]
      ,PerformansSablonu.Agirlik as [Agirlik]
      ,0 as [PuanTanitimiId]
      ,null as [PuanlamaTarihi]
      ,null as Yorum
  FROM PerformansSablonu
  left join PerformansDonemleri on PerformansDonemleri.Id = @PerformansDonemiId
  left join OrganizasyonSemasi on OrganizasyonSemasi.Id = PerformansSablonu.OrganizasyonSemasiId 
  left join Unvanlar on Unvanlar.Id = OrganizasyonSemasi.UnvanlarId
  left join Subeler on Subeler.Id = OrganizasyonSemasi.SubelerId
  left join UcretPersonel on UcretPersonel.Id = OrganizasyonSemasi.UcretPersonelId
  left join OrganizasyonSemasi PuanlayanPozisyon on PuanlayanPozisyon.Id = PerformansSablonu.PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel PuanlayanPersonel on PuanlayanPersonel.Id = PuanlayanPozisyon.UcretPersonelId
  left join PerformansHedefleri on PerformansHedefleri.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId and PerformansHedefleri.UnvanlarId = OrganizasyonSemasi.UnvanlarId
  left join PerformansAnaHedefleri on PerformansAnaHedefleri.Id = PerformansSablonu.PerformansAnaHedefleriId 
 
  left join PerformansHareketler on 
                   PerformansHareketler.FirmalarId = PerformansSablonu.FirmalarId and 
				   PerformansHareketler.PerformansDonemiId = PerformansSablonu.PerformansDonemiId and 
				   PerformansHareketler.OrganizasyonSemasiId = PerformansSablonu.OrganizasyonSemasiId and  
				   PerformansHareketler.PuanlayanOrganizasyonSemasiId = PerformansSablonu.PuanlayanOrganizasyonSemasiId and  
				   PerformansHareketler.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId
  where PerformansHareketler.Id is null and PerformansAnaHedefleri.AltHedeflerAktif='1' and PerformansSablonu.PerformansAnaHedefleriId in (1,3)
  and PuanlayanPersonel.Id is not null
  
  
  /*
  
insert into PerformansHareketler   

SELECT '0' as [RowDeleted]
      ,getdate() as  [RowUpdatedTime]
      ,1 as [RowUpdatedBy]
      ,@FirmalarId as [FirmalarId]
      ,@PerformansDonemiId as [PerformansDonemiId]
      ,PerformansSablonu.OrganizasyonSemasiId as [OrganizasyonSemasiId]
      ,UcretPersonel.Id [UcretPersonelId]
      ,PerformansSablonu.[PerformansAnaHedefleriId] as [PerformansAnaHedefleriId]
      ,OrganizasyonSemasi.[UnvanlarId] as [UnvanlarId]
       ,0 as [PerformansHedefleriId]
      ,PerformansSablonu.[PuanlayanOrganizasyonSemasiId]
      ,PuanlayanPersonel.Id as [PuanlayanUcretPersonelId]
      ,PerformansSablonu.Agirlik as [Agirlik]
      ,0 as [PuanTanitimiId]
      ,null as [PuanlamaTarihi]
  FROM PerformansSablonu
  left join PerformansDonemleri on PerformansDonemleri.Id = 1
  left join OrganizasyonSemasi on OrganizasyonSemasi.Id = PerformansSablonu.OrganizasyonSemasiId 
  left join Unvanlar on Unvanlar.Id = OrganizasyonSemasi.UnvanlarId
  left join Subeler on Subeler.Id = OrganizasyonSemasi.SubelerId
  left join UcretPersonel on UcretPersonel.Id = OrganizasyonSemasi.UcretPersonelId
  left join OrganizasyonSemasi PuanlayanPozisyon on PuanlayanPozisyon.Id = PerformansSablonu.PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel PuanlayanPersonel on PuanlayanPersonel.Id = PuanlayanPozisyon.UcretPersonelId
  --left join PerformansHedefleri on PerformansHedefleri.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId and PerformansHedefleri.UnvanlarId = OrganizasyonSemasi.UnvanlarId
  left join PerformansAnaHedefleri on PerformansAnaHedefleri.Id = PerformansSablonu.PerformansAnaHedefleriId 
  left join PerformansHareketler on PerformansHareketler.FirmalarId = PerformansSablonu.FirmalarId and PerformansHareketler.PerformansDonemiId = PerformansSablonu.PerformansDonemiId and PerformansHareketler.OrganizasyonSemasiId = PerformansSablonu.OrganizasyonSemasiId --and PerformansHedefleri.Id = PerformansHareketler.[PerformansHedefleriId]
  where PerformansHareketler.Id is null and PerformansAnaHedefleri.AltHedeflerAktif='1' and PerformansAnaHedefleri.Id=3
  
  */
  delete from [PerformansHareketler] where Id in (
SELECT [PerformansHareketler].[Id]
 
  FROM [dbo].[PerformansHareketler]
  left join Kullanicilar Kaydeden on Kaydeden.Id = [PerformansHareketler].[RowUpdatedBy] 
  left join Firmalar  on Firmalar.Id = [PerformansHareketler].FirmalarId 
  left join PerformansDonemleri  on PerformansDonemleri.Id = [PerformansHareketler].[PerformansDonemiId] 
  left join OrganizasyonSemasi  on OrganizasyonSemasi.Id = [PerformansHareketler].OrganizasyonSemasiId 
  left join UcretPersonel  on UcretPersonel.Id = [PerformansHareketler].UcretPersonelId 
  left join Unvanlar  on Unvanlar.Id = [PerformansHareketler].UnvanlarId 
  left join [PerformansAnaHedefleri]  on [PerformansAnaHedefleri].Id = [PerformansHareketler].[PerformansAnaHedefleriId] 
  left join [PerformansHedefleri]  on [PerformansHedefleri].Id = [PerformansHareketler].[PerformansHedefleriId] 
  left join OrganizasyonSemasi PuanlayanOrganizasyonSemasi  on PuanlayanOrganizasyonSemasi.Id = [PerformansHareketler].PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel  PuanlayanUcretPersonel on PuanlayanUcretPersonel.Id = [PerformansHareketler].PuanlayanUcretPersonelId 
  left join PuanTanitimi  on PuanTanitimi.Id = [PerformansHareketler].PuanTanitimiId 
  left join MarkaCiroOran  on MarkaCiroOran.Id = OrganizasyonSemasi.MarkaCiroOranId 
  left join PerformansSablonu on PerformansSablonu.FirmalarId = [PerformansHareketler].FirmalarId and 
								 PerformansSablonu.PerformansDonemiId = [PerformansHareketler].PerformansDonemiId and	
								 PerformansSablonu.OrganizasyonSemasiId = [PerformansHareketler].OrganizasyonSemasiId and	
								 PerformansSablonu.PerformansAnaHedefleriId = [PerformansHareketler].PerformansAnaHedefleriId and	 
								 PerformansSablonu.PuanlayanOrganizasyonSemasiId = [PerformansHareketler].PuanlayanOrganizasyonSemasiId  	
  where [PerformansHareketler].[RowDeleted] = '0' --AND UcretPersonel.Adi like 'volk%'
  and PerformansSablonu.Id is null and [PerformansHareketler].Id is not null)
  end

 
-- personel kendisini puanlayamaz
delete from PerformansHareketler where Id in(
SELECT Id FROM VW_PerformansHareketler WHERE PuanlayanAdiSoyadi = AdiSoyadi and PerformansAnaHedefleriId=3)


