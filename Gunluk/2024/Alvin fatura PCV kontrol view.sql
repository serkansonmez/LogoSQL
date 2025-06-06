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
        STRING_SPLIT(zce.ZirvePvcCari, ',') AS splitPvc -- ZirvePvcCari'yi virgülden ayırıyoruz
    LEFT JOIN 
        vw_ZirvePvcCari pvcCari ON pvcCari.CRK = splitPvc.value
)
SELECT 
    Id,
    ZirveFaturaCari,
    FaturaCariAdi,
    FaturaBakiye,
    ZirvePvcCari,
    STRING_AGG(PvcCariAdi, ', ') AS PvcCariAdi, -- PvcCari adlarını virgülle birleştiriyoruz
    SUM(PvcBakiye) AS PvcBakiye -- PvcBakiye toplamını hesaplıyoruz
FROM 
    PvcCariData
GROUP BY 
    Id, ZirveFaturaCari, FaturaCariAdi, FaturaBakiye, ZirvePvcCari;
