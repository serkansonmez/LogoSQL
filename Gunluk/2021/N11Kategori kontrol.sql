 
create view VW_N11Kategori as 
SELECT q2.[N11KategoriId]
      ,q2.[ParentId]
      ,q2.[KategoriAdi]
      ,q2.[UserId]
      ,q2.[RowUpdatedBy]
      ,q2.[Seviye]
      ,(select count(*) from [N11Kategori] q1 where q1.[ParentId]= q2.[N11KategoriId] ) as [AltKategoriSayi]
      ,q2.[N11TeslimatSablonuId]
	  , case when q2.[Seviye] = 4 then
	     isnull(s2.KategoriAdi,'') + '->' + isnull(s3.KategoriAdi,l2.KategoriAdi) + '->' +  isnull(s4.KategoriAdi,l3.KategoriAdi) + '->' +  isnull(q2.KategoriAdi,'')
		  when q2.[Seviye] = 3 then 
		  isnull(l2.KategoriAdi,'') + '->' +  isnull( l3.KategoriAdi,'') + '->' +  isnull(q2.KategoriAdi,'') 
		   when q2.[Seviye] = 2 then 
		     isnull( x2.KategoriAdi,'') + '->' +  isnull(q2.KategoriAdi,'')
		 end as KategoriDetayi
  FROM [dbo].[N11Kategori]  q2
  left join [N11Kategori] s4 on q2.ParentId = s4.N11KategoriId and s4.Seviye =3
  left join [N11Kategori] s3 on s4.ParentId = s3.N11KategoriId and s3.Seviye =2
  left join [N11Kategori] s2 on s3.ParentId = s2.N11KategoriId and s2.Seviye =1

   
  left join [N11Kategori] l3 on q2.ParentId = l3.N11KategoriId and l3.Seviye =2
  left join [N11Kategori] l2 on l3.ParentId = l2.N11KategoriId and l2.Seviye =1

  
  left join [N11Kategori] x2 on q2.ParentId = x2.N11KategoriId and x2.Seviye =1
 
 where (select count(*) from [N11Kategori] q1 where q1.[ParentId]= q2.[N11KategoriId] ) =0 
 and q2.Seviye>1
 --and q2.KategoriAdi like '%jene%'

