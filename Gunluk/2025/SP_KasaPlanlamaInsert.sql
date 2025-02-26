USE [FercamB2B_Default_v1]
GO

exec SP_KasaPlanlamaInsert
create procedure SP_KasaPlanlamaInsert as
insert into KasaPlanlama
SELECT  VW_UretimPlanlama.FirinIseBaslangicSaati as [RowCreatedTime]
      ,2 [RowCreatedBy]
      ,VW_UretimPlanlama.[UretimEmriNo]
      ,FirinSaglamAdet as [KasaTahminAdet]
      ,null [PlanlamaTarih]
      ,null [KasaKimlikNo]
      ,null [PlanlananEn]
      ,null [PlanlananBoy]
      ,null [PlanlananDerinlik]
      ,null [SonTeslimTarihi]
      ,null [GerceklesenUserId]
      ,null [GerceklesenEn]
      ,null [GerceklesenBoy]
      ,null [GerceklesenDerinlik]
      ,null [GerceklesenTarih]
  FROM VW_UretimPlanlama
  left join [KasaPlanlama] on [KasaPlanlama].[UretimEmriNo] collatE Turkish_CI_AS = VW_UretimPlanlama.UretimEmriNo 
   where FirinIseBaslangicSaati is not  null and [KasaPlanlama].KasaPlanlamaId is null
   and VW_UretimPlanlama.FirinIseBaslangicSaati>='20250101'
GO


