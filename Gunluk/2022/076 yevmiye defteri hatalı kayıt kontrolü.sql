SET ROWCOUNT 0

SELECT 
GLFIC.*,
GLTRN.*
 FROM 
LG_076_19_EMFICHE GLFIC WITH(NOLOCK)               LEFT OUTER JOIN LG_076_19_EMFLINE GLTRN WITH(NOLOCK) ON (GLFIC.LOGICALREF  =  GLTRN.ACCFICHEREF) LEFT OUTER JOIN LG_076_19_EBOOKDETAILDOC EBOOKDETDO WITH(NOLOCK) ON (GLFIC.LOGICALREF  =  EBOOKDETDO.EMFICHEREF) AND (ISNULL(EBOOKDETDO.EMFLINEREF, 0) = 0) LEFT OUTER JOIN LG_076_EMUHACC GLACC WITH(NOLOCK) ON (GLTRN.ACCOUNTREF  =  GLACC.LOGICALREF) LEFT OUTER JOIN LG_076_19_EBOOKDETAILDOC EBOOKDETDO2 WITH(NOLOCK) ON (GLTRN.LOGICALREF  =  EBOOKDETDO2.EMFLINEREF) AND (ISNULL(EBOOKDETDO2.EMFLINEREF, 0) <> 0) LEFT OUTER JOIN LG_076_EMUHACC GLACC2 WITH(NOLOCK) ON (GLTRN.KEBIRCODE  =  GLACC2.CODE)
 WHERE 
(GLFIC.CANCELLED = 0) AND (NOT (GLFIC.TRCODE IN (5, 8, 10))) AND (GLFIC.JOURNALNO > -1) AND (GLFIC.STATUS = 0) AND (((GLFIC.DATE_ >= CONVERT(dateTime, '1-1-2019', 101)) AND 
(GLFIC.DATE_ <= CONVERT(dateTime, '12-31-2019', 101)))) AND (GLFIC.BRANCH IN (0,35,76)) AND (GLFIC.DEPARTMENT IN (1,3,5,7,9,19,37))
AND JOURNALNO IN ( 4273,4272)
order by JOURNALNO
