  SELECT   
                                         GO3DB..LG_423_01_BNFICHE.LOGICALREF AS KaynakReferans,
                                         GO3DB..LG_423_01_BNFICHE.DATE_ AS Tarih, 
                                           GO3DB..LG_423_01_BNFICHE.FICHENO AS FaturaNo, 
                                          -- dbo.LG_{EskiFirma}_CLCARD.CODE AS CariKodu, dbo.LG_{EskiFirma}_CLCARD.DEFINITION_ AS CariAdi, 
                                          GO3DB..LG_423_01_BNFICHE.SPECODE AS OzelKod, 
                                           GO3DB..LG_423_01_BNFICHE.GENEXP1, 
                                           GO3DB..LG_423_01_BNFICHE.DEBITTOT,GO3DB..LG_423_01_BNFICHE.CREDITTOT
                                        
                                    ,CASE WHEN  CEZVE..LG_323_01_BNFICHE.FICHENO IS NULL THEN 
				                    'Aktarýlmamýþ'
				                    else 
				                    'Ok'
				                    end as AktarimDurumu  
				                     ,DATEPART(yy, GO3DB..LG_423_01_BNFICHE.DATE_) AS Yil, DATEPART(m, GO3DB..LG_423_01_BNFICHE.DATE_) AS Ay, DATEPART(dd, 
                                          GO3DB..LG_423_01_BNFICHE.DATE_) AS Gun
                                     ,CASE LG_423_01_BNFICHE.TRCODE WHEN 1 THEN 'Mal Alim Faturasi' WHEN 2 THEN 'Per.Sat.Ýade Faturasi' WHEN 3 THEN 'Top.Sat.Ýade Faturasi' WHEN
                                       4 THEN 'Alinan Hizmet Faturasi' WHEN 5 THEN 'Alinan Proforma Fatura' WHEN 6 THEN 'Alim Ýade Faturasi' WHEN 7 THEN 'Perakende Satiþ Faturasi' WHEN
                                       8 THEN 'Toptan Satiþ Faturasi' WHEN 9 THEN 'Verilen Hizmet Faturasi ' WHEN 10 THEN 'Verilen Proforma Fatura' WHEN 13 THEN 'Alinan Fiyat Farki Faturasi'
                                       WHEN 14 THEN 'Verilen Fiyat Farki Faturasi' WHEN 26 THEN 'Müstahsil Makbuzu' ELSE 'Tanýmsýz' END AS FaturaTuru
                    FROM         GO3DB..LG_423_01_BNFICHE WITH(NOLOCK) 
                                 
                             --     LEFT OUTER JOIN dbo.LG_{EskiFirma}_CLCARD  WITH(NOLOCK) ON GO3DB..LG_423_01_BNFICHE.CLIENTREF = dbo.LG_{EskiFirma}_CLCARD.LOGICALREF
                                  LEFT JOIN CEZVE..LG_323_01_BNFICHE  WITH(NOLOCK) ON CEZVE..LG_323_01_BNFICHE.FICHENO =  LG_423_01_BNFICHE.FICHENO AND  CEZVE..LG_323_01_BNFICHE.TRCODE = LG_423_01_BNFICHE.TRCODE  
                    WHERE         
                     LG_423_01_BNFICHE.TRCODE IN (1,2,3,4,5,13) AND --ALIM FATURA TÜRLERÝ

                 
                     LG_423_01_BNFICHE.DATE_ BETWEEN  '20231204' AND '20231205' and  CEZVE..LG_323_01_BNFICHE.FICHENO IS NULL
            