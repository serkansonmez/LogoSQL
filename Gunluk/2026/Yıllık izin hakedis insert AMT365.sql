-- PersonelHakedis tablosuna veri ekleme scripti
-- Excel'deki yapýya göre her personelin her yýl için hakediþ bilgileri

INSERT INTO [dbo].[PersonelHakedis] 
    ([TcKimlikNo], [HakedisTarihi], [HakedisGunSayisi], [Aciklama], [IzinYili])
VALUES
    -- ASLI SÝBEL ÜZÜMCÜ - 2025 yýlý hakediþi
    ('15847466056', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- DÝLARA PÝÞMEK - 2025 yýlý hakediþi
    ('59149305590', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- ELÝF BERFÝN TATLI - 2025-2026 yýllarý hakediþleri
    ('37387315816', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('37387315816', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2025),
    ('37387315816', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2025),
    ('37387315816', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2026),
    
    -- EMÝNE KIRIÞ - 2026 yýlý hakediþi
    ('50398759400', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2026),
    
    -- FATÝH GENÇ - 2025 yýlý hakediþi
    ('42092042216', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- GÝZEM SARI - Çoklu yýl hakediþleri
    ('11849179864', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2021),
    ('11849179864', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2022),
    ('11849179864', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2023),
    ('11849179864', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- GÖKÇE KEL - Çoklu yýl hakediþleri
    ('17504168518', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2023),
    ('17504168518', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2024),
    ('17504168518', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2025),
    ('17504168518', GETDATE(), 4, 'Yýllýk Ýzin Hakediþi', 2025),
    ('17504168518', GETDATE(), 0.5, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- HALÝL YANAR - 2024 yýlý hakediþi
    ('13393854242', GETDATE(), 7, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- LEMAN ÞEN - 2025 yýlý hakediþi
    ('32509820032', GETDATE(), 12, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- TUÐBA ÞAHÝNOÐLU - 2025-2026 yýllarý hakediþleri
    ('33863137644', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('33863137644', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('33863137644', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('33863137644', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2026),
    
    -- UÐUR DURMUÞ (ASC MÝMARLIK) - 2024 yýlý hakediþi
    ('48853760764', GETDATE(), 10, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- ÜMRAN SARÐIN - Çoklu yýl hakediþleri (2018-2023)
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2018),
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2019),
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2020),
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2021),
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2022),
    ('23092478410', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2023),
    
    -- ECE GÜLER - 2025 yýlý hakediþi
    ('19940253834', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- GAMZE ÞENER - 2025 yýlý hakediþi
    ('17579348228', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- ÝREM DEMÝREL - 2025-2026 yýllarý hakediþleri
    ('60544359118', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('60544359118', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2025),
    ('60544359118', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2026),
    
    -- ABDURRAHMAN ÇELÝK - Çoklu yýl hakediþleri
    ('23299696242', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2022),
    ('23299696242', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2023),
    ('23299696242', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- AHMET SEVÝNÇ - 2022 yýlý hakediþi
    ('26206641748', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2022),
    
    -- ALÝ YILDIZ - 2024-2025 yýllarý hakediþleri
    ('10703434552', GETDATE(), 8, 'Yýllýk Ýzin Hakediþi', 2024),
    ('10703434552', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- AZÝZ AYTEK - 2025 yýlý hakediþi
    ('11534090924', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- BERKAN PARLAK - Çoklu yýl hakediþleri
    ('69406034620', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2021),
    ('69406034620', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2022),
    ('69406034620', GETDATE(), 30, 'Yýllýk Ýzin Hakediþi', 2023),
    ('69406034620', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2024),
    ('69406034620', GETDATE(), 0.5, 'Yýllýk Ýzin Hakediþi', 2025),
    ('69406034620', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('69406034620', GETDATE(), 7, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- BURAKCAN ÝNCESÖZ - 2025-2026 yýllarý hakediþleri
    ('57859240156', GETDATE(), 6, 'Yýllýk Ýzin Hakediþi', 2025),
    ('57859240156', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2026),
    
    -- ESRANUR TUTKUN - 2025 yýlý hakediþi
    ('26590683942', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- FATMA NUR ERASLAN - 2025 yýlý hakediþleri
    ('14354997596', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('14354997596', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- FEYZA NUR ÇINAR - 2025 yýlý hakediþi
    ('35971166592', GETDATE(), 6, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- KÜRÞAT NEHÝR - 2025 yýlý hakediþleri
    ('45790049402', GETDATE(), 4, 'Yýllýk Ýzin Hakediþi', 2025),
    ('45790049402', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- MEHMET GARÝP KARKÝN (CASTOR) - 2024 yýlý hakediþi
    ('46270279906', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- MÝHRÝBAN AYNACI - Çoklu yýl hakediþleri
    ('25406326288', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2023),
    ('25406326288', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2024),
    ('25406326288', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2024),
    ('25406326288', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('25406326288', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2025),
    ('25406326288', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- ÖZKAN YAÐIZ - Çoklu yýl hakediþleri (2018-2024)
    ('46198653406', GETDATE(), 7, 'Yýllýk Ýzin Hakediþi', 2018),
    ('46198653406', GETDATE(), 6, 'Yýllýk Ýzin Hakediþi', 2019),
    ('46198653406', GETDATE(), 20, 'Yýllýk Ýzin Hakediþi', 2021),
    ('46198653406', GETDATE(), 6, 'Yýllýk Ýzin Hakediþi', 2022),
    ('46198653406', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2023),
    ('46198653406', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2023),
    ('46198653406', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2023),
    ('46198653406', GETDATE(), 6, 'Yýllýk Ýzin Hakediþi', 2024),
    ('46198653406', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2024),
    ('46198653406', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2024),
    ('46198653406', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2024),
    
    -- TURGAY ERDOÐAN - 2025 yýlý hakediþleri
    ('28039040590', GETDATE(), 3, 'Yýllýk Ýzin Hakediþi', 2025),
    ('28039040590', GETDATE(), 1, 'Yýllýk Ýzin Hakediþi', 2025),
    ('28039040590', GETDATE(), 5, 'Yýllýk Ýzin Hakediþi', 2025),
    
    -- UÐUR DURMUÞ (CASTOR) - 2023-2024 yýllarý hakediþleri
    ('48853760764', GETDATE(), 14, 'Yýllýk Ýzin Hakediþi', 2023),
    ('48853760764', GETDATE(), 2, 'Yýllýk Ýzin Hakediþi', 2024);

-- NOT: 
-- 1. [HakedisTarihi] için GETDATE() kullanýldý, gerçek tarihler Excel'de bulunmadýðý için
-- 2. [Id] sütunu identity ise otomatik atanacaktýr
-- 3. Sadece izin kullanmýþ personeller eklendi (kullanýlan gün sayýsý > 0 olanlar)
-- 4. Excel'de ayný TC kimlik numarasýna sahip farklý personeller olduðu için dikkatli olunmalý