USE [AltinCezveB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_BankaFisleriAktarim_24]    Script Date: 31.01.2024 12:48:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 --alter view VW_BankaHesaplariKarsilastirmaDetayli_24 as 

with tblListe as ( 
 SELECT  TOP 10000000  LG_324_01_BNFLINE.LOGICALREF,
                                         CEZVE..LG_324_01_BNFICHE.LOGICALREF AS KaynakReferans,
                                         CEZVE..LG_324_01_BNFICHE.DATE_ AS Tarih, 
                                           CEZVE..LG_324_01_BNFICHE.FICHENO AS FisNo, 
                                          -- dbo.LG_{EskiFirma}_CLCARD.CODE AS CariKodu, dbo.LG_{EskiFirma}_CLCARD.DEFINITION_ AS CariAdi, 
                                          CEZVE..LG_324_01_BNFICHE.SPECODE AS OzelKod, 
                                           CEZVE..LG_324_01_BNFICHE.GENEXP1 as  Aciklama, 
                                           CEZVE..LG_324_01_BNFICHE.DEBITTOT as Borc,
										   CEZVE..LG_324_01_BNFICHE.CREDITTOT as Alacak
                                        
                                    ,CASE WHEN  GO3DB..LG_424_01_BNFICHE.FICHENO IS NULL THEN 
				                    'Aktarýlmamýþ'
				                      WHEN   LG_424_01_BNFICHE.FICHENO = LG_324_01_BNFICHE.SPECODE  tHEN
				                    'Ok'
									else  'Aktarýlmamýþ'
				                    end as AktarimDurumu  
				                     --,DATEPART(yy, CEZVE..LG_324_01_BNFICHE.DATE_) AS Yil, DATEPART(m, CEZVE..LG_324_01_BNFICHE.DATE_) AS Ay, DATEPART(dd, 
                         --                 CEZVE..LG_324_01_BNFICHE.DATE_) AS Gun
                                     ,CASE LG_324_01_BNFICHE.TRCODE WHEN 1 THEN 'Banka Ýþlem Fiþi' WHEN 2 THEN 'Banka Virman Fiþi' WHEN 3 THEN 'Gelen Havale / Eft' WHEN
                                       4 THEN 'Gönderilen Havale / Eft' WHEN 5 THEN 'Banka Açýlýþ Fiþi' WHEN 6 THEN 'Banka Kur Farký Fiþi' WHEN 7 THEN 'Döviz Alýþ Belgesi' WHEN
                                       8 THEN 'Döviz Satýþ Belgesi' WHEN 16 THEN 'Banka Alýnan Hizmet Faturasý ' WHEN 17 THEN 'Banka Verilen Hizmet Faturasý' WHEN 18 THEN 'Bankadan Çek Ödemesi'
                                       WHEN 19 THEN 'Bankadan Senet Ödemesi' WHEN 26 THEN 'Müstahsil Makbuzu' ELSE 'Tanýmsýz' END AS FaturaTuru 
,LG_324_BNCARD.CODE + ' / ' + LG_324_BNCARD.DEFINITION_  TigerBanka
,LG_424_BNCARD.CODE + ' / ' + LG_424_BNCARD.DEFINITION_  Go3Banka
,LG_324_BANKACC.CODE + ' / ' + LG_324_BANKACC.DEFINITION_  TigerBankaHesap
,LG_424_BANKACC.CODE + ' / ' + LG_424_BANKACC.DEFINITION_  Go3BankaHesap

,LG_324_CLCARD.CODE + ' / ' + LG_324_CLCARD.DEFINITION_  TigerCariHesap
,LG_424_CLCARD.CODE + ' / ' + LG_424_CLCARD.DEFINITION_  Go3CariHesap

 ,LG_324_01_BNFLINE.ACCOUNTREF
 ,LG_324_01_BNFLINE.BNACCOUNTREF
--,LG_324_EMUHACC.CODE + ' / ' + LG_324_EMUHACC.DEFINITION_  TigerMuhasebeHesap
--,LG_424_EMUHACC.CODE + ' / ' + LG_424_EMUHACC.DEFINITION_  Go3MuhasebeHesap

                    FROM  CEZVE..LG_324_01_BNFICHE WITH(NOLOCK) 
					    LEFT JOIN CEZVE..LG_324_01_BNFLINE WITH(NOLOCK) ON LG_324_01_BNFLINE.SOURCEFREF = LG_324_01_BNFICHE.LOGICALREF
                                 LEFT JOIN CEZVE..LG_324_BANKACC ON LG_324_BANKACC.LOGICALREF = LG_324_01_BNFLINE.BNACCREF
								 LEFT JOIN GO3DB..LG_424_BANKACC ON LG_324_BANKACC.CYPHCODE = LG_424_BANKACC.CODE

								 LEFT JOIN CEZVE..LG_324_BNCARD ON LG_324_BNCARD.LOGICALREF = LG_324_01_BNFLINE.BANKREF
								 LEFT JOIN GO3DB..LG_424_BNCARD ON LG_424_BNCARD.CODE = LG_324_BNCARD.SPECODE

								  LEFT JOIN CEZVE..LG_324_CLCARD ON LG_324_CLCARD.LOGICALREF = LG_324_01_BNFLINE.CLIENTREF
								 LEFT JOIN GO3DB..LG_424_CLCARD ON LG_424_CLCARD.CODE = LG_324_CLCARD.CODE

							    LEFT JOIN CEZVE..LG_324_EMUHACC ON LG_324_EMUHACC.LOGICALREF = LG_324_01_BNFLINE.ACCOUNTREF
								 LEFT JOIN GO3DB..LG_424_EMUHACC ON LG_424_EMUHACC.CODE = LG_324_EMUHACC.CODE
								 
                             --     LEFT OUTER JOIN dbo.LG_{EskiFirma}_CLCARD  WITH(NOLOCK) ON CEZVE..LG_324_01_BNFICHE.CLIENTREF = dbo.LG_{EskiFirma}_CLCARD.LOGICALREF
                                  LEFT JOIN GO3DB..LG_424_01_BNFICHE  WITH(NOLOCK) ON GO3DB..LG_424_01_BNFICHE.FICHENO =  LG_324_01_BNFICHE.FICHENO AND  
								                                                      GO3DB..LG_424_01_BNFICHE.TRCODE = LG_324_01_BNFICHE.TRCODE    
																					   
                    WHERE         
                     LG_324_01_BNFICHE.TRCODE IN (1,2,3,4,5,13) AND --ALIM FATURA TÜRLERÝ

					  LG_324_01_BNFICHE.LOGICALREF = 371 AND
                 
                     LG_324_01_BNFICHE.DATE_  >=  '20240101'  --and  GO3DB..LG_424_01_BNFICHE.FICHENO IS   NULL
            AND  LG_324_01_BNFLINE.LOGICALREF is not null
			order by LG_324_01_BNFLINE.LOGICALREF)


			select *,
			case when Go3Banka is null then 'Go3 Banka Eksik Go3 Banka Kodunu, Tiger Banka ' + TigerBanka + ' Özel Kod alanýna yazýn, ' else '' end + 
			case when Go3BankaHesap is null then 'Go3 Banka Hesabý Eksik Go3 Banka Kodunu, Tiger Banka hesabýndaki  ' + TigerBankaHesap + ' Yetki Kod alanýna yazýn, ' else '' end +
			case when TigerCariHesap is not null and Go3CariHesap is null then 'Go3 Cari Hesabý eksik, Tigerdaki Cari Kodu ' + TigerCariHesap + ' Go3teki Cari Kod alanýna yazýn veya yeni cari kart açýn ' else '' end as Uyarýlar 
			from tblListe
