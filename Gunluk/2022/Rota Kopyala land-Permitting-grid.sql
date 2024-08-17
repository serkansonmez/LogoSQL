declare @OnayMekanizmaId int = 4645 --4579 dahil
--4636 4637  4638 4639 4640 4641 4642 4643 4644 4645
declare @EskiIsim varchar(20) = 'Permitting'

declare @YeniIsim varchar(20) = 'Grid'
--declare @TigerFirma varchar(10) = '090'


--declare @ProjeId int = 11
declare @YeniOnayMekanizmaId int = 0
declare @OnaylayanGrubuId  int = 322   --338 LandManager Federico   --322 GridManager Hamza
--select * from Proje

--select * from OnayGruplari where Adi like 'grid%'


insert into [OnayMekanizmalari]
  
SELECT replace([Adi],@EskiIsim,@YeniIsim) as Adi
      ,[FirmaKodu]
      ,[AltLimit]
      ,[UstLimit]
      ,[OnayTurId]
      ,[OnayBolgeSubeId]
      ,[IhaleFazAdimlariId]
      ,[PasifMi]
      ,[TutarGozukmesin]
      ,[FirmaAdi]
      ,[OrganizasyonKodu]
      ,[RowUpdatedBy]
      ,[RowUpdatedTime]
      , [ProjeId]
  FROM [dbo].[OnayMekanizmalari]  where [id] = @OnayMekanizmaId

select top 1 @YeniOnayMekanizmaId=id from [OnayMekanizmalari] order by id desc 


insert into [OnayMekanizmaAdimlari]
SELECT @YeniOnayMekanizmaId as [OnayMekanizmaId]
      ,[AdimSiraNo]
      ,case when [AdimSiraNo]= 1 then @OnaylayanGrubuId else [OnaylayanGrubuId] end  as [OnaylayanGrubuId]
      ,[FirmaKodu]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[SmsGonder]
      ,[Aciklama]
      ,[AktifPasif]
  FROM [dbo].[OnayMekanizmaAdimlari]  where [OnayMekanizmaId] = @OnayMekanizmaId