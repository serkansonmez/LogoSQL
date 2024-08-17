 
select 'update ErcomDbSiparis_2024 set TEKLIFNO=''' +  ISNULL(VW_IREN_2024_dbsiparis.[TEKLIFNO],null) + 
      ''' WHERE TedarikciFirmaId=1 AND  SAYAC=' + CAST(VW_IREN_2024_dbsiparis.[SAYAC] AS VARCHAR(20)) ,
       VW_IREN_2024_dbsiparis.[SAYAC]
      , VW_IREN_2024_dbsiparis.[SIPARISNO]
      , VW_IREN_2024_dbsiparis.[DURUM]
      , VW_IREN_2024_dbsiparis.[SIPTARIHI]
      , VW_IREN_2024_dbsiparis.[SEVKTARIHI]
      , VW_IREN_2024_dbsiparis.[CARIKOD]
      , VW_IREN_2024_dbsiparis.[CARIUNVAN]
      , VW_IREN_2024_dbsiparis.[MUSTERISI]
      , VW_IREN_2024_dbsiparis.[FTYETKILI]
      , VW_IREN_2024_dbsiparis.[EMTUTAR]
      , VW_IREN_2024_dbsiparis.[PLASIYER]
      , VW_IREN_2024_dbsiparis.[OPTI]
      ,1 [TedarikciFirmaId]
      , VW_IREN_2024_dbsiparis.[TEKLIFNO]  from VW_IREN_2024_dbsiparis 
left join ErcomDbSiparis_2024 on ErcomDbSiparis_2024.sayac = VW_IREN_2024_dbsiparis.SAYAC and ErcomDbSiparis_2024.TedarikciFirmaId=1
where ErcomDbSiparis_2024.sayac is NOT null

--select * from ErcomDbSiparis_2024 where SAYAC = 3

insert into ErcomDbSiparis_2024
select   VW_ASAS_2024_dbsiparis.[SAYAC]
      , VW_ASAS_2024_dbsiparis.[SIPARISNO]
      , VW_ASAS_2024_dbsiparis.[DURUM]
      , VW_ASAS_2024_dbsiparis.[SIPTARIHI]
      , VW_ASAS_2024_dbsiparis.[SEVKTARIHI]
      , VW_ASAS_2024_dbsiparis.[CARIKOD]
      , VW_ASAS_2024_dbsiparis.[CARIUNVAN]
      , VW_ASAS_2024_dbsiparis.[MUSTERISI]
      , VW_ASAS_2024_dbsiparis.[FTYETKILI]
      , VW_ASAS_2024_dbsiparis.[EMTUTAR]
      , VW_ASAS_2024_dbsiparis.[PLASIYER]
      , VW_ASAS_2024_dbsiparis.[OPTI]
      ,2 [TedarikciFirmaId]
      , VW_ASAS_2024_dbsiparis.[TEKLIFNO]   from VW_ASAS_2024_dbsiparis 
left join ErcomDbSiparis_2024 on ErcomDbSiparis_2024.sayac = VW_ASAS_2024_dbsiparis.SAYAC and ErcomDbSiparis_2024.TedarikciFirmaId=2
where ErcomDbSiparis_2024.sayac is null
