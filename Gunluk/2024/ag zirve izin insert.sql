DECLARE @Id INT = 486;
 DECLARE @Yil INT = 2024;  -- Yýl parametresi
 DECLARE @Ay INT = 9;    -- Ay parametresi
DECLARE @Durum NVARCHAR(10) = 'YÝ'; -- Durum parametresi (Yýllýk Ýzin)
DECLARE @IzinTipi int = 7
declare @DynamicDatabase varchar(200) = '[Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]'


;WITH CTE_Processed AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY CAST(SUBSTRING(COLUMN_NAME, 2, LEN(COLUMN_NAME) - 1) AS INT)) AS RowNum,
        CAST(SUBSTRING(COLUMN_NAME, 2, LEN(COLUMN_NAME) - 1) AS INT) AS GunNo
    FROM
        (SELECT Id, [G1], [G2], [G3], [G4], [G5], [G6], [G7], [G8], [G9], [G10],
                     [G11], [G12], [G13], [G14], [G15], [G16], [G17], [G18], [G19], [G20],
                     [G21], [G22], [G23], [G24], [G25], [G26], [G27], [G28], [G29], [G30], [G31]
         FROM [ArGrupB2B_Default_v1]..PuantajTigemExcel
         WHERE Id = @Id) p
    UNPIVOT (Durum FOR COLUMN_NAME IN ([G1], [G2], [G3], [G4], [G5], [G6], [G7], [G8], [G9], [G10],
                                        [G11], [G12], [G13], [G14], [G15], [G16], [G17], [G18], [G19], [G20],
                                        [G21], [G22], [G23], [G24], [G25], [G26], [G27], [G28], [G29], [G30], [G31])) AS Unpvt
    WHERE Durum = @Durum
),
CTE_Groups AS
(
    SELECT
        Id,
        GunNo,
	 
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY GunNo) - GunNo AS GroupId
    FROM CTE_Processed
)
 
SELECT
    perbilgi.Personelno,
    @IzinTipi as IzinTipi,
    MIN(DATEFROMPARTS(@Yil, @Ay, GunNo)) AS Basgun,
    MAX(DATEFROMPARTS(@Yil, @Ay, GunNo)) AS Bitgun,
    cast(COUNT(*) as varchar(20))  AS     aciklama
	,null EksikGunNedeni
	,null IzinBelgesi
	,null HaftalikCalisilmayacakSaat
	,null HaftalikNormalSaat
	,null AylikCalisilanGun
	,null KisaCalismaIlk7GunHesapla
FROM CTE_Groups
left join [ArGrupB2B_Default_v1]..PuantajTigemExcel pnt on pnt.Id = CTE_Groups.Id
left join [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..perbilgi on perbilgi.vatno = pnt.tcKimlikNo
left join [Ý_S_D_ÖZEL_GÜVENLÝK_HÝZMETLERÝ_LTD_ÞTÝ_GENEL]..[izin]  on   @IzinTipi = [izin].IzinTipi and   perbilgi.Personelno =  [izin].Personelno
where [izin].IzinTipi is  null
GROUP BY CTE_Groups.Id, GroupId,perbilgi.Personelno,[izin].Basgun
having   [izin].Basgun = MIN(DATEFROMPARTS(@Yil, @Ay, GunNo)) 
ORDER BY Basgun;
