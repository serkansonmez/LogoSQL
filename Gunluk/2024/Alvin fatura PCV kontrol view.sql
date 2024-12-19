WITH PvcCariData AS (
    SELECT 
        zce.Id,
        zce.ZirveFaturaCari,
        faturaCari.CRK + '|' + faturaCari.STA AS FaturaCariAdi,
        faturaCari.Bakiye AS FaturaBakiye,
        zce.ZirvePvcCari,
        pvcCari.CRK AS PvcCariKodu,
        pvcCari.STA AS PvcCariAdi,
        pvcCari.Bakiye AS PvcBakiye
    FROM 
        [dbo].[ZirveCariEslestirme] zce
    LEFT JOIN 
        vw_ZirveFaturaCari faturaCari ON faturaCari.CRK = zce.ZirveFaturaCari
    CROSS APPLY 
        STRING_SPLIT(zce.ZirvePvcCari, ',') AS splitPvc -- ZirvePvcCari'yi virg�lden ay�r�yoruz
    LEFT JOIN 
        vw_ZirvePvcCari pvcCari ON pvcCari.CRK = splitPvc.value
)
SELECT 
    Id,
    ZirveFaturaCari,
    FaturaCariAdi,
    FaturaBakiye,
    ZirvePvcCari,
    STRING_AGG(PvcCariAdi, ', ') AS PvcCariAdi, -- PvcCari adlar�n� virg�lle birle�tiriyoruz
    SUM(PvcBakiye) AS PvcBakiye -- PvcBakiye toplam�n� hesapl�yoruz
FROM 
    PvcCariData
GROUP BY 
    Id, ZirveFaturaCari, FaturaCariAdi, FaturaBakiye, ZirvePvcCari;
