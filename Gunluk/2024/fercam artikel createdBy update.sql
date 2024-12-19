SELECT 
    'UPDATE fercam_artikel SET RowCreatedTime = ''' + 
    CONVERT(VARCHAR(23), [fercam_artikel_20230208].[datum], 121) + 
    ''', RowCreatedBy=' + cast( case when [fercam_artikel_20230208].benutzer ='RasitHosgor' then 2 
									when [fercam_artikel_20230208].benutzer ='Ammar Yenigelenler' then 1006  
									when [fercam_artikel_20230208].benutzer ='Canan Oezuylasi' then 1 
									when [fercam_artikel_20230208].benutzer ='SafakNazik' then 1003  
									else 0 end as varchar(20)) + ' WHERE id = ' + 
    CAST(fercam_artikel.id AS VARCHAR(200))
	,[fercam_artikel_20230208].datum ,fercam_artikel.datum
	,[fercam_artikel_20230208].*
FROM 
    [dbo].[fercam_artikel_20230208] 
LEFT JOIN 
    fercam_artikel ON [fercam_artikel_20230208].id = fercam_artikel.id
	where [fercam_artikel_20230208].datum <> fercam_artikel.datum
	--select * from Users


--	select * into fercam_artikel_20241015 from fercam_artikel