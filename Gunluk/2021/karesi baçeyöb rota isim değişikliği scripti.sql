SELECT *  FROM OnayMekanizmalari  where PasifMi = 0 and Adi like 'karesi%'

SELECT Adi, replace( Adi, 'karesi','Ba�ey�b')  FROM OnayMekanizmalari  where PasifMi = 0 and Adi like '%karesi%'

update OnayMekanizmalari  set Adi = replace( Adi, 'karesi','Ba�ey�b')  where PasifMi = 0 and Adi like 'karesi%'