delete from PerformansSablonu where ID in (
select VW_PerformansSablonu.Id from VW_PerformansSablonu 
left join OrganizasyonSemasi on OrganizasyonSemasi.ID = VW_PerformansSablonu.OrganizasyonSemasiId
left join MarkaCiroOran on OrganizasyonSemasi.MarkaCiroOranId = MarkaCiroOran.Id
where PerformansAnaHedefleriID = 1 and MarkaCiroOran.MarkaAdi is not null)


delete from PerformansSablonu where Id in ( 
select Id FROM VW_PerformansSablonu WHERE PozisyonAdi is null)


