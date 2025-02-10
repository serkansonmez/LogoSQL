CREATE view [dbo].[VW_PersonelMaliyet] as
SELECT top 10000000
    Yil,
    SicilNo,
    AdiSoyadi,
    TcKimlikNo,
    COALESCE(SUM(CASE WHEN Ay = 1 THEN BrutToplam END), 0) AS Ocak,
    COALESCE(SUM(CASE WHEN Ay = 2 THEN BrutToplam END), 0) AS Subat,
    COALESCE(SUM(CASE WHEN Ay = 3 THEN BrutToplam END), 0) AS Mart,
    COALESCE(SUM(CASE WHEN Ay = 4 THEN BrutToplam END), 0) AS Nisan,
    COALESCE(SUM(CASE WHEN Ay = 5 THEN BrutToplam END), 0) AS Mayis,
    COALESCE(SUM(CASE WHEN Ay = 6 THEN BrutToplam END), 0) AS Haziran,
    COALESCE(SUM(CASE WHEN Ay = 7 THEN BrutToplam END), 0) AS Temmuz,
    COALESCE(SUM(CASE WHEN Ay = 8 THEN BrutToplam END), 0) AS Agustos,
    COALESCE(SUM(CASE WHEN Ay = 9 THEN BrutToplam END), 0) AS Eylul,
    COALESCE(SUM(CASE WHEN Ay = 10 THEN BrutToplam END), 0) AS Ekim,
    COALESCE(SUM(CASE WHEN Ay = 11 THEN BrutToplam END), 0) AS Kasim,
    COALESCE(SUM(CASE WHEN Ay = 12 THEN BrutToplam END), 0) AS Aralik,
    COALESCE(SUM(BrutToplam), 0) AS AylikToplam
FROM PersonelBordro
 
GROUP BY SicilNo, AdiSoyadi, TcKimlikNo,Yil
ORDER BY AdiSoyadi;

select * from PersonelBordro