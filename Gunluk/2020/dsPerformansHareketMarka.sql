SELECT PerformansHareketler.Id, PerformansHareketler.PerformansDonemiId, PerformansHareketler.PerformansAnaHedefleriId, PerformansHareketler.UnvanlarId, PerformansHareketler.UcretPersonelId, PerformansHareketler.OrganizasyonSemasiId, PerformansHareketler.PerformansHedefleriId, PerformansHareketler.Agirlik, PerformansHareketler.PuanTanitimiId, PerformansHareketler.PuanlamaTarihi, PerformansHedefleri.HedefAciklama, PerformansHedefleri.RenkKodu AS HedefRenkKodu, PerformansAnaHedefleri.RenkKodu AS PerformansAnaHedefRenkKodu, UPPER(PerformansHedefleri.HedefBaslik) AS HedefBaslik, CASE WHEN PuanTanitimi.PuanDegeri BETWEEN 91 AND 100 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs  disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs  disabled''>Çok Ýyi</button>
         <button type=''button'' class=''btn btn-xs btn-primary''>Mükemmel</button>
        
        </div> ' WHEN PuanTanitimi.PuanDegeri BETWEEN 81 AND 90 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs btn-success ''>Çok Ýyi</button>
         <button type=''button'' class=''btn btn-xs disabled''>Mükemmel</button>
        </div> ' WHEN PuanTanitimi.PuanDegeri BETWEEN 71 AND 80 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs btn-info ''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Çok Ýyi</button>
         <button type=''button'' class=''btn btn-xs disabled''>Mükemmel</button>
        </div> ' WHEN PuanTanitimi.PuanDegeri BETWEEN 61 AND 70 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs btn-warning ''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Çok Ýyi</button>
         <button type=''button'' class=''btn btn-xs disabled''>Mükemmel</button>
        </div> ' WHEN PuanTanitimi.PuanDegeri BETWEEN 51 AND 60 THEN '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs btn-danger ''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Çok Ýyi</button>
         <button type=''button'' class=''btn btn-xs disabled''>Mükemmel</button>
        </div> ' ELSE '<div class=''btn-group-vertical''>
		 <button type=''button'' class=''btn btn-xs disabled''>Yetersiz</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyileþtirilmeli</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Ýyi</button>
		 <button type=''button'' class=''btn btn-xs disabled''>Çok Ýyi</button>
        <button type=''button'' class=''btn btn-xs disabled''>Mükemmel</button>
        
        
        
        
        </div> ' END AS PuanAciklama, PerformansHareketler.Yorum FROM PerformansHareketler 
		LEFT OUTER JOIN PerformansHedefleri ON PerformansHedefleri.Id = PerformansHareketler.PerformansHedefleriId LEFT OUTER JOIN PuanTanitimi ON PuanTanitimi.Id = PerformansHareketler.PuanTanitimiId LEFT OUTER JOIN PerformansAnaHedefleri ON PerformansAnaHedefleri.Id = PerformansHareketler.PerformansAnaHedefleriId LEFT OUTER JOIN UcretPersonel ON PerformansHareketler.PuanlayanUcretPersonelId = UcretPersonel.Id 
		WHERE (PerformansHareketler.UcretPersonelId = @UcretPersonelId) AND (PerformansHareketler.PerformansDonemiId = @PerformansDonemiId) AND (UcretPersonel.TcKimlikNo = @TcKimlikNo) AND (PerformansHareketler.PerformansAnaHedefleriId = 3)