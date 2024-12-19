        DECLARE      @Id INT = 715
 DECLARE   @Yil INT=2024                 -- Yýl parametresi
  DECLARE  @Ay INT = 12               -- Ay parametresi
   DECLARE @Durum NVARCHAR(10) = 'R'     -- Durum parametresi (Yýllýk Ýzin)
 DECLARE   @IzinTipi INT  = 2          -- Ýzin Tipi parametresi
  DECLARE  @DynamicDatabase NVARCHAR(200) = '[Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]' -- Dinamik Veritabaný Adý

	  ;WITH CTE_Processed AS      (          SELECT              *,              ROW_NUMBER() OVER (ORDER BY CAST(SUBSTRING(COLUMN_NAME, 2, LEN(COLUMN_NAME) - 1) AS INT)) AS RowNum,             
	  CAST(SUBSTRING(COLUMN_NAME, 2, LEN(COLUMN_NAME) - 1) AS INT) AS GunNo          FROM              (SELECT Id, [G1], [G2], [G3], [G4], [G5], [G6], [G7], [G8], [G9], [G10],                         
	  [G11], [G12], [G13], [G14], [G15], [G16], [G17], [G18], [G19], [G20],                           [G21], [G22], [G23], [G24], [G25], [G26], [G27], [G28], [G29], [G30], [G31]              
	  FROM  [ArGrupB2B_Default_v1]..PuantajTigemExcel               WHERE Id = @Id) p          UNPIVOT (Durum FOR COLUMN_NAME IN ([G1], [G2], [G3], [G4], [G5], [G6], [G7], [G8], [G9], [G10],   
	  [G11], [G12], [G13], [G14], [G15], [G16], [G17], [G18], [G19], [G20],                                              [G21], [G22], [G23], [G24], [G25], [G26], [G27], [G28], [G29], [G30], [G31])) 
	  AS Unpvt          WHERE Durum = @Durum      ),      CTE_Groups AS      (          SELECT              Id,              GunNo,              ROW_NUMBER() OVER (PARTITION BY Id ORDER BY GunNo) - 
	  GunNo AS GroupId          FROM CTE_Processed      )      INSERT INTO [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..[izin]     SELECT    TBL.Personelno, TBL.IzinTipi, 
	  TBL.Basgun, TBL.Bitgun, TBL.Aciklama, TBL.EksikGunNedeni, TBL.IzinBelgesi, TBL.HaftalikCalisilmayacakSaat,  TBL.HaftalikNormalSaat,TBL.AylikCalisilanGun,TBL.KisaCalismaIlk7GunHesapla  
	  FROM   (SELECT DISTINCT          perbilgi.Personelno,          @IzinTipi AS IzinTipi,          MIN(DATEFROMPARTS(@Yil, @Ay, GunNo)) AS Basgun,          
	  MAX(DATEFROMPARTS(@Yil, @Ay, GunNo)) AS Bitgun,          CAST(COUNT(*) AS VARCHAR(20)) AS Aciklama,          case when @Durum = 'R' THEN '01' ELSE NULL END AS EksikGunNedeni,       
	  NULL AS IzinBelgesi,          NULL AS HaftalikCalisilmayacakSaat,          NULL AS HaftalikNormalSaat,          NULL AS AylikCalisilanGun,          NULL AS KisaCalismaIlk7GunHesapla    
	  FROM CTE_Groups      LEFT JOIN [ArGrupB2B_Default_v1]..PuantajTigemExcel pnt ON pnt.Id = CTE_Groups.Id      LEFT JOIN [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..perbilgi 
	  ON perbilgi.vatno = pnt.tcKimlikNo      LEFT JOIN [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..[izin] ON @IzinTipi = [izin].IzinTipi AND perbilgi.Personelno = [izin].Personelno         
	  GROUP BY CTE_Groups.Id, GroupId, perbilgi.Personelno, [izin].Basgun        ) TBL  LEFT JOIN [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..[izin] ON tbl.IzinTipi = [izin].IzinTipi      
	  AND tbl.Personelno = [izin].Personelno and [izin].BasGun = TBL.BasGun   where [izin].Basgun is   null   
	  
	  if (@Durum='R')   
	  begin           
	                
	  end      