/*
			select * from  CEZVE..LG_324_01_BNFICHE WHERE BNACCOUNTREF = 57
			select * from  GO3DB..LG_424_CLCARD WHERE DEFINITION_ LIKE 'SÝNA%'
			UPDATE GO3DB..LG_424_CLCARD SET CODE = '120.01.217' WHERE LOGICALREF = 2908
			select * from CEZVE..LG_324_EMUHACCSUBACCASGN WHERE LOGICALREF = 57

			select * from CEZVE..LG_324_EMUHACCS WHERE LOGICALREF = 57

			select CLIENTREF ,LG_324_01_BNFLINE.ACCOUNTREF
 ,LG_324_01_BNFLINE.BNACCOUNTREF, * from CEZVE..LG_324_01_BNFLINE WHERE LOGICALREF= 752
			select * from CEZVE..LG_324_CLCARD WHERE DEFINITION_ LIKE '%FÝNANS%' LOGICALREF= 3214
			SELECT * FROM CEZVE..L_CAPIFIRM
			SELECT * FROM CEZVE..LG_318_EMUHACC WHERE LOGICALREF IN (16,30)

			SELECT * FROM GO3DB..LG_424_EMUHACC WHERE CODE IN ('102.01.F01','120.01')
			289,558

			*/
GO


