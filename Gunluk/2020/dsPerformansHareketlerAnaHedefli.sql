
SELECT [PerformansHareketlerAnaHedefli].[Id], [PerformansAnaHedefleriId], [SubeMarkaId], [PuanTanitimiId], [PuanlayanUcretPersonelId],
Subeler.SubeAdi,
case when PuanTanitimi.PuanDegeri between 91 and 100 then
 '<div class=''btn-group-vertical''>
 <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>�yi</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>�ok �yi</button>
         <button type=''button'' class=''btn btn-xs btn-primary''>M�kemmel</button>
        </div> ' 
	when PuanTanitimi.PuanDegeri between 81 and 90 then
 '<div class=''btn-group-vertical''>
 <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yi</button>
		 <button type=''button'' class=''btn btn-xs btn-success ''>�ok �yi</button>
         <button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
        </div> ' 	
	when PuanTanitimi.PuanDegeri between 71 and 80 then
 '<div class=''btn-group-vertical''>
 <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs btn-info ''>�yi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�ok �yi</button>
         <button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
        </div> ' 		
	when PuanTanitimi.PuanDegeri between 61 and 70 then
 '<div class=''btn-group-vertical''>
 <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs btn-warning ''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�ok �yi</button>
         <button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
        </div> ' 		
  when PuanTanitimi.PuanDegeri between 51 and 60 then
 '<div class=''btn-group-vertical''>
            <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
			<button type=''button'' class=''btn btn-xs btn-danger ''>Yetersiz</button>
			<button type=''button'' class=''btn btn-xs disabled''>�yile�tirilmeli</button>
			<button type=''button'' class=''btn btn-xs disabled''>�yi</button>
			<button type=''button'' class=''btn btn-xs disabled''>�ok �yi</button>
			<button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
        </div> ' 	
	WHEN PuanTanitimi.PuanDegeri BETWEEN 41 AND 50 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs btn-danger ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs disabled ''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�ok �yi</button>
         <button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
         </div> ' 	
		else 
		 '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs disabled ''>�ok K�t�</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yile�tirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�yi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>�ok �yi</button>
        <button type=''button'' class=''btn btn-xs disabled''>M�kemmel</button>
     
        </div> ' 	
		end as PuanAciklama
,PerformansAciklama
,Yorum
 FROM [PerformansHareketlerAnaHedefli] 
left join UcretPersonel on [PerformansHareketlerAnaHedefli].PuanlayanUcretPersonelId=UcretPersonel.Id
left join Subeler on Subeler.Id = [PerformansHareketlerAnaHedefli].SubeMarkaId
Left join SubePerformansAciklama on Subeler.Id = SubePerformansAciklama.SubelerId and SubePerformansAciklama.PerformansDonemleriId=@PerformansDonemiId 
left join PuanTanitimi on PuanTanitimi.Id = PuanTanitimiId 
where [PerformansHareketlerAnaHedefli].FirmalarId=@FirmalarId and [PerformansHareketlerAnaHedefli].PerformansDonemiId=@PerformansDonemiId and UcretPersonel.TcKimlikNo=@TcKimlikNo 
and [PerformansHareketlerAnaHedefli].AktifPasif = '1'