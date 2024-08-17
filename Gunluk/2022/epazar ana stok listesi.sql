SELECT  
                                        Stok.a_marka AS Marka,
	                                    CAST(0 AS BIT) as a_sec,
	                                    Stok.a_id,ISNULL(Estok.Id,0) as Id,
	                                    Stok.a_mdate + Convert( datetime , cast(Stok.a_mtime as time)) AS a_mdatetime, 
	                                    Stok.a_adi,
                                        Stok.a_kod AS StokKod , 
                                        ISNULL(Estok.OCartId,0) as OCartId , 
	                                    OpenCartStok.Name AS OpenCart,
	                                    OpenCartStok.Price AS OCPrice,
	                                    OpenCartStok.SpecPrice,
                                        ISNULL(Estok.N11Id,'0') as  N11Id , 
	                                    N11Stok.Title AS N11,
	                                    N11Stok.Price, 
	                                    N11Stok.DisplayPrice, 
                                        ISNULL(EpttStok.UrunId, 0) AS EpttId, 
                                        ISNULL(EpttStok.UrunAdi, N'') AS EpttName, 
                                        ISNULL(EpttStok.KDVsiz, 0) * (ISNULL(EpttStok.KDVOran, 0) / 100 + 1) AS EpttPrice, 
                                        (ISNULL(EpttStok.KDVsiz, 0) * (ISNULL(EpttStok.KDVOran, 0) / 100 + 1)) * (CASE ISNULL(EpttStok.Iskonto, 0) WHEN 0 THEN 100 ELSE EpttStok.Iskonto END / 100) AS EpttSpecPrice ,
										ISNULL(Estok.GGId,0)  AS GGId,
                                        GGStok.Title AS GgName,
	                                    CASE WHEN GGStok.MarketPrice = 0 THEN GGStok.BuyNowPrice ELSE GGStok.MarketPrice END AS MarketPrice ,
                                        GGStok.BuyNowPrice,
                                        ISNULL(Estok.TrendId,'0') as TrendId ,
                                        TrendStok.Title AS TrendName,
                                        TrendStok.ListPrice AS ListPrice,
                                        TrendStok.SalePrice AS SalePrice,
                                        ISNULL(Estok.EticaretId,0) as EticaretId , 
	                                    EticaretStok.Name AS Eticaret,
	                                    EticaretStok.Price AS EticaretPrice,
	                                    EticaretStok.SpecPrice EticaretSpecPrice,
										ISNULL(HBStok.HepsiburadaSku,'') AS HbId ,
										ISNULL(HBSL.UrunAdi,'') AS HbName ,
										ISNULL(HBStok.Price,0) AS HbPrice,
										ISNULL(CsProducts.stockCode,'') AS CsId ,
										ISNULL(CsProducts.productName,'') AS CsName ,
										ISNULL(CsProducts.listPrice,0) AS CsPrice,
										ISNULL(CsProducts.salesPrice,0) AS CsSpecPrice,
										ISNULL(Estok.Eticaret2Id,0) as Eticaret2Id , 
	                                    Eticaret2Stok.Name AS Eticaret2,
	                                    Eticaret2Stok.Price AS Eticaret2Price,
	                                    Eticaret2Stok.SpecPrice Eticaret2SpecPrice
                                    FROM  
    tbl_001_stok AS Stok  
    INNER JOIN tbl_doviz  ON tbl_doviz.a_id = Stok.a_sfkurid 
    LEFT JOIN tbl_001_EPazar_Stok AS Estok ON Estok.StokId = Stok.a_id
    LEFT JOIN tbl_001_EPazar_OpenCartStok AS OpenCartStok  ON OpenCartStok.Id = Estok.OCartId 
    LEFT JOIN tbl_001_EPazar_N11Stok AS N11Stok ON Estok.N11Id = N11Stok.Id 
    LEFT JOIN tbl_001_EPazar_EpttStok AS EpttStok ON Estok.EpttId = EpttStok.UrunId 
	LEFT JOIN tbl_001_EPazar_GgStok AS GGStok ON GGStok.ProductId = Estok.GGId  
    LEFT JOIN tbl_001_EPazar_TrendStok AS TrendStok ON TrendStok.Id = Estok.TrendId 
    LEFT JOIN tbl_001_EPazar_EticaretStok AS EticaretStok ON EticaretStok.Id = Estok.EticaretId 
    LEFT JOIN tbl_001_Epazar_Eticaret2Stok AS Eticaret2Stok ON Eticaret2Stok.Id = Estok.Eticaret2Id
	LEFT JOIN tbl_001_Epazar_HbProduct_Listing AS HBStok ON HBStok.HepsiburadaSku = Estok.HbId 
	LEFT JOIN tbl_001_Epazar_HbProduct_List AS HBSL ON HBSL.HepsiburadaSku = HBStok.HepsiburadaSku
    LEFT JOIN tbl_001_EPazar_CsProducts AS CsProducts ON CsProducts.stockCode = Estok.CsId
WHERE Stok.a_id <>0 AND Stok.a_eticaret =1   AND Stok.a_reftip <> 'T'  and SalePrice = 3894.74   AND Stok.a_akpas = N'Aktif'
                                   