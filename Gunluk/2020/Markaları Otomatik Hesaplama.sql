
declare @OrganizasyonSemasiId int
declare @UcretPersonelId int
declare @FirmalarId int

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
declare @PerformansDonemiId int
 

declare @YeniOran float

DECLARE processes CURSOR FOR
select 
-- (select count(*) from VW_PerformansSablonu where VW_PerformansSablonu.OrganizasyonSemasiId=OrganizasyonSemasi.Id and VW_PerformansSablonu.PerformansAnaHedefleriId=3),*,
OrganizasyonSemasi.Id,FirmalarId,UcretPersonelId
 from OrganizasyonSemasi
left join MarkaCiroOran on OrganizasyonSemasi.MarkaCiroOranId = MarkaCiroOran.Id
where  MarkaCiroOran.MarkaAdi is not null  --and OrganizasyonSemasi.Id = 1276

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

			OPEN prcs2
			FETCH NEXT FROM prcs2
			INTO 
			@EklenecekPersonelId,@Adi,@Soyadi,@YetkidenOrganizasyonId
			WHILE @@FETCH_STATUS = 0
			BEGIN
			       set @VW_PerformansSablonuId=0
				   select @VW_PerformansSablonuId=VW_PerformansSablonu.Id from VW_PerformansSablonu where VW_PerformansSablonu.FirmalarId=@FirmalarId and 
															VW_PerformansSablonu.OrganizasyonSemasiId=@OrganizasyonSemasiId and 
															VW_PerformansSablonu.PuanlayanPersonelId=@EklenecekPersonelId and 
															VW_PerformansSablonu.PerformansAnaHedefleriId=3
				    if (@VW_PerformansSablonuId=0)
					begin  
					     select top 1  @EklenecekOrganizasyonSemasiId= Id from VW_OrganizasyonSemasi where MarkaCiroOranId is not null and UcretPersonelId = @EklenecekPersonelId
					      --select * from   VW_OrganizasyonSemasi where MarkaCiroOranId is not null
					    -- yoksa kayýt açýlacak
						  if (@Soyadi='Yetki')
						  begin
							   set @EklenecekOrganizasyonSemasiId =@YetkidenOrganizasyonId
						  end 
						  insert into PerformansSablonu
						 select 
						    @FirmalarId 
							,1 AS [PerformansDonemiId]
							,@OrganizasyonSemasiId AS [OrganizasyonSemasiId]
							,3 [PerformansAnaHedefleriId]
							,@EklenecekOrganizasyonSemasiId[PuanlayanOrganizasyonSemasiId]
							,0 as [Agirlik] 
					end	
				  


			FETCH NEXT FROM prcs2
			INTO  @EklenecekPersonelId,@Adi,@Soyadi,@YetkidenOrganizasyonId
			END
			CLOSE prcs2
			DEALLOCATE prcs2
			-- yüzde hesabý
			

 
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


			-- end yüzde hesabý


FETCH NEXT FROM processes
INTO  @OrganizasyonSemasiId,@FirmalarId,@UcretPersonelId
END
CLOSE processes
DEALLOCATE processes


