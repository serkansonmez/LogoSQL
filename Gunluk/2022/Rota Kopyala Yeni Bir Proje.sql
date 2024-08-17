--select * from OnayMekanizmalari where Adi like 'Portelli%'

--4438 4478	4479	4480	4481	4482	4483	4554	4555	4556	4570	4576	4582	4588	4594	4600

declare @OnayMekanizmaId int = 4600 --4579 dahil
declare @EskiIsim varchar(20) = 'Portelli'

declare @YeniIsim varchar(20) = 'Mazara'
 declare @TigerFirma varchar(10) = '083'


 declare @ProjeId int = 17
declare @YeniOnayMekanizmaId int = 0
declare @OnaylayanGrubuId  int = 322   --338 LandManager Federico   --322 GridManager Hamza
--select * from Proje

--select * from OnayGruplari where Adi like 'grid%'


insert into [OnayMekanizmalari]
  
SELECT replace([Adi],@EskiIsim,@YeniIsim) as Adi
      ,@TigerFirma [FirmaKodu]
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
      ,@ProjeId [ProjeId]
  FROM [dbo].[OnayMekanizmalari]  where [id] = @OnayMekanizmaId

select top 1 @YeniOnayMekanizmaId=id from [OnayMekanizmalari] order by id desc 


insert into [OnayMekanizmaAdimlari]
SELECT @YeniOnayMekanizmaId as [OnayMekanizmaId]
      ,[AdimSiraNo]
      ,[OnaylayanGrubuId]
      ,@TigerFirma [FirmaKodu]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[SmsGonder]
      ,[Aciklama]
      ,[AktifPasif]
  FROM [dbo].[OnayMekanizmaAdimlari]  where [OnayMekanizmaId] = @OnayMekanizmaId