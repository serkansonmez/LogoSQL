SELECT      c.name  AS 'ColumnName'
            ,(SCHEMA_NAME(t.schema_id) + '.' + t.name) AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%fire%'
ORDER BY    TableName
            ,ColumnName;



SELECT [Id]
      ,[FileName]
      ,[CheckSum]
      ,[ImportDate]
      ,[FullPath]
      ,[State]
      ,[ErrorDetail]
      ,[IsWaiting]
      ,[IsWelded]
      ,[SendDate]
  FROM [dbo].[LogHistory] WHERE filename like '%06-12-2023%' and Id = 8292

select * from dbo.Labels where LogHistoryId = 8292
SELECT  Length - MinimumLength , * FROM dbo.KesimHeaderListesi WHERE Id = 516478

SELECT * FROM KesimListesi WHERE LabelId IN ( 2256545,2256546)
 

 select * from dbo.Labels where LogHistoryId = 8292

SELECT  ProfilGrup.ProfilKodu,ProfilAciklama, Length - MinimumLength as Fire, MinimumLength  , Labels.ZirveKod    
FROM dbo.KesimHeaderListesi 
left join ProfilGrup on ProfilGrup.Id = ProfilGrupId
 left join (
 select ProfileCode,Substring(USerbarcode,6,9) as ZirveKod from dbo.Labels where LogHistoryId = 8292 group by  ProfileCode,Substring(USerbarcode,6,9) ) Labels on ProfilGrup.ProfilKodu = Labels.ProfileCode
WHERE KesimHeaderListesi.Id in (SELECT HeaderId FROM KesimListesi WHERE LabelId IN (select Id from dbo.Labels where LogHistoryId = 8292))


select OrderNo,ProfilKodu,ProfilAciklama,sum(Fire) as Fire,sum(MinimumLength) as Kullanilan, sum(Fire)  +  sum(MinimumLength) as Toplam, (sum(Fire)  +  sum(MinimumLength)) / 6490 as BoySayisi, ZirveKod from 
	(SELECT  OrderNo,ProfilGrup.ProfilKodu,ProfilAciklama, Length - MinimumLength as Fire, MinimumLength  , Labels.ZirveKod    
	FROM dbo.KesimHeaderListesi 
	left join ProfilGrup on ProfilGrup.Id = ProfilGrupId
	 left join (
	 select OrderNo, ProfileCode,Substring(Userbarcode,6,9) as ZirveKod from dbo.Labels where LogHistoryId = 8292 group by OrderNo, ProfileCode,Substring(USerbarcode,6,9) ) Labels on ProfilGrup.ProfilKodu = Labels.ProfileCode
	WHERE KesimHeaderListesi.Id in (SELECT HeaderId FROM KesimListesi WHERE LabelId IN (select Id from dbo.Labels where LogHistoryId = 8292))) tblKabanSarf
	group by ProfilKodu,ProfilAciklama,ZirveKod,OrderNo


 



select * from ProfilGrup where Id in (
 
207,
211
,
219)

SELECT HeaderId FROM KesimListesi WHERE LabelId IN (select Id from dbo.Labels where LogHistoryId = 8292)
select * from dbo.Labels where LogHistoryId = 8292
 

 select profileCode,SUBSTRING(Userbarcode, CHARINDEX('K', Userbarcode), CHARINDEX(' ', Userbarcode + ' ', CHARINDEX('K', Userbarcode)) - CHARINDEX('K', Userbarcode))  from Labels 
 where ProfileCode = '0005020107'
 group by profileCode,SUBSTRING(Userbarcode, CHARINDEX('K', Userbarcode), CHARINDEX(' ', Userbarcode + ' ', CHARINDEX('K', Userbarcode)) - CHARINDEX('K', Userbarcode)) 


 select ProfileCode,Substring(USerbarcode,6,9) as ZirveKod from dbo.Labels where LogHistoryId = 8292 group by  ProfileCode,Substring(USerbarcode,6,9)

  select *  from dbo.Labels where LogHistoryId = 8292 