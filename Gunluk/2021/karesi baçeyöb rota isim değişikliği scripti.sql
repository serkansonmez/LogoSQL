SELECT *  FROM OnayMekanizmalari  where PasifMi = 0 and Adi like 'karesi%'

SELECT Adi, replace( Adi, 'karesi','Baçeyöb')  FROM OnayMekanizmalari  where PasifMi = 0 and Adi like '%karesi%'

update OnayMekanizmalari  set Adi = replace( Adi, 'karesi','Baçeyöb')  where PasifMi = 0 and Adi like 'karesi%'