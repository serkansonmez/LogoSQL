--select * from OnayMekanizmalari

declare @OnayMekanizmaId int = 4526
declare @EskiIsim varchar(20) = 'Viglione'

declare @YeniIsim varchar(20) = 'Lesce'
declare @TigerFirma varchar(10) = '090'


declare @ProjeId int = 11
declare @YeniOnayMekanizmaId int = 0
--select * from Proje



insert into [OnayMekanizmalari]
  
SELECT replace([Adi],@EskiIsim,@YeniIsim) as Adi
      ,@TigerFirma as [FirmaKodu]
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
      ,@TigerFirma as [FirmaKodu]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[SmsGonder]
      ,[Aciklama]
      ,[AktifPasif]
  FROM [dbo].[OnayMekanizmaAdimlari]  where [OnayMekanizmaId] = @OnayMekanizmaId