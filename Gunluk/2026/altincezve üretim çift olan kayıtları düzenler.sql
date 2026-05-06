UPDATE UretimEmri
SET FicheNo = FicheNo + '_IPT'
WHERE UretimEmriId IN (
    SELECT u1.UretimEmriId
    FROM UretimEmri u1
    WHERE u1.FicheNo LIKE '2601.%'
    AND u1.SarfFisiNo IS NULL
    AND EXISTS (
        SELECT 1 
        FROM UretimEmri u2 
        WHERE u2.FicheNo = u1.FicheNo 
        AND u2.UretimEmriId <> u1.UretimEmriId
        AND u2.SarfFisiNo IS NOT NULL
    )
    AND u1.FicheNo NOT LIKE '%_IPT%'
);