
                    SELECT   
                                         dbo.LG_029_20_INVOICE.LOGICALREF AS KaynakReferans,
                                         dbo.LG_029_20_INVOICE.DATE_ AS Tarih, 
                                           dbo.LG_029_20_INVOICE.FICHENO AS FaturaNo, 
                                           dbo.LG_029_CLCARD.CODE AS CariKodu, dbo.LG_029_CLCARD.DEFINITION_ AS CariAdi, 
                                          dbo.LG_029_20_INVOICE.SPECODE AS OzelKod, 
                                           dbo.LG_029_20_INVOICE.NETTOTAL AS Tutar, 
                                           CAST( dbo.L_CAPIDIV.NR AS VARCHAR(5)) + ' - ' + dbo.L_CAPIDIV.NAME AS IsyeriAdi, 
                                          CAST(dbo.L_CAPIDEPT.NR  AS VARCHAR(5)) + ' - ' + dbo.L_CAPIDEPT.NAME AS BolumAdi
                                    ,CASE WHEN  LG_106_20_INVOICE.FICHENO IS NULL THEN 
				                    'Aktarýlmamýþ'
				                    else 
				                    'Ok'
				                    end as AktarimDurumu  
				                     ,DATEPART(yy, dbo.LG_029_20_INVOICE.DATE_) AS Yil, DATEPART(m, dbo.LG_029_20_INVOICE.DATE_) AS Ay, DATEPART(dd, 
                                          dbo.LG_029_20_INVOICE.DATE_) AS Gun
                                     ,CASE LG_029_20_INVOICE.TRCODE WHEN 1 THEN 'Mal Alim Faturasi' WHEN 2 THEN 'Per.Sat.Ýade Faturasi' WHEN 3 THEN 'Top.Sat.Ýade Faturasi' WHEN
                                       4 THEN 'Alinan Hizmet Faturasi' WHEN 5 THEN 'Alinan Proforma Fatura' WHEN 6 THEN 'Alim Ýade Faturasi' WHEN 7 THEN 'Perakende Satiþ Faturasi' WHEN
                                       8 THEN 'Toptan Satiþ Faturasi' WHEN 9 THEN 'Verilen Hizmet Faturasi ' WHEN 10 THEN 'Verilen Proforma Fatura' WHEN 13 THEN 'Alinan Fiyat Farki Faturasi'
                                       WHEN 14 THEN 'Verilen Fiyat Farki Faturasi' WHEN 26 THEN 'Müstahsil Makbuzu' ELSE 'Tanýmsýz' END AS FaturaTuru
                                       ,CASE WHEN LG_029_20_INVOICE.ACCOUNTED = 1 THEN 'M' else '' end as Muhasebelesme
                                      ,dbo.LG_029_20_INVOICE.SHPAGNCOD AS GenwebOnayNo  
                                      ,isnull(Onay.TalepTutari,0) as OnayTutari
                                      ,LG_029_20_INVOICE.GROSSTOTAL as BrutTutar

                    FROM         dbo.LG_029_20_INVOICE WITH(NOLOCK) 
                                  LEFT OUTER JOIN  dbo.L_CAPIDEPT  WITH(NOLOCK) on LG_029_20_INVOICE.DEPARTMENT = L_CAPIDEPT.NR	
                                  LEFT OUTER JOIN  dbo.L_CAPIDIV  WITH(NOLOCK) ON dbo.LG_029_20_INVOICE.BRANCH = dbo.L_CAPIDIV.NR 
                                  LEFT OUTER JOIN dbo.LG_029_CLCARD  WITH(NOLOCK) ON dbo.LG_029_20_INVOICE.CLIENTREF = dbo.LG_029_CLCARD.LOGICALREF
                                  LEFT JOIN LG_106_20_INVOICE  WITH(NOLOCK) ON 
								  LG_106_20_INVOICE.FICHENO = LG_029_20_INVOICE.FICHENO AND  LG_106_20_INVOICE.TRCODE = LG_029_20_INVOICE.TRCODE   
								  --AND LG_106_20_INVOICE.BRANCH = LG_029_20_INVOICE.BRANCH   
                                  LEFT JOIN GINSOFT_NET_PROD.dbo.OnayTalepleri Onay WITH(NOLOCK) ON Onay.id = case when ISNUMERIC(dbo.LG_029_20_INVOICE.SHPAGNCOD)=1 THEN   
																												     cast(dbo.LG_029_20_INVOICE.SHPAGNCOD as int) ELSE 0 END
																										 

                    WHERE     (dbo.L_CAPIDIV.FIRMNR = 029) AND (dbo.L_CAPIDEPT.FIRMNR = 029)
                    AND LG_029_20_INVOICE.TRCODE IN (1,2,3,4,5,6,13) --ALIM FATURA TÜRLERÝ
                    AND LG_029_20_INVOICE.FROMKASA = 0
                    AND LG_029_20_INVOICE.BRANCH = 29 -- ÝÞYERÝ
                    AND LG_029_20_INVOICE.DEPARTMENT IN  (3,1,5,7,9,37) -- BÖLÜM  =   + cmbBolum.SelectedItem.Value.ToString()
                    AND LG_029_20_INVOICE.DATE_ BETWEEN '20200101'  AND  '20200825'
 and  LG_106_20_INVOICE.FICHENO IS NULL 