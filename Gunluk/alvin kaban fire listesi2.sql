 select OrderNo,ProfilKodu,ProfilAciklama,sum(Fire) as Fire,sum(MinimumLength) as Kullanilan, sum(Fire)  +  sum(MinimumLength) as Toplam, (sum(Fire)  +  sum(MinimumLength)) / 6490 as BoySayisi, ZirveKod from 
	(SELECT  OrderNo,ProfilGrup.ProfilKodu,ProfilAciklama, Length - MinimumLength as Fire, MinimumLength  , Labels.ZirveKod    
	FROM dbo.KesimHeaderListesi 
	left join ProfilGrup on ProfilGrup.Id = ProfilGrupId
	 left join (
	 select OrderNo, ProfileCode,Substring(Userbarcode,6,9) as ZirveKod from dbo.Labels where LogHistoryId = 8291 group by OrderNo, ProfileCode,Substring(USerbarcode,6,9) ) Labels on ProfilGrup.ProfilKodu = Labels.ProfileCode
	WHERE KesimHeaderListesi.Id in (SELECT HeaderId FROM KesimListesi WHERE LabelId IN (select Id from dbo.Labels where LogHistoryId in (8291 ) ))) tblKabanSarf
	group by ProfilKodu,ProfilAciklama,ZirveKod,OrderNo