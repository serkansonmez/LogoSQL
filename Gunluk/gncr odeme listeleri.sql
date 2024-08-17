DECLARE @Tarih varchar(20) = '20.11.2023'
declare @RaporRef int = 4503
                    select  'UPDATE GINSOFT.dbo.FINANS_ODEME_DETAY SET POSTAKODU = ''' + ISNULL(ISLEMTURU,'') + '''  , TISLEMGRUBU = ''' + ISNULL(GENWEB_ONAYNO,'') + ''' WHERE L_REF=' + CAST(L_REF AS VARCHAR(20))  , ROW_NUMBER() OVER (ORDER BY RAPOR_REF) AS SIRANO  from GINSOFT.DBO.FINANS_ODEME_DETAY analiste
                    LEFT JOIN 
                    ( SELECT DISTINCT ST2.LOGICALREF
                     , substring(
                            ( Select ' ,'+ ISNULL(ST1.GENWEB_ONAYNO,'')  AS [text()]  
                                From (
                                        SELECT DISTINCT dbo.LG_029_CLCARD.LOGICALREF, 
                    CASE WHEN LEN(LG_029_23_STFICHE.SHPAGNCOD) > 2 THEN LG_029_23_STFICHE.SHPAGNCOD
                     ELSE LG_029_23_INVOICE.SHPAGNCOD END AS GENWEB_ONAYNO ,
					 LG_029_23_CLFLINE.SPECODE as ISLEMTURU
                       FROM 
                      dbo.LG_029_23_CLFLINE 
                      LEFT OUTER JOIN  LG_029_CLCARD  on  dbo.LG_029_CLCARD.LOGICALREF = dbo.LG_029_23_CLFLINE.CLIENTREF LEFT OUTER JOIN
                      dbo.LG_029_PAYPLANS ON dbo.LG_029_23_CLFLINE.PAYDEFREF = dbo.LG_029_PAYPLANS.LOGICALREF
                      LEFT OUTER JOIN dbo.LG_029_23_INVOICE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_CLFLINE.SOURCEFREF
                      LEFT OUTER JOIN dbo.LG_029_23_STFICHE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_STFICHE.INVOICEREF
                      WHERE 
                      (dbo.LG_029_PAYPLANS.CODE = @Tarih ) AND (dbo.LG_029_CLCARD.CODE LIKE '320%') 
                      GROUP BY dbo.LG_029_CLCARD.LOGICALREF
                      ,LG_029_23_INVOICE.SHPAGNCOD
					  ,LG_029_23_CLFLINE.SPECODE
                      ,LG_029_23_STFICHE.SHPAGNCOD) ST1
                                Where ST1.LOGICALREF = ST2.LOGICALREF
                                ORDER BY ST1.GENWEB_ONAYNO
                      For XML PATH ('')
                            ), 2, 1000) GENWEB_ONAYNO
 
                         , substring(
                            ( Select ' ,'+ ISNULL(ST1.ISLEMTURU,'')  AS [text()]  
                                From (
                                        SELECT DISTINCT dbo.LG_029_CLCARD.LOGICALREF, 
                   
					 LG_029_23_CLFLINE.SPECODE as ISLEMTURU
                       FROM 
                      dbo.LG_029_23_CLFLINE 
                      LEFT OUTER JOIN  LG_029_CLCARD  on  dbo.LG_029_CLCARD.LOGICALREF = dbo.LG_029_23_CLFLINE.CLIENTREF LEFT OUTER JOIN
                      dbo.LG_029_PAYPLANS ON dbo.LG_029_23_CLFLINE.PAYDEFREF = dbo.LG_029_PAYPLANS.LOGICALREF
                      LEFT OUTER JOIN dbo.LG_029_23_INVOICE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_CLFLINE.SOURCEFREF
                      LEFT OUTER JOIN dbo.LG_029_23_STFICHE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_STFICHE.INVOICEREF
                      WHERE 
                      (dbo.LG_029_PAYPLANS.CODE = @Tarih ) AND (dbo.LG_029_CLCARD.CODE LIKE '320%') 
                      GROUP BY dbo.LG_029_CLCARD.LOGICALREF
                      ,LG_029_23_INVOICE.SHPAGNCOD
					  ,LG_029_23_CLFLINE.SPECODE
                      ,LG_029_23_STFICHE.SHPAGNCOD) ST1
                                Where ST1.LOGICALREF = ST2.LOGICALREF
                                ORDER BY ST1.ISLEMTURU
                      For XML PATH ('')
                            ), 2, 1000) ISLEMTURU
 
                     from 
                     (SELECT DISTINCT dbo.LG_029_CLCARD.LOGICALREF
                       FROM 
                      dbo.LG_029_23_CLFLINE 
                      LEFT OUTER JOIN  LG_029_CLCARD  on  dbo.LG_029_CLCARD.LOGICALREF = dbo.LG_029_23_CLFLINE.CLIENTREF LEFT OUTER JOIN
                      dbo.LG_029_PAYPLANS ON dbo.LG_029_23_CLFLINE.PAYDEFREF = dbo.LG_029_PAYPLANS.LOGICALREF
                      LEFT OUTER JOIN dbo.LG_029_23_INVOICE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_CLFLINE.SOURCEFREF
                      LEFT OUTER JOIN dbo.LG_029_23_STFICHE ON dbo.LG_029_23_INVOICE.LOGICALREF = dbo.LG_029_23_STFICHE.INVOICEREF
                      WHERE 
                      (dbo.LG_029_PAYPLANS.CODE = @Tarih ) AND (dbo.LG_029_CLCARD.CODE LIKE '320%') 
                      GROUP BY dbo.LG_029_CLCARD.LOGICALREF ) ST2

                    ) as altListe on analiste.LOGO_REF = altListe.LOGICALREF
                   -- WHERE RAPOR_REF=@RaporRef